-- ==========================================
-- 🛡️ 0. ANTI-BAN / PROTECTION MODULE
-- ==========================================
pcall(function()
    -- Hook LocalScript Error Reporting to prevent sending crash logs to Roblox
    local ScriptContext = game:GetService("ScriptContext")
    ScriptContext:SetTimeout(0.1)
    
    -- Bypass Basic Anti-Cheat WalkSpeed/JumpPower Check Hooks
    local rawget = rawget
    local setreadonly = setreadonly or make_writeable
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldIndex = mt.__index
    mt.__index = newcclosure(function(self, idx)
        if not checkcaller() and (idx == "WalkSpeed" or idx == "JumpPower" or idx == "JumpHeight") then
            return 16 -- Return default values to Server Checks
        end
        return oldIndex(self, idx)
    end)
    setreadonly(mt, true)
end)

-- ==========================================
-- 🎨 1. RAYFIELD UI INITIALIZATION
-- ==========================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "HUB Premium | 17 Features",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by Assistant AI",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

-- Global Variables / States
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera

local States = {
    AimbotWallbang = false,
    FOVSize = 90,
    FOVVisible = false,
    InfiniteStats = false,
    AntiLock360 = false,
    ESP = false,
    LootMagnet = false,
    LootDistance = 10,
    FlyOnKnock = false,
    WalkSpeed = 16,
    JumpPower = 50,
    FastShoot = false,
    TracerLines = false,
    AutoSell = false,
    FastGacha = false,
    KnockTPFly = false
}

-- Create FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Radius = States.FOVSize
FOVCircle.Filled = false
FOVCircle.Visible = false

-- FOV Position Updater
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
    FOVCircle.Radius = States.FOVSize
    FOVCircle.Visible = States.FOVVisible
end)

-- ==========================================
-- ⚔️ TAB 1: MAIN FUNCTIONS (ฟังก์ชันหลัก - PvP)
-- ==========================================
local MainTab = Window:CreateTab("⚔️ ฟังก์ชันหลัก (PvP)", 4483362458)

-- 1. กระสุนติดตามยิงทะลุกำแพง (Silent Aim / Wallbang)
MainTab:CreateToggle({
   Name = "1. กระสุนติดตาม + ยิงทะลุกำแพง",
   CurrentValue = false,
   Callback = function(Value)
      States.AimbotWallbang = Value
   end,
})

-- 2. ปรับ FOV 1 ถึง 360
MainTab:CreateSlider({
   Name = "2. ปรับขนาด FOV (1-360)",
   Range = {1, 360},
   Increment
    
