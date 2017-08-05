
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local lorasSheetOptions = {
    frames = {
        {   -- 1. loras run 1
            x = 70,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
		{   -- 2. loras run 2
            x = 155,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
		{   -- 3. loras run 3
            x = 240,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
		{   -- 4. loras run 4
            x = 325,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        }
    }
}

local lorasSheet = graphics.newImageSheet( "images/sLoras.png", lorasSheetOptions )

-- Configure image sequences
local lorasSequences = {
    -- non-consecutive frames sequence
    {
        name = "run",
        frames = { 1,2,3,4 },
        time = 500,
        loopCount = 0,
        loopDirection = "forward"
    }
}

local trawaSheetOptions = {
    frames = {
        {   -- 1. trawa 1
            x = 692,
            y = 751,
            width = 76,
            height = 77,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        }
    }
}

local guzikSheetOptions = {
    frames = {
        {   -- 1. lewo
            x = 0,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 1. prawo
            x = 100,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 1. a
            x = 200,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 1. b
            x = 300,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        
    }
}


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
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
