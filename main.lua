-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")

display.setDefault("background", 0.9, 0.9, 0.9)

tapSound = audio.loadSound('button-16.wav')

composer.gotoScene("fileupload", {effect="fade", time=400})


function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
 end
 timer.performWithDelay( 1000, checkMemory, 0 )



