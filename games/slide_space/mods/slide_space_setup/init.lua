
minetest.register_on_joinplayer(function(player, last_login)

    player:set_pos(vector.new(0,0,0))
    player:set_physics_override({gravity = 0})
    player:hud_set_flags({hotbar = false, healthbar=false, crosshair=false, wielditem=false, breathbar=false})        
    player:set_sky({
        -- base_color = "#000000",
        type = "skybox",
        textures = {"Up.jpg", "Down.jpg", "Front.jpg", "Back.jpg", "Right.jpg", "Left.jpg"},
        clouds = false,
        
    })
    player:set_properties({
        textures={"blank.png"},
        physical = false,
    })
    player:set_sun({
        visible = false,
        sunrise_visible = false,
    })
    player:set_moon({
        visible = false,
    })
    player:set_eye_offset(vector.new(0,-16,0), vector.new(0,-15,0))
    p_meta = player:get_meta()
    local checkpoint = p_meta:get_int("checkpoint")
    local unlocked = p_meta:get_int("unlocked")
    if not checkpoint then
        p_meta:set_int("checkpoint",1)
    end
    if not unlocked then
        p_meta:set_int("unlocked",1)
    end
    minetest.after(.5,function(p_name)
        local player = minetest.get_player_by_name(p_name)
        if not player then return end

        
        local staticdata = {
            _p_name = player:get_player_name()
        }
        obj = minetest.add_entity(vector.new(0,0,0),"slide_space_slider:p_att",minetest.write_json(staticdata))
        player:set_attach(obj)

        
    end,player:get_player_name())
    minetest.sound_play({name = "ScatterNoise1",gain=.15,pitch=1},{
        to_player = player:get_player_name(),
        gain = 1.0,  -- default
        loop = true,
    }, false)

    minetest.after(20, function(p_name)
        minetest.sound_play({name = "DeepSpace",gain=.45,pitch=1},{
            to_player = player:get_player_name(),
            gain = 1.0,  -- default
            loop = true,
        }, false)
    end,player:get_player_name())
end)

minetest.register_on_mods_loaded(function()
    for name,def in pairs(minetest.registered_nodes) do
        minetest.override_item(name, {            
            pointable = false,
        })
    end
end)