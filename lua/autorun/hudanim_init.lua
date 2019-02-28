if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("animations/client/calculations/cubic_bezier.lua")
	AddCSLuaFile("animations/client/role_anim.lua")
	AddCSLuaFile("animations/client/connect_anim.lua")
else
	include("animations/client/calculations/cubic_bezier.lua")
	include("animations/client/role_anim.lua")
	include("animations/client/connect_anim.lua")
end
