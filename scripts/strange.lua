local chat = require("chat");

local zones = {
    [191] = { offset = 0, element = "Fire", chip = "Red"}, -- Dangruf Wadi
    [196] = { offset = 1, element = "Earth", chip = "Yellow"}, -- Gusgen Mines
    [197] = { offset = 2, element = "Water", chip = "Blue"}, -- Crawlers' Nest
    [193] = { offset = 3, element = "Wind", chip = "Green"}, -- Ordelle's Caves
    [195] = { offset = 4, element = "Ice", chip = "Clear"}, -- Eldieme Necropolis
    [194] = { offset = 5, element = "Lightning", chip = "Purple"}, -- Outer Horutoto Ruins
    [200] = { offset = 6, element = "Light", chip = "White"}, -- Garlaige Citadel
    [198] = { offset = 7, element = "Dark", chip = "Black"}, -- Maze of Shakrami
};

local zone_id = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
local zone = zones[zone_id];

if (not zone) then
    print(chat.header("strange"):append(chat.error("This is not a zone with a strange apparatus.")));
    return;
end

local player_name = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0):lower();
local first = player_name:byte(1) - 97 + zone.offset;
local second = player_name:byte(2) - 97 + zone.offset;
local third = player_name:byte(3) - 97 + zone.offset;
local sum = first + second + third + zone.offset

print(chat.header("strange"):append(chat.message("Password: %02d%02d%02d%02d"):fmt(first, second, third, sum)));
print(chat.header("strange"):append(chat.message("Chip: %s (%s)"):fmt(zone.chip, zone.element)));