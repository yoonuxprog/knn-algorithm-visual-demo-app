
local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )
    local sceneGroup = self.view

    local widget = require("widget")

    local knn =  require("knn")

    local xvalue = xcor
    local yvalue = ycor
    local kvalue = k_value

    local result = KNNalgorithm(xvalue, yvalue, kvalue)

    local homeButton = widget.newButton{
        left = display.contentWidth / 10,
        top = 0,
        height =  25,
        width = 70,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        shape = "roundedRect",
        width = 80,
        height = 40,
        cornerRadius = 5,
        fillColor = { default={0.18,0.18,0.30,1}, over={0.65,0.65,0.65,1} },
        strokeColor = { default={1,1,1,1}, over={1,1,1,1} },
        strokeWidth = 4,
        label = "Home"
    }
    sceneGroup:insert(homeButton)

    local function goHome()
        audio.play(tapSound)
        composer.gotoScene("ui", {effect="fromLeft", time=800})
        composer.removeScene("menu")
    end
    homeButton:addEventListener("tap", goHome)

    local classBox = display.newRoundedRect( 0, 0, display.contentWidth-20, 150, 12 )
    classBox.x = display.contentCenterX
    classBox.y = display.contentHeight / 2.35
    classBox.strokeWidth = 3
    classBox:setFillColor( 0, 0, 0, 0 )
    classBox:setStrokeColor( 0, 0, 0 )
    sceneGroup:insert(classBox)

    local class = display.newText("THE CLASS IS :", 0, 0, native.systemFont, 25)
    class.x = display.contentWidth / 2
    class.y  = display.contentHeight / 3
    class:setTextColor(0,0,0.55)
    sceneGroup:insert(class)

    local result = display.newText(result, 0, 0, native.systemFont, 60)
    result.x = display.contentWidth / 2
    result.y  = display.contentHeight / 2.25
    result:setTextColor(0,0.75,1)
    sceneGroup:insert(result)

    local submitButton = widget.newButton{
        left = display.contentWidth / 10,
        top = display.contentHeight / 1.3,
        height =  25,
        width = 70,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        shape = "roundedRect",
        width = 250,
        height = 40,
        cornerRadius = 5,
        fillColor = { default={0.18,0.18,0.30,1}, over={0.65,0.65,0.65,1} },
        strokeColor = { default={1,1,1,1}, over={1,1,1,1} },
        strokeWidth = 4,
        label = "Show Graphical Represnetation"
    }
    sceneGroup:insert(submitButton)

    local function changeScenes()
            composer.gotoScene("output", {effect="fromRight", time=800})
            composer.removeScene("menu")
    end

    local function submit()
        audio.play(tapSound)
        changeScenes()
    end

    submitButton:addEventListener("tap", submit)
end



function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end

-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene