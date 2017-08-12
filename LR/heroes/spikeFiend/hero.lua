-- -----------------------------------------------------------------------------------------------------
-- TUTAJ MOŻNA COŚ ZMIENIAĆ ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

local folder = "spikeFiend"

local sheetOptions = {
    neutral = {
        width = 87, -- szerokość klatki
        height = 55, -- wysokość klatki
        numFrames = 64, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 48, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 103, -- wysokość klatki hBarb dla tej animacji
        sourceWidth = 87, -- szerokość klatki
        count = 8, -- ilość klatek w jednym wierszu pliku png
        time = 1200, -- czas trwania animacji
        offsetX = 0,
        offsetY = 0
    },
    run = {
        width = 88, -- szerokość klatki
        height = 52, -- wysokość klatki
        numFrames = 72, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 65, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 142, -- wysokość klatki hBarb dla tej animacji
        sourceWidth = 88, -- szerokość klatki
        count = 9, -- ilość klatek w jednym wierszu pliku png
        time = 1000, -- czas trwania animacji
        offsetX = 0,
        offsetY = 0
    },
    attack_1 = {
        width = 89, -- szerokość klatki
        height = 68, -- wysokość klatki
        numFrames = 128, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 50, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 142, -- wysokość klatki hBarb dla tej animacji
        sourceWidth = 89, -- szerokość klatki
        count = 16, -- ilość klatek w jednym wierszu pliku png
        time = 1000, -- czas trwania animacji
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
    number = sheetOptions[name]['numFrames']/sheetOptions[name]['count']
    for i=1, number do
        table.insert(sequences,{
            name = name .. arcTable[i],
            sheet = sheets[name],
            start = 1 + (i - 1) * sheetOptions[name]['count'],
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
    h['stats']['movementSpeed'] = 2
    h['stats']['hp'] = 200
    h['stats']['dmg'] = 5

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