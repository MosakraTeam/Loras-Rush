--główny obiekt który będzie zwracany jako heros
local class = {}

--czasy animacji (łatwiej bd zmienić)

local runTime = 1000
local neutralTime = 1200

--opcje neutralnej strony (to trzeba powielić dla wszystkich rodzajów animacji)
local h_neutral_SheetOption = {
    width = 72,
    height = 103,
    numFrames = 128
}

local h_run_SheetOption = {
    width = 68,
    height = 110,
    numFrames = 128
}

--strona neutralna (to trzeba powielić dla wszystkich rodzajów animacji)
local sheet_h_neutral = graphics.newImageSheet( "heroes/hBarb/neutral.png", h_neutral_SheetOption )
local sheet_h_run = graphics.newImageSheet( "heroes/hBarb/run.png", h_run_SheetOption )

--sekwencja animacji herosa (tu trzeba dodawać wszystkie nimacje z podziałęm na strnoy)
local sequences_h = {
    -- consecutive frames sequence
    -- neutral
    {
        name = "neutral-75",
        sheet = sheet_h_neutral,
        start = 17,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-9",
        sheet = sheet_h_neutral,
        start = 33,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-105",
        sheet = sheet_h_neutral,
        start = 49,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-12",
        sheet = sheet_h_neutral,
        start = 65,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-15",
        sheet = sheet_h_neutral,
        start = 81,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-3",
        sheet = sheet_h_neutral,
        start = 97,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-45",
        sheet = sheet_h_neutral,
        start = 113,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-6",
        sheet = sheet_h_neutral,
        start = 1,
        count = 8,
        time = neutralTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    -- run
    {
        name = "run-75",
        sheet = sheet_h_run,
        start = 17,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run-9",
        sheet = sheet_h_run,
        start = 33,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run-105",
        sheet = sheet_h_run,
        start = 49,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run-12",
        sheet = sheet_h_run,
        start = 65,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run-15",
        sheet = sheet_h_run,
        start = 81,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run-3",
        sheet = sheet_h_run,
        start = 97,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run-45",
        sheet = sheet_h_run,
        start = 113,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run-6",
        sheet = sheet_h_run,
        start = 1,
        count = 8,
        time = runTime,
        loopCount = 0,
        loopDirection = "forward"
    }
}

--funkcja tworząca herosa
local function hero(group, x, y, name)
    --główny obiekt herosa
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
    h['sprite'] = display.newSprite(group, sheet_h_neutral, sequences_h )
    h['sprite'].x = x
    h['sprite'].y = y
    h['sprite'].myName = name

    return h
end

class.hero = hero

return class