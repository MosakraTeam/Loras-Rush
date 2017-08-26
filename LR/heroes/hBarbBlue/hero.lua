-- -----------------------------------------------------------------------------------------------------
-- TUTAJ MOŻNA COŚ ZMIENIAĆ ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------
local projectile = require("heroes.hBarbBlue.projectile")

local folder = "hBarbBlue"

local sheetOptions = {
    neutral = {
        width = 72, -- szerokość klatki
        height = 103, -- wysokość klatki
        numFrames = 128, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 0, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 103, -- zostawić 103
        sourceWidth = 72, -- szerokość klatki
        count = 8, -- ilość klatek w jednym wierszu pliku png
        time = 1200, -- czas trwania animacji
        offsetX = 0,
        offsetY = 0
    },
    run = {
        width = 68, -- szerokość klatki
        height = 110, -- wysokość klatki
        numFrames = 128, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 0, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 142, -- wysokość klatki hBarb dla tej animacji
        sourceWidth = 68, -- szerokość klatki
        count = 8, -- ilość klatek w jednym wierszu pliku png
        time = 1000, -- czas trwania animacji
        offsetX = 0,
        offsetY = 0
    },
    attack_1 = {
        width = 182, -- szerokość klatki
        height = 142, -- wysokość klatki
        numFrames = 256, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 0, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 142, -- wysokość klatki hBarb dla tej animacji
        sourceWidth = 182, -- szerokość klatki
        count = 16, -- ilość klatek w jednym wierszu pliku png
        time = 1000, -- czas trwania animacji
        offsetX = 0,
        offsetY = 50
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
    number = sheetOptions[name]['numFrames']/(sheetOptions[name]['count']*2)
    for i=1, number do
        table.insert(sequences,{
            name = name .. arcTable[i],
            sheet = sheets[name],
            start = 1 + (i - 1) * (sheetOptions[name]['count']*2),
            count = sheetOptions[name]['count'],
            time = sheetOptions[name]['time'],
            loopCount = 0,
            loopDirection = "forward"
        })
    end
end

--funkcja tworząca herosa
local function hero(group, x, y, name)
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
    h['stats']['movementSpeed'] = 4
    h['stats']['hp'] = 500
    h['stats']['maxhp'] = 500
    h['stats']['dmg'] = 35
    h['stats']['type'] = 'projectile'
    h['stats']['range'] = 330

    h['projectiles'] = projectile

    --flagi herosa
    h['flags'] = {}
    h['flags']['canMove'] = true
    h['flags']['isAlive'] = true

    --nazwa początkowej sekwencji
    h['seqName'] = "neutral"

    h['myEnemy'] = nil

    --tworzenie sprite o podanej grupie, pozycji i nazwie
    h['sprite'] = display.newSprite(group, sheets['neutral'], sequences_h )
    h['sprite'].x = x
    h['sprite'].y = y
    h['sprite'].myName = name

    return h
end

class.hero = hero

return class