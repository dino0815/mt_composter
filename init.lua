local path = minetest.get_modpath("composter")
	
minetest.register_craft({
	output = "composter:barrel_empty",
	recipe = {
		{"group:wood", "",           "group:wood"},
		{"group:wood", "",           "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
-- ]]

minetest.register_node("composter:barrel_empty", {
	description = "a empty barrel",
	drawtype = "nodebox",
    tiles = {  "default_wood.png" },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3750, -0.4375, -0.4375,  0.3750,  0.5000, -0.3125}, --Wände N
			{-0.4375, -0.4375, -0.3750, -0.3125,  0.5000,  0.3750}, --Wände O
			{ 0.3750, -0.4375,  0.4375, -0.3750,  0.5000,  0.3125}, --Wände S
			{ 0.4375, -0.4375,  0.3750,  0.3125,  0.5000, -0.3750}, --Wände W
			{-0.3750, -0.5000, -0.3750,  0.3750, -0.3750,  0.3750}, --Boden
		},
	},

	selection_box = {
		type = "fixed",
		fixed = {
--			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- ganze Block
			{-0.3750, -0.4375, -0.4375,  0.3750,  0.5000, -0.3125}, --Wände N
			{-0.4375, -0.4375, -0.3750, -0.3125,  0.5000,  0.3750}, --Wände O
			{ 0.3750, -0.4375,  0.4375, -0.3750,  0.5000,  0.3125}, --Wände S
			{ 0.4375, -0.4375,  0.3750,  0.3125,  0.5000, -0.3750}, --Wände W
			{-0.3750, -0.5000, -0.3750,  0.3750,  0.5000,  0.3750}, --Boden
		}
	},
	
	groups = {choppy = 2, oddly_breakable_by_hand = 1},
	sounds = metal_sounds,

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        if clicker:is_player() then
	        local nodename = itemstack:get_name()
	        if nodename:match("leaves") then
                if not minetest.settings:get_bool("creative_mode") then
                    itemstack:take_item()
                end

                minetest.chat_send_player(clicker:get_player_name(), "You fill the barrel!")
                minetest.swap_node(pos, { name = "composter:barrel_full" })
                local timer = minetest.get_node_timer(pos)
                timer:start(10.5) -- in seconds
            else
                minetest.chat_send_player(clicker:get_player_name(), "You need leaves!")
                return itemstack    
	        end
        end
    end,
})

minetest.register_node("composter:barrel_full", {
	description = "a full barrel",
	drawtype = "nodebox",
    tiles = {
          "bucket_full_top.png",    -- TOP
          "default_wood.png",  -- BOT
          "default_wood.png",  -- LEFT
          "default_wood.png",  -- RIGHT
          "default_wood.png",  -- FRONT
          "default_wood.png",  -- BACK
        },

	node_box = {
		type = "fixed",
		fixed = {
			{-0.3750, -0.4375, -0.4375,  0.3750,  0.5000, -0.3125}, --Wände N
			{-0.4375, -0.4375, -0.3750, -0.3125,  0.5000,  0.3750}, --Wände O
			{ 0.3750, -0.4375,  0.4375, -0.3750,  0.5000,  0.3125}, --Wände S
			{ 0.4375, -0.4375,  0.3750,  0.3125,  0.5000, -0.3750}, --Wände W
			{-0.3750, -0.5000, -0.3750,  0.3750,  0.3750,  0.3750}, --Boden
		},
	},

	selection_box = {
		type = "fixed",
		fixed = {
--			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- ganze Block
			{-0.3750, -0.4375, -0.4375,  0.3750,  0.5000, -0.3125}, --Wände N
			{-0.4375, -0.4375, -0.3750, -0.3125,  0.5000,  0.3750}, --Wände O
			{ 0.3750, -0.4375,  0.4375, -0.3750,  0.5000,  0.3125}, --Wände S
			{ 0.4375, -0.4375,  0.3750,  0.3125,  0.5000, -0.3750}, --Wände W
			{-0.3750, -0.5000, -0.3750,  0.3750,  0.5000,  0.3750}, --Boden
		}
	},

	groups = {choppy = 2, oddly_breakable_by_hand = 1},
	sounds = metal_sounds,

    on_construct = function(pos)
        minetest.chat_send_all("Create a full barrel!")
    end,
    
    on_timer = function(pos)
        minetest.set_node(pos, { name = "composter:barrel_ready" })
        minetest.chat_send_all("The barrel is ready now!")
        return false
    end

})

minetest.register_node("composter:barrel_ready", {
	description = "a full barrel",
	drawtype = "nodebox",
    tiles = {
          "bucket_ready_top.png", -- TOP
          "default_wood.png",  -- BOT
          "default_wood.png",  -- LEFT
          "default_wood.png",  -- RIGHT
          "default_wood.png",  -- FRONT
          "default_wood.png",  -- BACK
    },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3750, -0.4375, -0.4375,  0.3750,  0.5000, -0.3125}, --Wände N
			{-0.4375, -0.4375, -0.3750, -0.3125,  0.5000,  0.3750}, --Wände O
			{ 0.3750, -0.4375,  0.4375, -0.3750,  0.5000,  0.3125}, --Wände S
			{ 0.4375, -0.4375,  0.3750,  0.3125,  0.5000, -0.3750}, --Wände W
			{-0.3750, -0.5000, -0.3750,  0.3750,  0.3750,  0.3750}, --Boden
		},
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 1},
	sounds = metal_sounds,


	selection_box = {
		type = "fixed",
		fixed = {
--			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- ganze Block
			{-0.3750, -0.4375, -0.4375,  0.3750,  0.5000, -0.3125}, --Wände N
			{-0.4375, -0.4375, -0.3750, -0.3125,  0.5000,  0.3750}, --Wände O
			{ 0.3750, -0.4375,  0.4375, -0.3750,  0.5000,  0.3125}, --Wände S
			{ 0.4375, -0.4375,  0.3750,  0.3125,  0.5000, -0.3750}, --Wände W
			{-0.3750, -0.5000, -0.3750,  0.3750,  0.5000,  0.3750}, --Boden
		}
	},

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        if clicker:is_player() then
            minetest.chat_send_player(clicker:get_player_name(), "You fill the barrel!")
            minetest.swap_node(pos, { name = "composter:barrel_empty" })

            local inv = clicker:get_inventory()
                if not inv then
                    minetest.add_item(clicker:get_pos(), {name = "default:dirt"})
                    return
                end
                remaining = inv:add_item("main", {name = "default:dirt"})
                if remaining:is_empty() then
                    minetest.chat_send_player(clicker:get_player_name(), "Sie haben Post!")
                else
                    minetest.add_item(clicker:get_pos(), {name = "default:dirt"})
                end
				
        end
    end,
})

print("[MOD] composter loaded")

