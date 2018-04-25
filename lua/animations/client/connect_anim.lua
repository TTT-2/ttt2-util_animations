local surface = surface
local draw = draw

-- Fonts
surface.CreateFont("ConnectToTTT2", {font = "Trebuchet24", size = 21, weight = 1000})

local duration = 3
local holdTime = 2
        
local width, height = 250, 60
local padding = 5
        
local animColor = Color(0, 0, 0, 200)

local animStart = 0
local animQueue = {}

hook.Add("PlayerAuthedCacheReady", "TTT2ConnectAnim", function(steamid64, name)
    if #animQueue == 0 then
        animStart = CurTime()
    end

    table.insert(animQueue, {id = steamid64, n = name})
end)

hook.Add("HUDPaint", "TTT2NewRoleAnim", function()
    if #animQueue > 0 then
        local steamid64 = animQueue[1].id
        local name = animQueue[1].n
        
        local multiplicator = (CurTime() - animStart) / duration
        
        local rest = duration - holdTime
        
        multiplicator = multiplicator * duration * 2 * rest
        
        if CurTime() - animStart < rest / 2 then
            --multiplicator = multiplicator
        elseif CurTime() - animStart < rest / 2 + holdTime then
            multiplicator = 1
        elseif CurTime() - animStart < duration then
            multiplicator = duration * 2 - multiplicator
        end
        
        local pos = Vector(ScrW(), ScrH() / 5 * 4, 0)
        pos.x = pos.x - width * multiplicator
        
        local size = height - 2 * padding
        
        -- rect
        surface.SetDrawColor(0, 0, 0, 120)
        
        surface.DrawRect(pos.x, pos.y, width, height)
        
        -- avatar
        draw.SteamAvatar(steamid64, "medium", pos.x + padding, pos.y + padding, size, size, Color(255, 255, 255, 255))
        
        local tmp = width - 2 * padding - size
        
        -- Draw current class state
        draw.SimpleText(name, "ConnectToTTT2", pos.x + (2 * padding + size) + tmp / 2, pos.y + padding, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        
        if animStart + duration <= CurTime() then
            table.remove(animQueue, 1)
            animStart = CurTime()
        end
    end
end)

concommand.Add("TestConAnim", function(ply)
    if #animQueue == 0 then
        animStart = CurTime()
    end

    table.insert(animQueue, {id = ply:SteamID64(), n = ply:Nick()})
end)
