local colors = {
    { mode = 1, text = "Menu > Font Colors > Chat > Immediate vicinity (\"Say\")" },
    { mode = 2, text = "Menu > Font Colors > Chat > Wide area (\"Shout\")" },
    { mode = 4, text = "Menu > Font Colors > Chat > Tell target only (\"Tell\")" },
    { mode = 5, text = "Menu > Font Colors > Chat > All party members (\"Party\")" },
    { mode = 6, text = "Menu > Font Colors > Chat > Linkshell group (\"Linkshell\")" },
    { mode = 7, text = "Menu > Font Colors > Chat > Emotes" },
    { mode = 17, text = "Menu > Font Colors > Chat > Messages (\"Message\")" },
    { mode = 142, text = "Menu > Font Colors > Chat > NPC Conversations" },
    { mode = 20, text = "Menu > Font Colors > For Others > HP/MP others loose" },
    { mode = 21, text = "Menu > Font Colors > For Others > Actions others evade" },
    { mode = 22, text = "Menu > Font Colors > For Others > HP/MP others recover" },
    { mode = 60, text = "Menu > Font Colors > For Others > Beneficial effects others are granted" },
    { mode = 61, text = "Menu > Font Colors > For Others > Detrimental effects others receive" },
    { mode = 63, text = "Menu > Font Colors > For Others > Effects others resist" },
    { mode = 28, text = "Menu > Font Colors > For Self > HP/MP you loose" },
    { mode = 29, text = "Menu > Font Colors > For Self > Actions you evade" },
    { mode = 30, text = "Menu > Font Colors > For Self > HP/MP you recover" },
    { mode = 56, text = "Menu > Font Colors > For Self > Beneficial effects you are granted" },
    { mode = 57, text = "Menu > Font Colors > For Self > Detrimental effects you receive" },
    { mode = 59, text = "Menu > Font Colors > For Self > Effects you resist" },
    { mode = 8, text = "Menu > Font Colors > System > Calls for help" },
    { mode = 50, text = "Menu > Font Colors > System > Standard battle messages" },
    { mode = 121, text = "Menu > Font Colors > System > Basic system messages" },
};

for _, v in ipairs(colors) do
    AshitaCore:GetChatManager():AddChatMessage(v.mode, false, v.text);
end
