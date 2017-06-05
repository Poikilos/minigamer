minetest.register_chatcommand("mini+p", {
	params = "<game> <player>",
	description = "Add a player to the minigame list for minigame named <game>.",
privs = {server = true},
}
)

minetest.register_chatcommand("minigamer", {
	params = "<mode>",
	description = "Change the mode of the Minigamer Rulebook to <mode>.",
privs = {server = true},
}
)
