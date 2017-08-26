
local composer = require( "composer" )

local scene = composer.newScene()

local hBarb = require("heroes.hBarb.hero")
local hBarbRed = require("heroes.hBarbRed.hero")
local hBarbBlue = require("heroes.hBarbBlue.hero")
local spikeFiend = require("heroes.spikeFiend.hero")

local heroes = {}
local enemies = {}

local hpui = {}
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

function setNeutral(hero)
    hero['seqName'] = 'neutral'
end

function death(hero)
    if not (hero == nil) then
        hero['sprite']:removeEventListener("sprite",checkAnimation)
        hero['sprite'].alpha = 0
        hero['flags']['isAlive'] = false
    end
end

function attackEnemy(hero,enemy)
    if enemy['flags']['isAlive'] then
        if((hero['stats']['type'] == 'mele') or (hero['stats']['type'] == 'hitscan')) then
            enemy['stats']['hp'] = enemy['stats']['hp'] - ( hero['stats']['dmg'] + math.random(hero['stats']['dmg'] * 0.2) )
            if enemy['stats']['hp'] <= 0 then
                death(enemy)
                checkThreat(hero,hero['myEnemies'])
            end
        else 
        end
    end
end

function checkAnimation(event)
    sprite = event.target
    hero = nil
    if ( event.phase == "began" ) then 

	elseif ( event.phase == "ended" ) then 

    elseif ( event.phase == "loop") then
        local flag = nil

        for i in string.gmatch(sprite.sequence,"attack_1") do
            if not (i == nil) then flag = i end
        end

        if flag == 'attack_1' then
            for i,v in pairs(heroes) do
                if sprite.myName == v['sprite'].myName then
                    hero = v
                end
            end

            if hero == nil then
                for i,v in pairs(enemies) do
                    if sprite.myName == v['sprite'].myName then
                        hero = v
                    end
                end
            end
            attackEnemy(hero,hero['myEnemy'])
        end
    end
end

function setGroupAnimationListener(group)
    for i,v in pairs(group) do
        v['sprite']:addEventListener( "sprite", checkAnimation )
    end
end

function checkGroupCollision(group)
    for i,v in pairs(group) do
        if v['flags']['isAlive'] then
            checkColision(v,v['myEnemy'])
        end
    end
end

function moveGroupSprite(group)
    for i,v in pairs(group) do
        if v['flags']['isAlive'] then
            toSprite(v,v['myEnemy'])
        end
    end
end

function checkEnemyIsDead(group)
    for i,v in pairs(group) do
        if not v['myEnemy']['flags']['isAlive'] then
            checkThreat(v,v['myEnemies'])
        end
    end
end

function checkGroupThreat(group,enemy)
    for i,v in pairs(group) do
        checkThreat(v,enemy)
        print(v['myEnemy']['sprite'].myName)
    end
end

