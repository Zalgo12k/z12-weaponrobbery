Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = Config or {}

Config.Timeout = 45 * (60 * 1000) --Süsre

Config.RequiredCops = 1 --Gerekli Polis



Config.VitrineRewards = {    --Çıkacaklar Itemler
    [1] = {
        ["item"] = "WEAPON_KNIFE",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 1
        },
    },
    [2] = {
        ["item"] = "WEAPON_MACHETE",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 1
        },
    },
    [3] = {
        ["item"] = "disc_ammo_pistol",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 5
        },
    },
    [4] = {
        ["item"] = "fullarmor",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 1
        },
    },
    [5] = {
        ["item"] = "handcuffs",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 1
        },
    },
}

Config.Locations = {    --Vitrin yerleeri
    [1] = {
        ["coords"] = {
            ["x"] = 812.29016, 
            ["y"] = -2157.779, 
            ["z"] = 29.79703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [2] = {
        ["coords"] = {
            ["x"] = 810.25803, 
            ["y"] = -2157.729, 
            ["z"] = 29.62703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [3] = {
        ["coords"] = {
            ["x"] = 809.49573, 
            ["y"] = -2156.928, 
            ["z"] = 29.62703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [4] = {
        ["coords"] = {
            ["x"] = 808.63193, 
            ["y"] = -2155.0245, 
            ["z"] = 29.62703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [5] = {
        ["coords"] = {
            ["x"] = 812.76098, 
            ["y"] = -2153.909, 
            ["z"] = 29.62703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [6] = {
        ["coords"] = {
            ["x"] = 812.63398, 
            ["y"] = -2151.56, 
            ["z"] = 29.79703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    }, 
    [7] = {
        ["coords"] = {
            ["x"] = 16.42097, 
            ["y"] = -1111.644, 
            ["z"] = 29.79703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [8] = {
        ["coords"] = {
            ["x"] = 17.06785, 
            ["y"] = -1109.49, 
            ["z"] = 29.79703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [9] = {
        ["coords"] = {
            ["x"] = 23.87246, 
            ["y"] = -1107.893, 
            ["z"] = 29.79703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [10] = {
        ["coords"] = {
            ["x"] = 20.58178, 
            ["y"] = -1104.759, 
            ["z"] = 29.79703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [11] = {
        ["coords"] = {
            ["x"] = 22.61839, 
            ["y"] = -1105.49, 
            ["z"] = 29.79703,
        },
        ["isOpened"] = false,
        ["isBusy"] = false, 
    }
}
