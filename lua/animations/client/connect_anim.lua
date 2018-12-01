local surface = surface
local draw = draw

-- Fonts
surface.CreateFont("ConnectToTTT2", {font = "Trebuchet24", size = 21, weight = 1000})

local duration = 3
local holdTime = 2

local width, height = 250, 60
local padding = 5

--local animColor = Color(0, 0, 0, 200)

local animStart = 0
local animQueue = {}

hook.Add("TTT2PlayerAuthedCacheReady", "TTT2ConnectAnim", function(steamid, name)
	if #animQueue == 0 then
		animStart = CurTime()
	end

	table.insert(animQueue, {s = steamid, n = name})
end)

hook.Add("HUDPaint", "TTT2PaintConnectAnim", function()
	if #animQueue > 0 then
		local res = animQueue[1]
		local steamid = res.s
		local name = res.n
		local progress = CurTime() - animStart

		local multiplicator = progress / duration
		local rest = duration - holdTime
		local _tmp = rest * 0.5

		multiplicator = multiplicator * duration * 2 * rest

		if progress >= _tmp then -- else: multiplicator = multiplicator
			if progress < _tmp + holdTime then
				multiplicator = 1
			elseif progress < duration then
				multiplicator = duration * 2 - multiplicator
			end
		end

		local pos = Vector(ScrW(), ScrH() * 0.8, 0) -- 1 / 5 * 4 = 0.8
		pos.x = math.floor(pos.x - width * multiplicator) -- improve performance

		local doublePadding = 2 * padding
		local size = height - doublePadding

		-- rect
		surface.SetDrawColor(0, 0, 0, 120)
		surface.DrawRect(pos.x, pos.y, width, height)

		-- avatar
		draw.SteamAvatar(steamid, "medium", pos.x + padding, pos.y + padding, size, size, Color(255, 255, 255, 255))

		local tmp = width - doublePadding - size

		-- Draw current class state
		draw.SimpleText(name, "ConnectToTTT2", pos.x + (doublePadding + size) + tmp * 0.5, pos.y + padding, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

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

	table.insert(animQueue, {s = ply:SteamID64(), n = ply:Nick()})
end)
