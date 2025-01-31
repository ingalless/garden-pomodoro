package main

import "core:fmt"
import menus "menus"
import rl "vendor:raylib"

width: i32 = 1280
height: i32 = 720
grid_padding: i32 = 40
grid_width: i32 = 8
grid_height: i32 = 5
grid_total: i32 = grid_width * grid_height
grid_gutter: i32 = 5

Tile :: struct {
	x:    i32,
	y:    i32,
	size: i32,
}

draw_grid :: proc(tiles: [dynamic]Tile) {
	mouse := rl.GetMousePosition()
	for tile in tiles {
		using tile
		hovered := rl.CheckCollisionPointRec(
			mouse,
			rl.Rectangle{f32(x), f32(y), f32(size), f32(size)},
		)
		rl.DrawRectangle(
			x,
			y,
			size,
			size,
			rl.Color{124, 176, 109, 255} if hovered else rl.Color{124, 176, 109, 200},
		)
	}
}

main :: proc() {
	fmt.println("Hellope!")

	rl.InitWindow(width, height, "Garden")
	defer rl.CloseWindow()

	rl.SetTargetFPS(30)

	// build tile grid
	tiles: [dynamic]Tile
	for i in 0 ..< grid_total {
		append(
			&tiles,
			Tile {
				x = grid_padding + 100 * (i % grid_width) + 10 * (i % grid_width),
				y = grid_padding + 100 * (i / grid_width) + 10 * (i / grid_width),
				size = 100,
			},
		)
	}


	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		rl.ClearBackground(rl.Color{78, 126, 107, 255})
		draw_grid(tiles)

		rl.EndDrawing()
	}
}
