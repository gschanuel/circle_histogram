require 'cairo'
require 'cpu_functions'
require 'mem_functions'
require 'netdown_functions'
require 'netup_functions'

function rgb_to_r_g_b(color,alpha)
return ((0xa5adff / 0x10000) % 0x100) / 255., ((0xa5adff / 0x100) % 0x100) / 255., (0xa5adff % 0x100) / 255., 1
end

function conky_main_graph(color, alpha)
	if conky_window == nil then return end
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	cr = cairo_create(cs)
	local updates = tonumber(conky_parse('${updates}'))
	if updates == 1 then
		-- colors and font
		--   base_rgba = {55, 0, 50, 1}
  		--   accent_rgba = {115, 73, 25, 1}
		-- settings
		center_x = 305
		center_y = 305
		
--		cpu_radius = 300
--		cpu_circle_width = 300
--		cpu_table_length = 120
--		cpu_table = {}
		
--		mem_radius = 120
--		mem_circle_width = 80
--		mem_table_length = 80
--		mem_table = {}

                netup_radius = 60
                netup_circle_width = -40
                netup_table_length = 80
                netup_table = {}

		netdown_radius = 100
                netdown_circle_width = 50
                netdown_table_length = 80
                netdown_table = {}

	end
	if updates > 1 then
		-- edit from here --------------------------------------------------
		-- new lines are added with draw_line(text, text_line_length, value, max_value, degree)
		-- for example draw_line("Memory", 48, tonumber(conky_parse("$mem")), tonumber(conky_parse("$memmax")), 90) for a memory bar at 90 degrees

		-- to here ---------------------------------------------------------
		-- base, cpu and clock
--		draw_mem_graph()
--		draw_cpu_graph()
		draw_netup_graph()
		draw_netdown_graph()
	end
	cairo_destroy(cr)
	cairo_surface_destroy(cs)
	cs, cr = nil
end -- end main function

function draw_line_in_circle(offset, length, width, degree, r, g, b)
	cairo_set_line_width(cr, width)
	point = (math.pi / -180) * degree
	start_x = 0 + (offset * math.sin(point))
	start_y = 0 - (offset * math.cos(point))
	end_x = 0 + ((offset + length) * math.sin(point))
	end_y = 0 - ((offset + length) * math.cos(point))
	cairo_move_to(cr, start_x + center_x, start_y + center_y)
	cairo_line_to(cr, end_x + center_x, end_y + center_y)
	cairo_set_source_rgb (cr, r, g, b);
	cairo_stroke(cr)
end
