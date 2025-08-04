addon.name = "luaexec";
addon.author = "Lumaro";
addon.version = "1.0";

require("common");
local chat = require("chat");

local luaexec = {
    dir_path = AshitaCore:GetInstallPath() .. "addons\\" .. addon.name .. "\\scripts\\",
    package_snapshot = { },
};

do
    for k in pairs(package.loaded) do
        luaexec.package_snapshot[k] = true;
    end
end

---@param original any
---@param copies? table
---@return any
local function deep_copy(original, copies)
    if (type(original) ~= "table") then
        return original;
    end

    copies = copies or { };

    if (copies[original]) then
        return copies[original];
    end

    local copy = { };
    copies[original] = copy;

    for k, v in next, original do
        copy[deep_copy(k, copies)] = deep_copy(v, copies);
    end

    setmetatable(copy, deep_copy(getmetatable(original), copies));
    return copy;
end

---@return boolean
local function create_scripts_dir()
    if (not ashita.fs.exists(luaexec.dir_path)) then
        print(chat.header(addon.name):append(chat.message("Scripts directory does not exist. Creating...")));

        if (ashita.fs.create_dir(luaexec.dir_path)) then
            print(chat.header(addon.name):append(chat.success("Created directory \"" .. luaexec.dir_path .. "\".")));
            return true;
        else
            print(chat.header(addon.name):append(chat.error("Unable to create directory \"" .. luaexec.dir_path .. "\".")));
            return false;
        end
    end

    return true;
end

ashita.events.register("load", "load_cb", create_scripts_dir);

ashita.events.register("command", "command_cb", function (e)
    local args = e.command:args();

    if (#args == 0 or args[1] ~= "/" .. addon.name) then
        return;
    end

    e.blocked = true;

    if (not create_scripts_dir()) then
        return;
    end

    if (#args == 2 and args[2] == "list") then
        local contents = ashita.fs.get_dir(luaexec.dir_path, ".+\\.lua");

        if (#contents == 0) then
            print(chat.header(addon.name):append(chat.error("No lua scripts found in \"" .. luaexec.dir_path .. "\".")));
            return;
        end

        print(chat.header(addon.name):append(chat.message("Available lua scripts:")));

        for _, v in ipairs(contents) do
            AshitaCore:GetChatManager():AddChatMessage(1, true, v);
        end

        return;
    end

    if (#args >= 3 and args[2]:any("exec", "e")) then
        if (not args[3]:endswith(".lua")) then
            args[3] = args[3] .. ".lua";
        end

        local chunk, err = loadfile(luaexec.dir_path .. args[3]);

        if (not chunk) then
            print(chat.header(addon.name):append(chat.error(err)));
            return;
        end

        local environment = deep_copy(_G);
        environment.args = { table.unpack(args, 4) };

        environment.ashita.events.register = function ()
            error("You should not register/unregister event callbacks inside a lua script", 2);
        end
        environment.ashita.events.unregister = environment.ashita.events.register;

        environment.get_script_dir = function ()
            return luaexec.dir_path;
        end

        setfenv(chunk, environment);
        local success, result = pcall(chunk);

        if (success) then
            print(chat.header(addon.name):append(chat.success("Successfully executed \"" .. args[3] .. "\".")));
        else
            print(chat.header(addon.name):append(chat.error(result)));
        end

        for k in pairs(package.loaded) do
            if (not luaexec.package_snapshot[k]) then
                package.loaded[k] = nil;
            end
        end

        return;
    end
end);