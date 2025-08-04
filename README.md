# luaexec

This ashita addon is designed to run one-off lua scripts.

## Usage
Place or create your and edit your scripts inside of `<ashita_root>\addons\luaexec\scripts` and interact with them using the following commands:
* `/luaexec list`: Lists all available lua scripts in your scripts folder.
* `/luaexec (exec|e) <script> args...`: Executes the given script with the given arguments.

## Scripts
Note that inside of scripts:
* Any script arguments are exposed to the script through the global `args` table.
* The global function `get_script_dir()` can be used to get the directory path of the script.
* `ashita.events.register()` and `ashita.events.unregister()` are not available and will throw an error.
