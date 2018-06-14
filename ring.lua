require 'cairo'
require 'functions'

function conky_main_graph()
	if conky_window == nil then return end
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	cr = cairo_create(cs)
	local updates = tonumber(conky_parse('${updates}'))
	if updates == 1 then
		center_x = 150
		center_y = 150
		
		cpu_radius = 100
		cpu_circle_width = 50
		cpu_table_length = 60
		cpu_table = {}
		
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
		draw_graph ("$cpu", cpu_table_length, cpu_radius, cpu_circle_width, cpu_table,8 )
		draw_graph ("$memperc", mem_table_length, mem_radius, mem_circle_width, mem_table,4,160.2)

--		upspeed=tonumber(conky_parse("${upspeedf eth0}")/100)
--		downspeed=tonumber(conky_parse("${downspeedf eth0}")/100)
--		draw_graph (upspeed, netup_table_length, netup_radius, netup_circle_width, netup_table,8)
--		draw_graph (downspeed, netup_table_length, netup_radius, netup_circle_width, netup_table,8)

	end
	cairo_surface_destroy(cs)
	cairo_destroy(cr)
	cs, cr = nil
end 
