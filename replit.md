# Roblox Lua Scripts Repository

## Overview
This repository contains Lua scripts designed for use within Roblox games. These are client-side scripts that modify game behavior when executed in the Roblox environment.

## Project Type
- **Language**: Lua
- **Platform**: Roblox
- **Purpose**: Game modification scripts

## Files

### distrik.lua
A comprehensive script for "Violence District" game with features including:
- Player ESP (wallhacks/chams)
- Generator and Gate ESP with status tracking
- Killer ability notifications
- Anti-AFK system
- Auto-repair functionality
- Skillcheck removal
- Uses Rayfield UI library

### fish.lua
Script for a fishing game ("Fish it") with:
- Teleportation features
- Auto-fishing toggle (incomplete)
- Anti-AFK functionality
- Low texture mode for performance
- Uses Rayfield UI library

### fishit.lua
Obfuscated version of a fishing game script (appears to be compiled/protected code)

### README.md
Contains a loadstring command for loading a remote script from GitHub

## Important Notes

⚠️ **This is NOT a runnable server application**

These scripts are designed to be:
1. Executed within the Roblox game client
2. Loaded via script executors/exploit tools
3. Run on the client-side, not on a server

This repository cannot be "deployed" or "run" in a traditional sense on Replit, as these scripts require the Roblox game environment to function.

## Usage
These scripts are typically loaded in Roblox using:
```lua
loadstring(game:HttpGet("URL_TO_SCRIPT"))()
```

## Last Updated
November 23, 2025
