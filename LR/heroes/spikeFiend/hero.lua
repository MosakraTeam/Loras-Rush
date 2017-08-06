-- -----------------------------------------------------------------------------------------------------
-- TUTAJ MOŻNA COŚ ZMIENIAĆ ----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

local folder = "spikeFiend"

local sheetOptions = {
    neutral = {
        width = 87,
        height = 55,
        numFrames = 64,
        sourceX = 0,
        sourceY = 48,
        sourceHeight = 103,
        sourceWidth = 87,
        count = 8,
        time = 1200
    },
    run = {
        width = 88,
        height = 52,
        numFrames = 72,
        sourceX = 0,
        sourceY = 58,
        sourceHeight = 110,
        sourceWidth = 88,
        count = 9,
        time = 1000
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

    for k,v in pairs(sheetOptions) do
        createSequences(sequences_h, k)
    end

    local h = {}

    --statystyki herosa
    h['stats'] = {}
    h['stats']['movementSpeed'] = 2

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