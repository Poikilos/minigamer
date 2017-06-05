--global to enable other mods/packs to utilize the api
minigamer = {}
minigamer.games = {}
minigamer.instances = {}

-- local games_file = minetest.get_worldpath() .. "/minigamer/games.list"
local games_dir = minetest.get_worldpath() .. "/minigamer/games"

dofile(minetest.get_modpath("minigamer").."/settings.lua")
dofile(minetest.get_modpath("minigamer").."/commands.lua")

local function loadgames()
    minigamer.games = {}
    -- true:directories; false:files; nil:both
    for path in minetest.get_dir_list(games_dir, true)
        if string.len(path) > 0 then
            minetest.log("action", "[minigamer] loading minigame "..line.."...")
            minigamer.games[path] = {}
        end
    end
end

loadgames()

local function loadinstances()
    for k, v in pairs(minigamer.games) do
        -- true:directories; false:files; nil:both
        for path in minetest.get_dir_list(games_dir.."/instances/"..k, false)
            for i=1,minigamer.max_instance_count do
                if string.sub(path,0,0) ~= "." then
                    minetest.log("action", "[minigamer] loading minigame "..line.."...")
                end
            end
        end
    end
end

loadinstances()

minetest.register_tool("minigamer:rulebook", {
    description = "Minigamer Rulebook",
    inventory_image = "minigamer_tool_rulebook.png",
    tool_capabilities = {
        max_drop_level=0,
        groupcaps={
            cracky={times={[1]=1.0, [2]=1.0, [3]=1.0}, uses=999, maxlevel=4}
        }
    },
})

-- TODO: unload player from minigame if logs out of minetest:
-- minetest.register_on_leaveplayer(func(ObjectRef, timed_out))
-- TODO: unload player from minigame if somehow not unloaded upon logging into server:
-- minetest.register_on_joinplayer(func(ObjectRef))
-- TODO: check cheats??
-- minetest.register_on_cheat(func(ObjectRef, cheat))
-- `cheat`: `{type=<cheat_type>}`, where `<cheat_type>` is one of: moved_too_fast, interacted_too_far, interacted_while_dead, finished_unknown_dig, dug_unbreakable, dug_too_fast

