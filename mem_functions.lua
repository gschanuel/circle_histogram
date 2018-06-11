function draw_mem_graph()
        cairo_set_source_rgba(cr,rgb_to_r_g_b(color, alpha))
        calculate_mem_table()
        for i = 1, mem_table_length do
                draw_line_in_circle(mem_radius - (mem_circle_width / 2), (mem_circle_width / 100) * mem_table[i], 4, (360 / mem_table_length) * (i - 1), -1)
        end
end

function calculate_mem_table()
        for i = 1, mem_table_length do
                if mem_table[i] == nil then
                        mem_table[i] = 0
                end
        end
        for i = mem_table_length, 2, -1 do
                mem_table[i] = mem_table[i - 1]
        end
        mem_value = tonumber(conky_parse("$memperc"))
        if mem_value ~= nil then
                mem_table[1] = mem_value
        else
                mem_table[1] = 0
        end
end
