-- server

util.AddNetworkString("TTT2PlayerAuthedSharing")

hook.Add("PlayerAuthed", "TTT2HookSharing", function(ply, steamid, uniqueid)
	net.Start("TTT2PlayerAuthedSharing")
	net.WriteString(steamid)
	net.WriteString((ply and ply:Nick()) or "UNKNOWN")
	net.Broadcast()
end)
