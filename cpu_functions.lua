function draw_cpu_graph()
        cairo_set_source_rgba(cr,rgb_to_r_g_b(color, alpha))
        calculate_cpu_table()
        for i = 1, cpu_table_length do
                draw_line_in_circle(cpu_radius - (cpu_circle_width / 2), (cpu_circle_width / 100) * cpu_table[i], 4, (360 / cpu_table_length) * (i - 1), -1, 0, 10, 10)
        end
end

function calculate_cpu_table()
        for i = 1, cpu_table_length do
                if cpu_table[i] == nil then
                        cpu_table[i] = 0
                end
        end
        for i = cpu_table_length, 2, -1 do
                cpu_table[i] = cpu_table[i - 1]
        end
        cpu_value = tonumber(conky_parse("$cpu"))
        if cpu_value ~= nil then
                cpu_table[1] = cpu_value
        else
                cpu_table[1] = 0
        end
end
