--global to enable other mods/packs to utilize the api
minigamer = {}
minigamer.games = {}
minigamer.instances = {}

-- local games_file = minetest.get_worldpath() .. "/minigamer/games.list"
local games_dir = minetest.get_worldpath() .. "/minigamer/games"

dofile(minetest.get_modpath("minigamer").."/settings.lua")
dofile(minetest.get_modpath("minigamer").."/commands.lua")

-- http://lua-users.org/wiki/FileInputOutput
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function loadgames()
    minigamer.games = {}
    -- true:directories; false:files; nil:both
    local dir_list = minetest.get_dir_list(games_dir, true)
    for k,path in pairs(dir_list) do
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
        local dir_list = minetest.get_dir_list(games_dir.."/instances/"..k, false)
        for path in pairs(dir_list) do
            for i=1,minigamer.max_instance_count do
                if string.sub(path,0,0) ~= "." then
                    minetest.log("action", "[minigamer] loading minigame "..line.."...")
                end
            end
        end
    end
end

loadinstances()

minetest.register_craftitem("minigamer:rulebook", {
    description = "Minigamer Rulebook",
    inventory_image = "minigamer_tool_rulebook.png",
	stack_max = 1,
	liquids_pointable = true,
    on_use = function(itemstack, user, pointed_thing)
        local username = user:get_player_name()
        if pointed_thing.type == "object" then
            minetest.chat_send_player(username, "Manipulated Object")
			-- return user:get_wielded_item()
			return
        elseif pointed_thing.type == "node" then
            local this_node = minetest.get_node(pointed_thing.under)
            -- local this_node = minetest.get_node(node_pos)
            local node_pos = pointed_thing.under
            minetest.chat_send_player(username, "Manipulated Node at "..minetest.pos_to_string(node_pos))
            local nodename = this_node.name
			return
        else
            minetest.chat_send_player(username, "Manipulated "..pointed_thing.type)
			return
        end
    end,
})

-- TODO: unload player from minigame if logs out of minetest:
-- minetest.register_on_leaveplayer(func(ObjectRef, timed_out))
-- TODO: unload player from minigame if somehow not unloaded upon logging into server:
-- minetest.register_on_joinplayer(func(ObjectRef))
-- TODO: check cheats??
-- minetest.register_on_cheat(func(ObjectRef, cheat))
-- `cheat`: `{type=<cheat_type>}`, where `<cheat_type>` is one of: moved_too_fast, interacted_too_far, interacted_while_dead, finished_unknown_dig, dug_unbreakable, dug_too_fast

