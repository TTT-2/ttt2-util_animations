if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("animations/client/calculations/cubic_bezier.lua")
	AddCSLuaFile("animations/client/role_anim.lua")
	AddCSLuaFile("animations/client/libs/web_image.lua")
	AddCSLuaFile("animations/client/connect_anim.lua")
	AddCSLuaFile("animations/cl_init.lua")

	include("animations/init.lua")
else
	include("animations/cl_init.lua")
end
