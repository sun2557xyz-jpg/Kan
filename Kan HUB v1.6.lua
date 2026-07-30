-- ========================================================
-- ANTI-BAN / ANTI-DETECTION (ระบบป้องกันเบื้องต้น)
-- ========================================================
pcall(function()
    local gMT = getrawmetatable(game)
    local oldNamecall = gMT.__namecall
    setreadonly(gMT, false)
    
    gMT.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            return nil -- ป้องกันไม่ให้เกมสั่ง Kick
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(gMT, true)
end)

-- ========================================================
-- RAYFIELD UI INITIALIZATION
-- ========================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "PvP Hub | Rayfield UI",
    LoadingTitle = "กำลังโหลดระบบ PvP...",
    LoadingSubtitle = "โดย AI Assistant",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PvPHubConfig",
        FileName = "PvP_Settings"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- ========================================================
-- VARIABLES & SERVICES
-- ========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")

local Event = ReplicatedStorage:FindFirstChild("SpawnGalaxyBlock")

-- Variables State
local State = {
    HomingBullets = false,
    FOVValue = 90,
    InfSpeedJump = false,
    AntiLockSpin = false,
    ESP = false,
    MagnetItem = false,
    MagnetRange = 50,
    SkySpinOnKnock = false,
    WalkSpeed = 16,
    JumpPower = 50,
    FastShoot = false,
    TracerHeads = false,
    FastSell = false,
    FastRoll = false,
    AutoSkyKnock = false
}

-- FOV Circle Visual
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 64
FOVCircle.Radius = State.FOVValue
FOVCircle.Filled = false
FOVCircle.Visible = false

-- ========================================================
-- TABS CREATION
-- ========================================================
local MainTab = Window:CreateTab("ฟังชั่นหลัก (Main PvP)", 4483362458)
local SubTab = Window:CreateTab("ฟังชั่นรอง (Utility)", 4483362458)

-- ========================================================
-- TAB 1: ฟังชั่นหลักการ PvP (1 - 8)
-- ========================================================

-- 1. กระสุนติดตามยิงทะลุกำแพง
MainTab:CreateToggle({
    Name = "1. กระสุนติดตาม + ยิงทะลุกำแพง",
    CurrentValue = false,
    Callback = function(Value)
        State.HomingBullets = Value
        if Value and Event then
            task.spawn(function()
                while State.HomingBullets do
                    task.wait(0.1)
                    -- ส่ง Event ถี่ยิงกระสุนติดตาม
                    Event:FireServer()
                end
            end)
        end
    end,
})

-- 2. FOV ปรับได้ 1 ถึง 360
MainTab:CreateSlider({
    Name = "2. ปรับขนาด FOV (1 - 360)",
    Range = {1, 360},
    Increment = 1,
    Suffix = "px",
    CurrentValue = 90,
    Callback = function(Value)
        State.FOVValue = Value
        FOVCircle.Radius = Value
    end,
})

MainTab:CreateToggle({
    Name = "แสดงวงกลม FOV",
    CurrentValue = false,
    Callback = function(Value)
        FOVCircle.Visible = Value
    end,
})

-- 3. วิ่งไวโดดสูงแบบไม่จำกัด
MainTab:CreateToggle({
    Name = "3. วิ่งไว/โดดสูง ไม่จำกัด (God Speed & Jump)",
    CurrentValue = false,
    Callback = function(Value)
        State.InfSpeedJump = Value
        task.spawn(function()
            while State.InfSpeedJump do
                task.wait()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid
                
