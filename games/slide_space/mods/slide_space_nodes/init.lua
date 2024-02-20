minetest.register_node("slide_space_nodes:white",{
    description = "White",
    tiles = {"white.png"},
    is_ground_content = true,
    sunlight_propagates = true,
    groups = {cracky=3}
})

minetest.register_node("slide_space_nodes:goo",{
    description = "Goo",
    tiles = {"white.png"},
    drawtype = "mesh",
    mesh = "cube.obj",
    is_ground_content = true,
    selection_box = {
        type = "fixed",
        fixed = {-.5,-.5,-.5,.5,.5,.5},
    },
    selection_box = {
        type = "fixed",
        fixed = {-.5,-.5,-.5,.5,.5,.5},
    },
    collision_box = {
        type = "fixed",
        fixed = {-.5,-.5,-.5,-.5,-.5,-.5},
    },
    use_texture_alpha = "blend",
    paramtype = "light",
    is_ground_content = false,
    sunlight_propagates = true,
    groups = {cracky=3}
})


minetest.register_node("slide_space_nodes:end",{
    description = "Sign End",
    tiles = {"signend.png"},
    is_ground_content = true,
    groups = {cracky=3}
})


minetest.register_node("slide_space_nodes:ss",{
    description = "Sign Start",
    tiles = {"signstart.png"},
    is_ground_content = true,
    groups = {cracky=3}
})


minetest.register_node("slide_space_nodes:s1",{
    description = "Sign 1",
    tiles = {"sign1.png"},
    is_ground_content = true,
    groups = {cracky=3}
})

minetest.register_node("slide_space_nodes:s2",{
    description = "Sign 2",
    tiles = {"sign2.png"},
    is_ground_content = true,
    groups = {cracky=3}
})

minetest.register_node("slide_space_nodes:s3",{
    description = "Sign 3",
    tiles = {"sign3.png"},
    is_ground_content = true,
    groups = {cracky=3}
})

minetest.register_node("slide_space_nodes:s4",{
    description = "Sign 4",
    tiles = {"sign4.png"},
    is_ground_content = true,
    groups = {cracky=3}
})

minetest.register_node("slide_space_nodes:s5",{
    description = "Sign 5",
    tiles = {"sign5.png"},
    is_ground_content = true,
    groups = {cracky=3}
})

minetest.register_node("slide_space_nodes:s6",{
    description = "Sign 6",
    tiles = {"sign6.png"},
    is_ground_content = true,
    groups = {cracky=3}
})

minetest.register_node("slide_space_nodes:s7",{
    description = "Sign 7",
    tiles = {"sign7.png"},
    is_ground_content = true,
    groups = {cracky=3}
})

minetest.register_alias('mapgen_stone', 'air')
minetest.register_alias('mapgen_water_source', 'air')
minetest.register_alias('mapgen_river_water_source', 'air')
