--function rgb_to_r_g_b(color,alpha)
--return ((0xa5adff / 0x10000) % 0x100) / 255., ((0xa5adff / 0x100) % 0x100) / 255., (0xa5adff % 0x100) / 255., 1
--end

function draw_graph (conky_value, table_length, radius, circle_width, table)
--        cairo_set_source_rgba(cr,rgb_to_r_g_b(color, alpha))
	-- calculate table
        for i = 1, table_length do
                if table[i] == nil then
                        table[i] = 0
                end
        end
        for i = table_length, 2, -1 do
                table[i] = table[i - 1]
        end
        value = tonumber(conky_parse(conky_value))
        if value ~= nil then
                table[1] = value
        else
                table[1] = 0
        end
	-- end calculate table
	
        for i = 1, table_length do
                draw_line_in_circle(radius - (circle_width / 2), (circle_width / 100) * table[i], 4, (360 / table_length) * (i - 1), -1)
        end
end

function draw_line_in_circle(offset, length, width, degree)

	cairo_set_line_width(cr, width)
        point = (math.pi / 180) * degree
        start_x = 0 + (offset * math.sin(point))
        start_y = 0 - (offset * math.cos(point))
        end_x = 0 + ((offset + length) * math.sin(point))
        end_y = 0 - ((offset + length) * math.cos(point))

	p = cairo_pattern_create_linear(0, 0, 100, 100)
	cairo_pattern_add_color_stop_rgb(p, 0, 0, 1, 0)
	cairo_pattern_add_color_stop_rgb(p, 1, 1, 0, 0)
	cairo_set_source(cr, p)


        cairo_move_to(cr, start_x + center_x, start_y + center_y)
        cairo_line_to(cr, end_x + center_x, end_y + center_y)
        -- cairo_set_source_rgb (cr, 0, 0, 50);
        cairo_stroke(cr)

	cairo_pattern_destroy(p);

end


