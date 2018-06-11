function draw_netdown_graph()
        cairo_set_source_rgba(cr,rgb_to_r_g_b(color, alpha))
        calculate_netdown_table()
        for i = 1, netdown_table_length do
                draw_line_in_circle(netdown_radius - (netdown_circle_width / 2), (netdown_circle_width / 100) * netdown_table[i], 4, (360 / netdown_table_length) * (i - 1), -1, 0, 10, 10)
        end
end

function calculate_netdown_table()
        for i = 1, netdown_table_length do
                if netdown_table[i] == nil then
                        netdown_table[i] = 0
                end
        end
        for i = netdown_table_length, 2, -1 do
                netdown_table[i] = netdown_table[i - 1]
        end
        netdown_value = tonumber(conky_parse("${downspeedf eth0}")/1000)
        if netdown_value ~= nil then
                netdown_table[1] = netdown_value
        else
                netdown_table[1] = 0
        end
end
