require 'cairo'
require 'functions'

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
		
		cpu_radius = 300
		cpu_circle_width = 300
		cpu_table_length = 120
		cpu_table = {}
		
		mem_radius = 120
		mem_circle_width = 80
		mem_table_length = 80
		mem_table = {}

                netup_radius = 60
                netup_circle_width = 40
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
		draw_graph ("cpu", cpu_table_length, cpu_radius, cpu_circle_width, cpu_table)
		draw_graph ("memperc", mem_table_length, mem_radius, mem_circle_width, mem_table)
		draw_graph ("${upspeedf eth0}", netup_table_length, netup_radius, netup_circle_width, netup_table)
		draw_graph ("${downspeedf eth0}", netup_table_length, netup_radius, netup_circle_width, netup_table)
	end
	cairo_destroy(cr)
	cairo_surface_destroy(cs)
	cs, cr = nil
end -- end main function
