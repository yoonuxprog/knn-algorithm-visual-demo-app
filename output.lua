-----------------------------------------------------------------------------------------
--
-- output.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )

	local sceneGroup = self.view

	local widget = require("widget")

	local knn  = require("knn")

	local xvalue = xcor
    local yvalue = ycor
    local kvalue =  k_value

    local class = KNNalgorithm(xvalue, yvalue, kvalue)

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
		composer.removeScene("output")
	end

    homeButton:addEventListener("tap", goHome)

	print("class is")
	print(class)
	-- legend = display.newText("CLASS A = X ; CLASS B = O", display.contentCenterX,0,native.system ,10)
	-- sceneGroup:insert(legend)

		local liney = display.newLine(10, 90, 10, display.contentHeight)
		liney.strokeWidth = 2
		liney:setStrokeColor(0,0,0)
		sceneGroup:insert(liney)
		local arrowy1 = display.newLine(10, 90, 0, 100)
		arrowy1:setStrokeColor(0,0,0)
		sceneGroup:insert(arrowy1)
		local arrowy2 = display.newLine(10, 90, 20, 100)
		arrowy2:setStrokeColor(0,0,0)
		sceneGroup:insert(arrowy2)

		local linex = display.newLine(0, display.contentHeight-10, display.contentWidth, display.contentHeight-10)
		linex.strokeWidth = 2
		linex:setStrokeColor(0,0,0)
		sceneGroup:insert(linex)
		local arrowx1 = display.newLine(display.contentWidth, display.contentHeight-10, display.contentWidth-10, display.contentHeight)
		arrowx1:setStrokeColor(0,0,0)
		sceneGroup:insert(arrowx1)
		local arrowx2 = display.newLine(display.contentWidth, display.contentHeight-10, display.contentWidth-10, display.contentHeight-20)
		arrowx2:setStrokeColor(0,0,0)
		sceneGroup:insert(arrowx2)



		for k, v in pairs(datawithdist) do
			if v[3] == "a" then
				dataPoint = display.newText("A", v[1]*30, display.contentHeight-(v[2]*30), native.systemFont, 15)
				dataPoint:setFillColor(0.29,0,0.51)
				dataPoint.alpha = 0
				transition.fadeIn( dataPoint, { time=2000 } )
				sceneGroup:insert(dataPoint)
			else
				dataPoint = display.newText("B", v[1]*30, display.contentHeight-(v[2]*30), native.systemFont, 15)
				dataPoint:setFillColor(1,0,1)
				dataPoint.alpha = 0
				transition.fadeIn( dataPoint, { time=2000 } )
				sceneGroup:insert(dataPoint)
			end
		end


	x = (neighbours[k_value][1] * 30) - (xcor*30)
	y = (display.contentHeight - (neighbours[k_value][2] * 30)) - (display.contentHeight-(ycor*30))

	radius =  math.sqrt((math.pow( x, 2 )) + (math.pow( y, 2 )))

	local newPoint = display.newText("X", xcor*30, display.contentHeight-(ycor*30), native.systemFont, 15)
	newPoint:setFillColor(1,0,0,1)
	sceneGroup:insert(newPoint)

	local circle = display.newCircle( xcor*30, display.contentHeight-(ycor*30), 0 )
	circle.path.radius = radius
	circle:setStrokeColor(1,0,0)
	circle.strokeWidth = 1
	circle:setFillColor(1,0,0)
	sceneGroup:insert(circle)
	transition.to( circle.path, { time=2000, radius=0 } )

	local neighbours = display.newCircle(xcor*30, display.contentHeight-(ycor*30), radius)
	neighbours:setStrokeColor(1,0,0)
	neighbours.strokeWidth = 1
	neighbours:setFillColor(1,0,0,0)
	sceneGroup:insert(neighbours)
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


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene