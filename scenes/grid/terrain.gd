extends Node2D

const halftileh = Vector2(0.5, 0)
const halftilev = Vector2(0, 0.5)

onready var tilemap = $Tilemap
onready var back = $Back
onready var top = $Top
onready var checker = $Checker

func update_tiles():
	tilemap.tile_set = Grid.biome.tileset

	position = Grid.bounds.position
	for i in range(0, Grid.size.x + 1):
		for j in range(0, Grid.size.y + 1):
			var pos = Vector2(i - 0.5, j - 0.5)
			
			var n = false
			var s = false
			var e = false
			var w = false
			var ne = false
			var se = false
			var sw = false
			var nw = false
			
			if Grid.is_wall(pos + halftilev + halftileh) or Grid.is_wall(pos + halftilev - halftileh):
				s = true
			if Grid.is_wall(pos - halftilev + halftileh) or Grid.is_wall(pos - halftilev - halftileh):
				n = true
			if Grid.is_wall(pos + halftileh + halftilev) or Grid.is_wall(pos + halftileh - halftilev):
				e = true
			if Grid.is_wall(pos - halftileh + halftilev) or Grid.is_wall(pos - halftileh - halftilev):
				w = true
			if Grid.is_wall(pos + halftileh + halftilev):
				se = true
			if Grid.is_wall(pos - halftileh + halftilev):
				sw = true
			if Grid.is_wall(pos + halftileh - halftilev):
				ne = true
			if Grid.is_wall(pos - halftileh - halftilev):
				nw = true
				
			#FULL
			if (n and s and w and e and nw and ne and sw and se): tilemap.set_cell(i, j, 14)
			
			#FLATS
			elif (n and s and !w and e): tilemap.set_cell(i, j, 13)
			elif (n and s and w and !e): tilemap.set_cell(i, j, 3)
			elif (!n and s and w and e): tilemap.set_cell(i, j, 11)
			elif (n and !s and w and e): tilemap.set_cell(i, j, 5)
			
			#CORNERS
			elif (n and !s and !w and e): tilemap.set_cell(i, j, 4)
			elif (!n and s and !w and e): tilemap.set_cell(i, j, 9)
			elif (n and !s and w and !e): tilemap.set_cell(i, j, 7)
			elif (!n and s and w and !e): tilemap.set_cell(i, j, 12)
			
			#ANTICORNERS
			elif (n and s and w and e and se and ne and nw and !sw): tilemap.set_cell(i, j, 2)
			elif (n and s and w and e and se and ne and !nw and sw): tilemap.set_cell(i, j, 17)
			elif (n and s and w and e and !se and ne and nw and sw): tilemap.set_cell(i, j, 15)
			elif (n and s and w and e and se and !ne and nw and sw): tilemap.set_cell(i, j, 10)
			
			#WEIRDS
			elif (n and s and w and e and se and !ne and nw and !sw): tilemap.set_cell(i, j, 16)
			elif (n and s and w and e and !se and ne and !nw and sw): tilemap.set_cell(i, j, 6)
			
			else: tilemap.set_cell(i, j, 8)
			
	back.position = Grid.bounds.size * 0.5
	back.scale = Vector2(Grid.size.x + 1, Grid.size.y + 1);
	back.modulate = Grid.biome.color_bottom

	top.position = Grid.bounds.size * 0.5
	top.scale = Vector2(20, 20);
	top.modulate = Grid.biome.color_top
	VisualServer.set_default_clear_color(Grid.biome.color_top)

	checker.position = Grid.bounds.size * 0.5 + Vector2(0, 16)
	checker.region_rect = Rect2(Vector2.ZERO, Vector2(Grid.size.x, Grid.size.y) * 64);			
	

## func update_tiles(Grid):
# 	dual_Grid.update_tiles(Grid)
#
# 	$Back.position = Grid.size * Grid.cell_size / 2
# 	$Back.scale = Vector2(Grid.size.x + 1, Grid.size.y + 1);
#
# 	$Top.position = Grid.size * Grid.cell_size / 2
	
