local surface = surface
local draw = draw

-- Fonts
surface.CreateFont("ReceivedNewRole", {font = "Trebuchet24", size = 64, weight = 1000})

local receivedNewRole
local oldRoundRole
local duration = 3
local animColor = Color(0, 0, 0, 120)
local animStart = 0

local function ShadowedText(text, font, x, y, color, xalign, yalign)
	draw.SimpleText(text, font, x + 2, y + 2, COLOR_BLACK, xalign, yalign)
	draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

local function ThickLine(sx, sy, ex, ey, thickness, dir)
    for i = 0, thickness do
        surface.DrawLine(sx, dir and (sy + i) or (sy - i), ex, dir and (ey + i) or (ey - i))
    end
end

hook.Add("TTT2_RoleTypeSet", "TTT2RoleAnim", function(ply)
    local rd = ply:GetRoleData()
    local tmp = LANG.GetTranslation(rd.name)
    
    if tmp ~= receivedNewRole then
        receivedNewRole = tmp
        animColor = rd.color
        animStart = CurTime()
    end
end)

hook.Add("TTTEndRound", "TTT2ResetRoleAnimData", function()
    oldRoundRole = nil
    receivedNewRole = nil
end)

hook.Add("HUDPaint", "TTT2PaintRoleAnim", function()
    local client = LocalPlayer()

    if client:IsActive() and oldRoundRole ~= receivedNewRole then
        local center = Vector(ScrW() / 2, ScrH() / 2, 0)
        local multiplicator = CubicBezier(0.1, 0.8, 0.9, 0.2, (CurTime() - animStart) / duration)
        
        local sx, ex = 0, ScrW()
        local y1, y2 = ScrH() / 3, ScrH() / 3 * 2
        
        -- rect
        local a = animColor.a
        
        if multiplicator > 0.5 then
            a = a * (1 - multiplicator) * 1.5
        else
            a = a * multiplicator * 1.5
        end
        
        surface.SetDrawColor(animColor.r, animColor.g, animColor.b, a)
        
        surface.DrawRect(sx, y1, ex, y2 - y1)
        
        -- lines
        surface.SetDrawColor(255, 255, 255, a)
        
        local thickness = 5

        ThickLine(sx, y1, ex * multiplicator, y1, thickness, true)
        ThickLine(ex, y2, ex - (ex * multiplicator), y2, thickness, false)
        
        -- Draw current class state
        ShadowedText(receivedNewRole, "ReceivedNewRole", center.x, center.y - 32, Color(255, 255, 255, a), TEXT_ALIGN_CENTER)
        
        if animStart + duration <= CurTime() then
            oldRoundRole = receivedNewRole
        end
    end
end)
