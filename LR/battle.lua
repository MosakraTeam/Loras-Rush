
local composer = require( "composer" )

local scene = composer.newScene()

local hBarb = require("heroes.hBarb.hero")
local spikeFiend = require("heroes.spikeFiend.hero")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local backGroup
local grassGroup
local mainGroup
local uiGroup

local stworek = {}

local barbarian = {}

local gameLoopTimer

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
    
    if canSort then
        for i=1,group.numChildren do
            group[itmp[i]]:toFront()
        end
    end
end

function setAnimation(hero, x,y)
    local seq = '45'
    local sin225 = math.sin(math.rad(22,5))
    local sin675 = math.sin(math.rad(67,5))
    if (y >= 0) and (x >= sin225) and (x < sin675) then seq = "15" 
    elseif (x >= sin675) then seq = "3"
    elseif (y < 0) and (x >= sin225) and (x < sin675) then seq = "45" 
    elseif (math.abs(x) < sin225) and (y < 0) then seq = "6"
    elseif (y < 0) and (x < -sin225) and (x >= -sin675) then seq = "75"
    elseif (x < -sin675) then seq = "9"
    elseif (y >= 0) and (x < -sin225) and (x >= -sin675) then seq = "105" 
    elseif (math.abs(x) < sin225) and (y >= 0) then seq = "12"
    end

    --print(hero['seqName'])

    if not (hero['sprite'].sequence == hero['seqName'] .. '-' .. seq) then
        frame = hero['sprite'].frame
        mainName = string.gmatch(hero['sprite'].sequence,'-')

        hero['sprite']:setSequence(hero['seqName'] .. '-' .. seq)

        if mainName == hero['seqName'] then
            hero['sprite']:setFrame(frame)
        end
        
        hero['sprite']:play()
    end
    
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

        hero['seqName'] = 'neutral'
    else
        hero['flags']['canMove'] = true

        hero['seqName'] = 'run'
    end
end

function toPoint(hero,xy)
    
    startX = hero['sprite'].x
    startY = hero['sprite'].y
    endX = xy['x']
    endY = xy['y']
    speed = hero['stats']['movementSpeed']

    distance = math.sqrt(math.pow(endX-startX,2)+math.pow(endY-startY,2));

    directionX = (endX-startX) / distance;
    directionY = (startY-endY) / distance;

    setAnimation(hero, directionX, directionY)

    if hero['flags']['canMove'] then
        hero['sprite'].x = hero['sprite'].x + directionX * speed
        hero['sprite'].y = hero['sprite'].y - directionY * speed
    end
end

function toSprite(hero,enemy)
    
    startX = hero['sprite'].x
    startY = hero['sprite'].y
    endX = enemy['sprite'].x
    endY = enemy['sprite'].y
    speed = hero['stats']['movementSpeed']

    distance = math.sqrt(math.pow(endX-startX,2)+math.pow(endY-startY,2));

    directionX = (endX-startX) / distance;
    directionY = (startY-endY) / distance;

    setAnimation(hero, directionX, directionY)
    
    if hero['flags']['canMove'] then
        hero['sprite'].x = hero['sprite'].x + directionX * speed
        hero['sprite'].y = hero['sprite'].y - directionY * speed
    end
end

function moveEnemy(event) --temporary
    stworek['sprite'].x = event.x
    stworek['sprite'].y = event.y
end

function debugSpritePrint(sprite) 
    print(sprite.myName .. ' ' .. sprite.x .. ' ' .. sprite.y)
    print(sprite.sequence)
end

local function gameLoop()
    toSprite(barbarian,stworek)
    toSprite(stworek,barbarian)
    toSprite(stworek2,barbarian)
    checkColision(barbarian,stworek)
    checkColision(stworek,barbarian)
    checkColision(stworek2,barbarian)
    setGroupOrder(mainGroup)
    --debugSpritePrint(barbarian['sprite'])
    --debugSpritePrint(stworek['sprite'])
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

    barbarian = hBarb.hero(mainGroup, display.actualContentWidth/2, display.actualContentHeight/2, 'barbarian')

    stworek = spikeFiend.hero(mainGroup, display.actualContentWidth/2 - 50, 50, 'stworek')
    stworek2 = spikeFiend.hero(mainGroup, display.actualContentWidth/2 + 50, 310, 'stworek2')

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
