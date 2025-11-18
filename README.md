# Puzzles from the Server Room

A puzzle game built with Godot 4.5 that combines 3D exploration with classic Sokoban-style puzzles. Navigate through a server room environment and solve puzzles on vintage monitors.

## About

**Puzzles from the Server Room** is a unique blend of 3D first-person exploration and 2D puzzle gameplay. Players explore a detailed 3D server room and interact with monitors to solve Sokoban-inspired puzzles. The game features atmospheric ambient sounds and retro aesthetics that capture the feeling of working in a classic server room.

## Features

- **Hybrid Gameplay**: Seamlessly switch between 3D server room exploration and 2D puzzle solving
- **Sokoban-Style Puzzles**: Classic box-pushing puzzle mechanics with a grid-based system
- **3D Environment**: Explore a detailed server room with monitors and equipment
- **Atmospheric Audio**: Ambient sounds and keyboard effects for immersion
- **Multiple Levels**: Progressive puzzle difficulty
- **Controller Support**: Gamepad support alongside keyboard controls

## Controls

### 3D Navigation
- **W/A/S/D** or **Gamepad Left Stick**: Move character
- **Mouse** or **Gamepad Right Stick**: Look around

### Puzzle Interaction
- **Interact with monitors** to start puzzles
- **Menu controls** available during gameplay

## Technical Details

- **Engine**: Godot 4.5
- **Rendering**: Forward Plus renderer
- **Testing Framework**: GUT (Godot Unit Testing) addon included

## Project Structure

```
├── assets/          # Game assets (2D, 3D, audio)
│   ├── 2D-tiles/    # Puzzle tile graphics
│   ├── 2D-characters/
│   ├── 3D-server-room/
│   └── 1D-ambient-sounds/
├── scenes/
│   ├── server_room/ # 3D server room scenes
│   ├── puzzling/    # 2D puzzle scenes and levels
│   └── menu_overlay.tscn
└── scripts/
    ├── globals.gd   # Global game state and signals
    ├── sokoban/     # Puzzle logic
    ├── movements/   # Character movement
    └── ui/          # User interface

```

## Development

This project uses the GUT (Godot Unit Testing) framework for automated testing. Test scripts are located in `scripts/test/`.

### Building

1. Open the project in Godot 4.5 or later
2. Run the project from the editor, or
3. Export using the presets defined in `export_presets.cfg`

## Credits

- **Audio**: Server room ambient sound by [Qleq on Freesound](https://freesound.org/people/Qleq/sounds/682619/)
- Additional asset credits in `assets/asset_credits.txt`

## License

This project includes the GUT testing framework which is licensed under the MIT license. See `addons/gut/LICENSE.md` for details.

---

Made with [Godot Engine](https://godotengine.org/)
With GUT (Godot Unit Testing)