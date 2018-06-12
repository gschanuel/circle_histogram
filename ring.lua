require 'cairo'
require 'functions'

function conky_main_graph()
	if conky_window == nil then return end
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	cr = cairo_create(cs)
	local updates = tonumber(conky_parse('${updates}'))
	if updates == 1 then
		center_x = 300
		center_y = 300
		
		cpu_radius = 200
		cpu_circle_width = 100
		cpu_table_length = 120
		cpu_table = {}
		
		mem_radius = -120 
		mem_circle_width = 55
		mem_table_length = 100
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
		draw_graph ("$cpu", cpu_table_length, cpu_radius, cpu_circle_width, cpu_table,8)
		draw_graph ("100", mem_table_length, mem_radius, mem_circle_width, mem_table, 4)
--		draw_graph ("${upspeedf eth0}", netup_table_length, netup_radius, netup_circle_width, netup_table)
--		draw_graph ("${downspeedf eth0}", netup_table_length, netup_radius, netup_circle_width, netup_table)
	end
	cairo_surface_destroy(cs)
	cairo_destroy(cr)
	cs, cr = nil
end 