function checkThreat(hero, group)
    if hero['flags']['isAlive'] then
        local myThreat = hero['stats']['threat']
        local biggestThreat = -1
        local similarThreat = {}

        for i,v in pairs(group) do
            if v['flags']['isAlive'] then
                if (0.9 * myThreat <= v['stats']['threat']) and (1.1 * myThreat >= v['stats']['threat']) then
                    table.insert(similarThreat,i)
                end

                if (biggestThreat == -1) or (v['stats']['threat'] > group[biggestThreat]['stats']['threat']) then
                    biggestThreat = i
                end
            end
        end

        if #similarThreat == 0 then
            if not (biggestThreat == -1) then
                hero['myEnemy'] = group[biggestThreat]
            else
                setNeutral(hero)
            end
        else
            hero['myEnemy'] = group[similarThreat[math.random(#similarThreat)]]
        end
    end
end

function setGroupOrder(group)
    canSort = false 
    itmp = {}
    
    for i=1,group.numChildren do
        table.insert(itmp,i)
    end

    --tmpitmp = itmp

    for j=1,group.numChildren do
        for i=1,group.numChildren-1 do
            if group[itmp[i]].y > group[itmp[i+1]].y then
                tmp = itmp[i]
                itmp[i] = itmp[i+1]
                itmp[i+1] = tmp
                canSort = true
            end
        end
    end
    
    if canSort then
        for i=1,group.numChildren do
            group:insert(i,group[itmp[i]])
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
    if (not (enemy == nil)) and enemy['flags']['isAlive'] then
        x1 = hero['sprite'].x
        y1 = hero['sprite'].y
        w1 = hero['sprite'].width/4
        h1 = hero['sprite'].height/8

        x2 = enemy['sprite'].x
        y2 = enemy['sprite'].y
        w2 = enemy['sprite'].width/4
        h2 = enemy['sprite'].height/8

        difX = math.abs(x1 - x2)
        difY = math.abs(y1 - y2)

        dis = math.sqrt(math.pow(difX,2) + math.pow(difY,2))

        sumW = w1 + w2
        sumH = h1 + h2

        if ((sumW > difX) and (sumH > difY)) or (dis < hero['stats']['range']) then
            hero['flags']['canMove'] = false

            hero['seqName'] = 'attack_1'
        else
            hero['flags']['canMove'] = true

            hero['seqName'] = 'run'
        end
    else
        setNeutral(hero)
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
    if (not (enemy == nil)) and enemy['flags']['isAlive'] then
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
    else
        setAnimation(hero, 0, -1)
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

function createStatsUI(group,y)
    count = 0
    for i,v in pairs(group) do
        if v['flags']['isAlive'] then
            hpui[v['sprite'].myName] = display.newText( uiGroup, v['sprite'].myName .. ' hp: ' .. v['stats']['hp'], 0, y + 14 * count, native.systemFont, 12 )
            hpui[v['sprite'].myName].x = hpui[v['sprite'].myName].width/2 + 2
            count = count + 1
        end
    end
end

function showHP(group)
    for i,v in pairs(group) do
        if v['flags']['isAlive'] then
            hpui[v['sprite'].myName].text = v['sprite'].myName .. ' hp: ' .. v['stats']['hp'] .. ' ' .. v['myEnemy']['sprite'].myName
            hpui[v['sprite'].myName].x = hpui[v['sprite'].myName].width/2 + 2
        else
            hpui[v['sprite'].myName].text = v['sprite'].myName .. ' is death' .. ' ' .. v['myEnemy']['sprite'].myName
            hpui[v['sprite'].myName].x = hpui[v['sprite'].myName].width/2 + 2
        end
    end
end

local function gameLoop()
    setGroupOrder(mainGroup)
    moveGroupSprite(heroes)
    moveGroupSprite(enemies)
    checkGroupCollision(heroes)
    checkGroupCollision(enemies)
    checkEnemyIsDead(heroes)
    checkEnemyIsDead(enemies)
    showHP(heroes)
    showHP(enemies)
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

    barbarian = hBarb.hero(mainGroup, 50, 60, 'barbarian')
    barbarian['stats']['threat'] = 100
    table.insert(heroes,barbarian)
    barbarian['myGroup'] = heroes
    barbarian['myEnemies'] = enemies

    barbarian2 = hBarbRed.hero(mainGroup, 50, 120, 'barbarian2')
    barbarian2['stats']['threat'] = 50
    table.insert(heroes,barbarian2)
    barbarian2['myGroup'] = heroes
    barbarian2['myEnemies'] = enemies

    barbarian3 = hBarbBlue.hero(mainGroup, 50, 120, 'barbarian3')
    barbarian3['stats']['threat'] = 60
    table.insert(heroes,barbarian3)
    barbarian3['myGroup'] = heroes
    barbarian3['myEnemies'] = enemies

    --[[barbarian3 = hBarb.hero(mainGroup, 50, 180, 'barbarian3')
    barbarian3['stats']['threat'] = 300
    table.insert(heroes,barbarian3)

    barbarian4 = hBarb.hero(mainGroup, 50, 240, 'barbarian4')
    barbarian4['stats']['threat'] = 400
    table.insert(heroes,barbarian4)

    barbarian5 = hBarb.hero(mainGroup, 50, 320, 'barbarian5')
    barbarian5['stats']['threat'] = 500
    table.insert(heroes,barbarian5)]]

    stworek = spikeFiend.hero(mainGroup, 590, 60, 'stworek')
    stworek['stats']['threat'] = 100
    table.insert(enemies,stworek)
    stworek['myGroup'] = enemies
    stworek['myEnemies'] = heroes

    stworek2 = spikeFiend.hero(mainGroup, 590, 120, 'stworek2')
    stworek2['stats']['threat'] = 103
    table.insert(enemies,stworek2)
    stworek2['myGroup'] = enemies
    stworek2['myEnemies'] = heroes

    stworek3 = spikeFiend.hero(mainGroup, 590, 180, 'stworek3')
    stworek3['stats']['threat'] = 303
    table.insert(enemies,stworek3)
    stworek3['myGroup'] = enemies
    stworek3['myEnemies'] = heroes

    stworek4 = spikeFiend.hero(mainGroup, 590, 240, 'stworek4')
    stworek4['stats']['threat'] = 203
    table.insert(enemies,stworek4)
    stworek4['myGroup'] = enemies
    stworek4['myEnemies'] = heroes

    stworek5 = spikeFiend.hero(mainGroup, 590, 320, 'stworek5')
    stworek5['stats']['threat'] = 103
    table.insert(enemies,stworek5)
    stworek5['myGroup'] = enemies
    stworek5['myEnemies'] = heroes

    background:addEventListener( "touch", moveEnemy )

    createStatsUI(heroes, 7)
    createStatsUI(enemies, 7 + #heroes * 14)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        setGroupAnimationListener(heroes)
        setGroupAnimationListener(enemies)
        checkGroupThreat(heroes,enemies)
        checkGroupThreat(enemies,heroes)
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
