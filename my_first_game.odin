package game

import rl "vendor:raylib"
import "core:fmt"

main :: proc() {
  rl.InitWindow(1280, 720, "My First Game")

  player_pos := rl.Vector2{640, 320}
  player_vel: rl.Vector2
  player_grounded: bool

  for !rl.WindowShouldClose() {
    rl.BeginDrawing()
    rl.ClearBackground(rl.DARKBLUE)

    frame := rl.GetFrameTime()

    if rl.IsKeyDown(.LEFT) {
      player_vel.x = -400
    } else if rl.IsKeyDown(.RIGHT) {
      player_vel.x = 400
    } else {
      player_vel.x = 0
    }

    // Add gravity
    player_vel.y += 2000 * frame

    if player_grounded && rl.IsKeyPressed(.SPACE) {
      player_vel.y = -600
      player_grounded = false
    }

    // In Odin the math operators, all work on both single numbers
    player_pos += player_vel * frame

    if player_pos.y > f32(rl.GetScreenHeight()) - 64 {
      player_pos.y = f32(rl.GetScreenHeight()) - 64
      player_grounded = true
    }

    rl.DrawRectangleV(player_pos, {64, 64}, {255, 180, 0, 255})
    rl.EndDrawing()
  }

  rl.CloseWindow()
}
