
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local backGroup
local grassGroup
local mainGroup
local uiGroup

local barbarian = {}

barbarian['stats'] = {}
barbarian['stats']['movementSpeed'] = 2
barbarian['flags'] = {}
barbarian['flags']['canMove'] = true
barbarian['seqName'] = "neutral"

local stworek = {}

stworek['stats'] = {}
stworek['stats']['movementSpeed'] = 1
stworek['flags'] = {}
stworek['flags']['canMove'] = true
stworek['seqName'] = "neutral"

local gameLoopTimer

local hBarb_neutralSheetOption =
{
    width = 72,
    height = 103,
    numFrames = 128
}

local sheet_hBarb_neutral = graphics.newImageSheet( "images/hBarb-neutral.png", hBarb_neutralSheetOption )

-- sequences table
local sequences_hBarb_neutral = {
    -- consecutive frames sequence
    {
        name = "neutral-7",
        sheet = sheet_hBarb_neutral,
        start = 9,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-75",
        sheet = sheet_hBarb_neutral,
        start = 17,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-8",
        sheet = sheet_hBarb_neutral,
        start = 25,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-9",
        sheet = sheet_hBarb_neutral,
        start = 33,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-10",
        sheet = sheet_hBarb_neutral,
        start = 41,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-105",
        sheet = sheet_hBarb_neutral,
        start = 49,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-11",
        sheet = sheet_hBarb_neutral,
        start = 57,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-12",
        sheet = sheet_hBarb_neutral,
        start = 65,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-1",
        sheet = sheet_hBarb_neutral,
        start = 73,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-15",
        sheet = sheet_hBarb_neutral,
        start = 81,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-2",
        sheet = sheet_hBarb_neutral,
        start = 89,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-3",
        sheet = sheet_hBarb_neutral,
        start = 97,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-4",
        sheet = sheet_hBarb_neutral,
        start = 105,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-45",
        sheet = sheet_hBarb_neutral,
        start = 113,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-5",
        sheet = sheet_hBarb_neutral,
        start = 121,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-6",
        sheet = sheet_hBarb_neutral,
        start = 1,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- -----------------------------------------------------------------------------------
-- Main Loop functions
-- -----------------------------------------------------------------------------------

function randomHero(enemy)
--tablica herosów
--mlem = math.rand(5)
--return heroTable[mlem]
end

function setGroupOrder(group)
    canSort = false 
    itmp = {}
    
    for i=1,group.numChildren do
        table.insert(itmp,i)
    end

    tmpitmp = itmp

    for i=1,group.numChildren-1 do
        for j=1,group.numChildren do
            if group[itmp[i]].y > group[itmp[j]].y then
                tmp = itmp[i]
                itmp[i] = itmp[j]
                itmp[j] = tmp
                canSort = true
            end
        end
    end

    for i=1,group.numChildren do
        print(itmp[i])
    end

        print('-------------------------')
    
    if canSort then
        for i=1,group.numChildren do
            group[itmp[i]]:toFront()
        end
    end
end

function setAnimation(hero, x,y)
    local seq
    if (y >= 0) and (x >= math.sin(math.rad(22,5))) and (x < math.sin(math.rad(67,5))) then seq = "15" 
    elseif (x >= math.sin(math.rad(67,5))) then seq = "3"
    elseif (y < 0) and (x >= math.sin(math.rad(22,5))) and (x < math.sin(math.rad(67,5))) then seq = "45" 
    elseif (math.abs(x) < math.sin(math.rad(22,5))) and (y < 0) then seq = "6"
    elseif (y < 0) and (x < -math.sin(math.rad(22,5))) and (x >= -math.sin(math.rad(67,5))) then seq = "75"
    elseif (x < -math.sin(math.rad(67,5))) then seq = "9"
    elseif (y >= 0) and (x < -math.sin(math.rad(22,5))) and (x >= -math.sin(math.rad(67,5))) then seq = "105" 
    elseif (math.abs(x) < math.sin(math.rad(22,5))) and (y >= 0) then seq = "12"
    end

    hero['sprite']:setSequence(hero['seqName'] .. '-' .. seq)
    
end

function checkColision(hero,enemy)
    x1 = hero['sprite'].x
    y1 = hero['sprite'].y
    w1 = hero['sprite'].width/4
    h1 = hero['sprite'].height/4

    x2 = enemy['sprite'].x
    y2 = enemy['sprite'].y
    w2 = enemy['sprite'].width/4
    h2 = enemy['sprite'].height/4

    difX = math.abs(x1 - x2)
    difY = math.abs(y1 - y2)

    sumW = w1 + w2
    sumH = h1 + h2

    if (sumW > difX) and (sumH > difY) then
        hero['flags']['canMove'] = false
        enemy['flags']['canMove'] = false
    else
        hero['flags']['canMove'] = true
        enemy['flags']['canMove'] = true
    end
end

function toPoint(hero,xy)
    if hero['flags']['canMove'] then
        startX = hero['sprite'].x
        startY = hero['sprite'].y
        endX = xy['x']
        endY = xy['y']
        speed = hero['stats']['movementSpeed']

        distance = math.sqrt(math.pow(endX-startX,2)+math.pow(endY-startY,2));

        directionX = (endX-startX) / distance;
        directionY = (startY-endY) / distance;

        setAnimation(hero, directionX, directionY)
        hero['sprite'].x = hero['sprite'].x + directionX * speed
        hero['sprite'].y = hero['sprite'].y - directionY * speed
    end
end

function toSprite(hero,enemy)
    if hero['flags']['canMove'] then
        startX = hero['sprite'].x
        startY = hero['sprite'].y
        endX = enemy['sprite'].x
        endY = enemy['sprite'].y
        speed = hero['stats']['movementSpeed']

        distance = math.sqrt(math.pow(endX-startX,2)+math.pow(endY-startY,2));

        directionX = (endX-startX) / distance;
        directionY = (startY-endY) / distance;

        setAnimation(hero, directionX, directionY)
        hero['sprite'].x = hero['sprite'].x + directionX * speed
        hero['sprite'].y = hero['sprite'].y - directionY * speed
    end
end

function moveEnemy(event) --temporary
    stworek['sprite'].x = event.x
    stworek['sprite'].y = event.y
end

local function gameLoop()
    toSprite(barbarian,stworek)
    toSprite(stworek,barbarian)
    checkColision(barbarian,stworek)
    setGroupOrder(mainGroup)
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

    -- Set up display groups
	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )  -- Insert into the scene's view group

    grassGroup = display.newGroup()
	sceneGroup:insert( grassGroup ) 

	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

	uiGroup = display.newGroup()    -- Display group for UI objects like the score
	sceneGroup:insert( uiGroup )    -- Insert into the scene's view group

    local background = display.newRect(backGroup,display.actualContentWidth/2,display.actualContentHeight/2,display.actualContentWidth,display.actualContentHeight)
	background:setFillColor(0,1,1,1);

    barbarian['sprite'] = display.newSprite(mainGroup, sheet_hBarb_neutral, sequences_hBarb_neutral )
    barbarian['sprite'].x = display.actualContentWidth/2
    barbarian['sprite'].y = display.actualContentHeight/2
    barbarian['sprite'].myName = "barbarian"

    barbarian['sprite']:setSequence( "neutral-45" )
    barbarian['sprite']:play()

    stworek['sprite'] = display.newSprite(mainGroup, sheet_hBarb_neutral, sequences_hBarb_neutral )
    stworek['sprite'].x = 280
    stworek['sprite'].y = 0
    stworek['sprite'].myName = "stworek"

    stworek['sprite']:setSequence( "neutral-105" )
    stworek['sprite']:play()

    background:addEventListener( "touch", moveEnemy )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        gameLoopTimer = timer.performWithDelay( 15, gameLoop, 0 )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
        timer.cancel( gameLoopTimer )
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
