-----------------------------------------------------------------------------------------
--
-- ui.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local knn_data = require("data")

local scene = composer.newScene()

function scene:create( event )
    local sceneGroup = self.view

    local widget = require("widget")

    local title = display.newText("KNN Algorithm Simulator", 0, 0, native.systemFont, 25)
    title.x = display.contentWidth / 2
    title.y  = display.contentHeight / 20
    title:setTextColor(0,0,0)
    sceneGroup:insert(title)

    local textBoxX = native.newTextField( 0, 0, 100, 35 )
    textBoxX.inputType = "decimal"
    textBoxX.x = display.contentWidth / 3.6
    textBoxX.y = display.contentHeight / 7
    textBoxX.isEditable = true
    textBoxX.size = 20
    textBoxX.placeholder = "X-Value"
    textBoxX.align = "center"
    sceneGroup:insert(textBoxX)

    local textBoxY = native.newTextField( 0, 0, 100, 35 )
    textBoxY.inputType = "decimal"
    textBoxY.x = display.contentWidth / 1.38
    textBoxY.y  = display.contentHeight  / 7
    textBoxY.isEditable = true
    textBoxY.size =  20
    textBoxY.align = "center"
    textBoxY.placeholder = "Y-Value"
    sceneGroup:insert(textBoxY)

    local KValue = native.newTextField( 0, 0, 250, 35 )
    KValue.inputType = "number"
    KValue.x = display.contentWidth / 2
    KValue.y = display.contentHeight / 3.5
    KValue.isEditable = true
    KValue.size = 20
    KValue.align = "center"
    KValue.placeholder = "K-Value"
    sceneGroup:insert(KValue)

    local weights = display.newText("Unitary Weights", 0, 0, native.systemFont, 17)
    weights.x = display.contentWidth / 2.6
    weights.y = display.contentHeight / 2.35
    weights:setTextColor(0,0,0)
    sceneGroup:insert(weights)

    unitweights = widget.newSwitch
    {
        left = display.contentWidth / 1.6,
        top = display.contentHeight / 2.5,
        style = "onOff",
        id = "onOffSwitch"
    }
    sceneGroup:insert(unitweights)

    -- Set up the picker wheel columns
    local columnData =
    {
        {
            align = "center",
            width = display.contentWidth,
            labelPadding = 5,
            startIndex = 1,
            labels = { "Euclidean Distance", "Manhattan Distance", "Bray Curtis Distance", "Chebyshev Distance" }
        }
    }

    local pickerWheel = widget.newPickerWheel(
    {
        x = display.contentWidth / 2,
        top = display.contentHeight / 1.75,
        columns = columnData,
        style = "resizable",
        width = display.contentWidth,
        rowHeight = 30,
        fontSize = 15,
        columnColor = { 0.65, 0.65, 0.65 },
        fontColor = { 0.5, 0.5, 0.5 },
        fontColorSelected = { 0, 0, 0 }
    })

    sceneGroup:insert(pickerWheel)


    local function isEmpty(field)
        if field == "" then
            return true
        end

        return false
    end

    local submitButton = widget.newButton{
        left = display.contentWidth/2.5,
        top = display.contentHeight/1.1,
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
        label = "Submit"
    }
    sceneGroup:insert(submitButton)

    local function changeScenes()
        if not isEmpty(textBoxX.text) and not isEmpty(textBoxY.text) then
            composer.gotoScene("menu", {effect="fromRight", time=800})
            composer.removeScene("ui")
        end
    end

    local emptyXCoordinate = display.newText("X-Coordinate is required", 0, 0,  native.systemFont, 15)
    emptyXCoordinate.x = display.contentWidth /  2
    emptyXCoordinate.y = display.contentHeight / 4.7
    emptyXCoordinate:setTextColor(1,0,0)
    emptyXCoordinate.isVisible = false

    local emptyYCoordinate = display.newText("Y-Coordinate is required", 0, 0,  native.systemFont, 15)
    emptyYCoordinate.x = display.contentWidth /  2
    emptyYCoordinate.y = display.contentHeight / 4.7
    emptyYCoordinate:setTextColor(1,0,0)
    emptyYCoordinate.isVisible = false

    local emptyXYCoordinate = display.newText("X and Y Coordinates are required", 0, 0,  native.systemFont, 15)
    emptyXYCoordinate.x = display.contentWidth /  2
    emptyXYCoordinate.y = display.contentHeight / 4.7
    emptyXYCoordinate:setTextColor(1,0,0)
    emptyXYCoordinate.isVisible = false

    local emptyKValue = display.newText("K-Value is required", 0, 0,  native.systemFont, 15)
    emptyKValue.x = display.contentWidth /  2
    emptyKValue.y = display.contentHeight / 2.8
    emptyKValue:setTextColor(1,0,0)
    emptyKValue.isVisible = false

    local invalidKValue = display.newText("K-Value should be between 1 and " .. #knn_data, 0, 0,  native.systemFont, 15)
    invalidKValue.x = display.contentWidth /  2
    invalidKValue.y = display.contentHeight / 2.7
    invalidKValue:setTextColor(1,0,0)
    invalidKValue.isVisible = false

    local function submit()
        local values = pickerWheel:getValues()
        currentDistanceMetric = values[1].value
        xcor = textBoxX.text
        ycor = textBoxY.text
        k_value = tonumber(KValue.text)
        data = knn_data
        emptyXCoordinate.isVisible = false
        emptyYCoordinate.isVisible = false
        emptyXYCoordinate.isVisible = false
        emptyKValue.isVisible = false
        audio.play(tapSound)
        print(xcor.."Xcor")
        print(ycor.."YCOR")
        if isEmpty(textBoxX.text) and isEmpty(textBoxY.text) then
            emptyXYCoordinate.isVisible = true
            sceneGroup:insert(emptyXYCoordinate)
        elseif isEmpty(textBoxX.text) then
            emptyXCoordinate.isVisible = true
            sceneGroup:insert(emptyXCoordinate)
        elseif isEmpty(textBoxY.text)  then
            emptyYCoordinate.isVisible = true
            sceneGroup:insert(emptyYCoordinate)
        end

        if isEmpty(KValue.text)  then
            emptyKValue.isVisible = true
            sceneGroup:insert(emptyKValue)
            return
        end
        if k_value < 1 or k_value > #knn_data then
            invalidKValue.isVisible = true
            sceneGroup:insert(invalidKValue)
            return
        end

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

-- local defaultBox
 
-- local function textListener( event )
 
--     if ( event.phase == "began" ) then
--         -- User begins editing "defaultBox"
 
--     elseif ( event.phase == "ended" or event.phase == "submitted" ) then
--         -- Output resulting text from "defaultBox"
--         print( event.target.text )
 
--     elseif ( event.phase == "editing" ) then
--         print( event.newCharacters )
--         print( event.oldText )
--         print( event.startPosition )
--         print( event.text )
--     end
-- end
 

-- defaultBox = native.newTextField( display.contentCenterX, 0, 100, 20 )
-- defaultBox.isEditable = true
-- defaultBox:addEventListener( "userInput", textListener )

