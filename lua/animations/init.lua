-- server

util.AddNetworkString("TTT2PlayerAuthedSharing")

hook.Add("PlayerAuthed", "TTT2HookSharing", function(ply, steamid, uniqueid)
    net.Start("TTT2PlayerAuthedSharing")
    net.WriteString(ply:SteamID64())
    net.WriteString(ply:Nick())
    net.Broadcast()
end)
