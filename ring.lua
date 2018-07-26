require 'cairo'

function conky_main_graph()
	if conky_window == nil then return end
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	cr = cairo_create(cs)
	local updates = tonumber(conky_parse('${updates}'))
	if updates == 1 then
		center_x = 150
		center_y = 150
		
		cpu_radius = 100
		cpu_circle_width = 40
		cpu_table_length = 20

		cpu_table = {}
		cpu0_table = {}
		cpu1_table = {}
		cpu2_table = {}
		cpu3_table = {}
		
		mem_radius = -60 
		mem_circle_width = 28
		mem_table_length = 60 
		mem_table = {}

                netup_radius = 100
                netup_circle_width = 50
                netup_table_length = 60
                netup_table = {}

		netdown_radius = -60
                netdown_circle_width = 28
                netdown_table_length = 60
                netdown_table = {}

	end
	if updates > 1 then
--		draw_graph ("${cpu cpu0}", cpu_table_length, cpu_radius, cpu_circle_width, cpu0_table,3,145,"#424242","#FF0000",2.8)
--		draw_graph ("${cpu cpu1}", cpu_table_length, cpu_radius, cpu_circle_width, cpu1_table,3,70,"#0489B1","#ff0000",2.8)
--		draw_graph ("${cpu cpu2}", cpu_table_length, cpu_radius, cpu_circle_width, cpu2_table,3,-5,"#086A87","#ff0000",2.8)
--		draw_graph ("${cpu cpu3}", cpu_table_length, cpu_radius, cpu_circle_width, cpu3_table,3,-80,"#0B4C5F","#ff0000",2.8)
--		draw_graph ("${cpu}", cpu_table_length, 50, cpu_circle_width, cpu_table,5,140,"#D7DF01","#ff0000",1.4)
--		draw_graph ("$memperc", mem_table_length, mem_radius, mem_circle_width, mem_table,8,130,"#298A08","#ff0000",1.45)

		draw_graph ("${cpu cpu0}", cpu_table_length, cpu_radius, cpu_circle_width, cpu0_table,3,145,2.8)
		draw_graph ("${cpu cpu1}", cpu_table_length, cpu_radius, cpu_circle_width, cpu1_table,3,70,2.8)
		draw_graph ("${cpu cpu2}", cpu_table_length, cpu_radius, cpu_circle_width, cpu2_table,3,-5,2.8)
		draw_graph ("${cpu cpu3}", cpu_table_length, cpu_radius, cpu_circle_width, cpu3_table,3,-80,2.8)
		draw_graph ("${cpu}", cpu_table_length, 50, cpu_circle_width, cpu_table,5,140,1.4)
		draw_graph ("$memperc", mem_table_length, mem_radius, mem_circle_width, mem_table,8,130,1.45)


--		upspeed=tonumber(conky_parse("${upspeedf eth0}")/100)
--		downspeed=tonumber(conky_parse("${downspeedf eth0}")/100)
--		draw_graph (upspeed, netup_table_length, netup_radius, netup_circle_width, netup_table,8)
--		draw_graph (downspeed, netup_table_length, netup_radius, netup_circle_width, netup_table,8)

	end
	cairo_surface_destroy(cs)
	cairo_destroy(cr)
	cs, cr = nil
end 
function hex2rgb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function draw_graph (conky_value, table_length, radius, circle_width, table, line_width, start_point, sectors, start_color, end_color)
	start_color = start_color or "#00FF00"
	end_color = end_color or "#FF0000"

	sectors = sectors or 1

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
		degree = (360 / (table_length * sectors)) * (i - 1)
		-- draw circle
		start_point = start_point or 0

		cairo_set_line_width(cr, line_width)
		point = (math.pi / (180 * sectors ) ) * ( degree ) - ( start_point /90)
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

