-----------------------------------------------------------------------------------------
--
-- fileupload.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()

local function doesFileExist( filename, path )

    local results = false

    local filePath = system.pathForFile( filename, path )

    if ( filePath ) then
        local file, errorString = io.open( filePath, "r" )

        if not file then
            print( "File error: " .. errorString )
        else
            results = true
            file:close()
        end
    end

    return results
end

function scene:create( event )
    local sceneGroup = self.view

    local widget = require("widget")

    local title = display.newText("KNN Algorithm Demonstrator", 0, 0, native.systemFont, 25)
    title.x = display.contentWidth / 2
    title.y  = display.contentHeight / 10
    title:setTextColor(0,0,0)
    sceneGroup:insert(title)

    local textBoxfilename = native.newTextField( 0, 0, 250, 35 )
    textBoxfilename.x = display.contentWidth / 2
    textBoxfilename.y = display.contentHeight / 2.5
    textBoxfilename.isEditable = true
    textBoxfilename.size = 20
    textBoxfilename.align = "center"
    textBoxfilename.placeholder = "File Name"
    sceneGroup:insert(textBoxfilename)


    local function isEmpty(field)
        if field == "" then
            return true
        end

        return false
    end

    local submitButton = widget.newButton{
        left = display.contentWidth/2.6,
        top = display.contentHeight/1.7,
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
        if not isEmpty(textBoxfilename.text) then
            composer.gotoScene("ui", {effect="fromRight", time=800})
            composer.removeScene("fileupload")
        end
    end

    local emptyFilename = display.newText("File Name is required", 0, 0,  native.systemFont, 15)
    emptyFilename.x = display.contentWidth /  2
    emptyFilename.y = display.contentHeight / 2
    emptyFilename:setTextColor(1,0,0)
    emptyFilename.isVisible = false

    local invalidFileName = display.newText("Please enter a .csv file name", 0, 0, native.systemFont, 15)
    invalidFileName.x = display.contentWidth / 2
    invalidFileName.y = display.contentHeight / 2
    invalidFileName:setTextColor(1,0,0)
    invalidFileName.isVisible = false

    local fileDoesNotExist = display.newText("Given file name does not exist", 0, 0, native.systemFont, 15)
    fileDoesNotExist.x = display.contentWidth / 2
    fileDoesNotExist.y = display.contentHeight / 2
    fileDoesNotExist:setTextColor(1,0,0)
    fileDoesNotExist.isVisible = false

    local function submit()
        filename = textBoxfilename.text
        emptyFilename.isVisible = false
        invalidFileName.isVisible = false
        audio.play(tapSound)
        if isEmpty(textBoxfilename.text) then
            emptyFilename.isVisible = true
            sceneGroup:insert(emptyFilename)
            return
        end
        if not string.match(filename, '^.+\.([cC][sS][vV])$') then
            invalidFileName.isVisible = true
            sceneGroup:insert(invalidFileName)
            return
        end
        if not doesFileExist( filename, system.DocumentsDirectory ) then
            fileDoesNotExist.isVisible = true
            sceneGroup:insert(fileDoesNotExist)
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

