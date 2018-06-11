function draw_netup_graph()
        cairo_set_source_rgba(cr,rgb_to_r_g_b(color, alpha))
        calculate_netup_table()
        for i = 1, netup_table_length do
                draw_line_in_circle(netup_radius - (netup_circle_width / 2), (netup_circle_width / 100) * netup_table[i], 4, (360 / netup_table_length) * (i - 1), 1, 50, 10, 200)
        end
end

function calculate_netup_table()
        for i = 1, netup_table_length do
                if netup_table[i] == nil then
                        netup_table[i] = 0
                end
        end
        for i = netup_table_length, 2, -1 do
                netup_table[i] = netup_table[i - 1]
        end
        netup_value = tonumber(conky_parse("${upspeedf eth0}"))
        if netup_value ~= nil then
                netup_table[1] = netup_value
        else
                netup_table[1] = 0
        end
end
