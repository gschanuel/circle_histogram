function hex2rgb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function draw_graph (conky_value, table_length, radius, circle_width, table, line_width, start_point, start_color, end_color)

	start_color = start_color or "#00FF00"
	end_color = end_color or "#FF0000"


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

		-- draw_line_in_circle(radius - (circle_width / 2), (circle_width / 100) * table[i], line_width, (360 / table_length) * (i - 1), circle_width, start_point )
                offset = radius - (circle_width / 2)
		length = (circle_width / 100) * table[i]
		degree = (360 / table_length) * (i - 1)
		-- draw circle
		start_point = start_point or 0
		cairo_set_line_width(cr, line_width)
		point = (math.pi / 180) * degree - start_point
		start_x = 0 + (offset * math.sin(point))
		start_y = 0 - (offset * math.cos(point))
		end_x = 0 + ((offset + length) * math.sin(point))
		end_y = 0 - ((offset + length) * math.cos(point))
		end_xp = 0 + (offset + circle_width) * math.sin(point)
		end_yp = 0 - (offset + circle_width) * math.cos(point)

		p = cairo_pattern_create_linear(start_x + center_x, start_y + center_y, end_xp + center_x, end_yp + center_y)

		cairo_pattern_add_color_stop_rgb(p, 0, hex2rgb(start_color))
		cairo_pattern_add_color_stop_rgb(p, 1, hex2rgb(end_color))
		cairo_set_source(cr, p)

		cairo_move_to(cr, start_x + center_x, start_y + center_y)
		cairo_line_to(cr, end_x + center_x, end_y + center_y)
		cairo_stroke(cr)

		cairo_pattern_destroy(p);
		-- end draw circle
	
	end
end

function draw_line_in_circle(offset, length, width, degree, circle_width, start_point)
	start_point = start_point or 0 
	cairo_set_line_width(cr, width)
        point = (math.pi / 180) * degree - start_point
        start_x = 0 + (offset * math.sin(point))
        start_y = 0 - (offset * math.cos(point))
        end_x = 0 + ((offset + length) * math.sin(point))
        end_y = 0 - ((offset + length) * math.cos(point))
        end_xp = 0 + (offset + circle_width) * math.sin(point)
        end_yp = 0 - (offset + circle_width) * math.cos(point)
 
	p = cairo_pattern_create_linear(start_x + center_x, start_y + center_y, end_xp + center_x, end_yp + center_y)

	cairo_pattern_add_color_stop_rgb(p, 0, 0, 1, 0)
	cairo_pattern_add_color_stop_rgb(p, 1, 1, 0, 0)
	cairo_set_source(cr, p)

        cairo_move_to(cr, start_x + center_x, start_y + center_y)
        cairo_line_to(cr, end_x + center_x, end_y + center_y)
        cairo_stroke(cr)

	cairo_pattern_destroy(p);

end

