local chat = require("chat");

local count = 0;

print(chat.header("trustcheck"):append(chat.message("Acquired Trusts:")));

for i = 896, 1019 do
    local spell = AshitaCore:GetResourceManager():GetSpellById(i);

    if (spell and spell.Name[3] ~= "") then
        if (AshitaCore:GetMemoryManager():GetPlayer():HasSpell(i)) then
            AshitaCore:GetChatManager():AddChatMessage(1, true, chat.success(spell.Name[3] .. ": true"));

            if (not spell.Name[3]:contains("(UC)") and not spell.Name[3]:any("Cornelia", "Matsui-P")) then
                count = count + 1;
            end
        else
            AshitaCore:GetChatManager():AddChatMessage(1, true, chat.error(spell.Name[3] .. ": false"));
        end
    end
end

print(chat.message("Trusts acquired: %s/109"):fmt(count));