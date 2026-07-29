-- ========================================================
-- ANTI-BAN & ANTI-DETECTION SYSTEM (ระบบกันแบน / กันโดนเตะ)
-- ========================================================
local gmt = getrawmetatable(game)
local oldNamecall = gmt.__namecall
setreadonly(gmt, false)

gmt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    -- บล็อก Remote ที่ใช้ส่งค่าความเร็ว/ตำแหน่งไปตรวจจับที่ Server
    if method == "FireServer" and (self.Name:clower():find("ban") or self.Name:lower():find("cheat") or self.Name:lower():find("detect")) then
        return nil
    end
    return oldNamecall(self, ...)
end)
setreadonly(gmt, true)

-- ========================================================
-- RAYFIELD UI INITIALIZATION
-- ========================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "HUB PvP & Utility (17 Functions)",
   LoadingTitle = "กำลังโหลดสคริปต์...",
   LoadingSubtitle = "By AI Assistant",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

-- TAB SETUP
local MainTab = Window:CreateTab("ฟังชั่นหลัก (PvP)", 4483362458)
local SubTab = Window:CreateTab("ฟังชั่นรอง", 4483362458)

-- VARIABLES (ตัวแปรควบคุมระบบ)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FOVRadius = 100
local AimbotWallbang = false
local InfiniteJump = false
local AntiLockSpin = false
local ESP_Enabled = false
local MagnetItems = false
local MagnetDistance = 50
local FlySkySpin = false
local WalkSpeedVal = 16
local JumpPowerVal = 50
local ItemESP = false
local FastShoot = false
local Tracers = false
local AutoSeller = false
local AutoRandom = false
local AutoKnockFly = false

-- ========================================================
-- TAB 1: ฟังชั่นหลักการ PvP (1 - 8)
-- ========================================================

MainTab:CreateSection("1. กระสุนติดตามยิงทะลุกำแพง & Wallbang")
MainTab:CreateToggle({
   Name = "1. กระสุนติดตาม / ยิงทะลุกำแพง",
   CurrentValue = false,
   Callback = function(Value)
      AimbotWallbang = Value
   end,
    
