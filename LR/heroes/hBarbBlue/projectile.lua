-- -----------------------------------------------------------------------------------------------------
-- TUTAJ MOŻNA COŚ ZMIENIAĆ ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

local folder = "hBarbBlue"

local sheetOptions = {
    p_fly_attack_1 = {
        width = 32, -- szerokość klatki
        height = 32, -- wysokość klatki
        numFrames = 16, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 0, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 32, -- zostawić 103
        sourceWidth = 32, -- szerokość klatki
        count = 2, -- ilość klatek w jednym wierszu pliku png
        time = 300, -- czas trwania animacji
        offsetX = 0,
        offsetY = 0
    }
}

-- -----------------------------------------------------------------------------------------------------
-- TUTAJ JUŻ NIE MOŻNA ZMIENIAĆ ------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

local arcTable = {
    "-6",
    "-75",
    "-9",
    "-105",
    "-12",
    "-15",
    "-3",
    "-45"
}

local class = {}

local sheets = {}

local sequences_h = {}

local function createSequences(sequences, name)
    sheets[name] = graphics.newImageSheet( "heroes/" .. folder .. "/" .. name .. ".png", sheetOptions[name] )
    number = sheetOptions[name]['numFrames']/(sheetOptions[name]['count'])
    for i=1, number do
        table.insert(sequences,{
            name = name .. arcTable[i],
            sheet = sheets[name],
            start = 1 + (i - 1) * (sheetOptions[name]['count']),
            count = sheetOptions[name]['count'],
            time = sheetOptions[name]['time'],
            loopCount = 0,
            loopDirection = "forward"
        })
    end
end

--funkcja tworząca herosa
local function projectile(group, x, y, name, enemy, targetX, targetY)
    --główny obiekt herosa

    local h = {}

    h['offset'] = {}

    for k,v in pairs(sheetOptions) do
        createSequences(sequences_h, k)
        h['offset'][k] = {}
        h['offset'][k]['x'] = v['offsetX']
        h['offset'][k]['y'] = v['offsetY']
    end

    --statystyki herosa
    h['stats'] = {}
    h['stats']['movementSpeed'] = 8
    h['stats']['dmg'] = 35
    h['stats']['dirX'] = 0
    h['stats']['dirY'] = 0

    --flagi herosa
    h['flags'] = {}
    h['flags']['isMove'] = true
    h['flags']['isAlive'] = true

    --nazwa początkowej sekwencji
    h['seqName'] = "p_fly_attack_1"

    h['myEnemy'] = enemy

    --tworzenie sprite o podanej grupie, pozycji i nazwie
    h['sprite'] = display.newSprite(group, sheets['p_fly_attack_1'], sequences_h )
    h['sprite'].x = x
    h['sprite'].y = y
    h['sprite'].myName = name

    return h
end

class.projectile = projectile

return class