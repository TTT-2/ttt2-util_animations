if SERVER then
    AddCSLuaFile()
    AddCSLuaFile("animations/cl_init.lua")
    AddCSLuaFile("animations/client/cubic_bezier.lua")

    include("animations/init.lua")
else
    include("animations/cl_init.lua")
end
