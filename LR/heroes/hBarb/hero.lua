-- -----------------------------------------------------------------------------------------------------
-- TUTAJ MOŻNA COŚ ZMIENIAĆ ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

local folder = "hBarb"

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
        time = 1200 -- czas trwania animacji
    },
    run = {
        width = 68, -- szerokość klatki
        height = 110, -- wysokość klatki
        numFrames = 128, -- łączna liczba wszystkich klatek w pliku png
        sourceX = 0, -- zostawić 0
        sourceY = 0, -- wysokość klatki hBarb dla tej animacji - wysokość klatki
        sourceHeight = 110, -- wysokość klatki hBarb dla tej animacji
        sourceWidth = 68, -- szerokość klatki
        count = 8, -- ilość klatek w jednym wierszu pliku png
        time = 1000 -- czas trwania animacji
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

    for k,v in pairs(sheetOptions) do
        createSequences(sequences_h, k)
    end

    local h = {}

    --statystyki herosa
    h['stats'] = {}
    h['stats']['movementSpeed'] = 4

    --flagi herosa
    h['flags'] = {}
    h['flags']['canMove'] = true

    --nazwa początkowej sekwencji
    h['seqName'] = "neutral"

    --tworzenie sprite o podanej grupie, pozycji i nazwie
    h['sprite'] = display.newSprite(group, sheets['neutral'], sequences_h )
    h['sprite'].x = x
    h['sprite'].y = y
    h['sprite'].myName = name

    return h
end

class.hero = hero

return class