--główny obiekt który będzie zwracany jako heros
local class = {}

--opcje neutralnej strony (to trzeba powielić dla wszystkich rodzajów animacji)
local h_neutral_SheetOption = {
    width = 72,
    height = 103,
    numFrames = 128
}

--strona neutralna (to trzeba powielić dla wszystkich rodzajów animacji)
local sheet_h_neutral = graphics.newImageSheet( "heroes/hBarb/neutral.png", h_neutral_SheetOption )

--sekwencja animacji herosa (tu trzeba dodawać wszystkie nimacje z podziałęm na strnoy)
local sequences_h = {
    -- consecutive frames sequence
    {
        name = "neutral-7",
        sheet = sheet_h_neutral,
        start = 9,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-75",
        sheet = sheet_h_neutral,
        start = 17,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-8",
        sheet = sheet_h_neutral,
        start = 25,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-9",
        sheet = sheet_h_neutral,
        start = 33,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-10",
        sheet = sheet_h_neutral,
        start = 41,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-105",
        sheet = sheet_h_neutral,
        start = 49,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-11",
        sheet = sheet_h_neutral,
        start = 57,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-12",
        sheet = sheet_h_neutral,
        start = 65,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-1",
        sheet = sheet_h_neutral,
        start = 73,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-15",
        sheet = sheet_h_neutral,
        start = 81,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-2",
        sheet = sheet_h_neutral,
        start = 89,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-3",
        sheet = sheet_h_neutral,
        start = 97,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-4",
        sheet = sheet_h_neutral,
        start = 105,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-45",
        sheet = sheet_h_neutral,
        start = 113,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-5",
        sheet = sheet_h_neutral,
        start = 121,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "neutral-6",
        sheet = sheet_h_neutral,
        start = 1,
        count = 8,
        time = 1200,
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