
sss = {}

sss.checkpoints = {
    vector.new(0,0,0),
    vector.new(11,9,16),
    vector.new(32,22,33),
    vector.new(58,33,50),
    vector.new(97,55,74),
    vector.new(128,77,101),
    vector.new(150,112,144),
    vector.new(203,130,175),
}


function sss.get_look_dir(player)

    local yaw = player:get_look_horizontal()
    local vert = player:get_look_vertical()
    local look_dir
    if yaw < (3.14*.25) or yaw > (3.14 *(7/4)) then -- if we are looking in the +z direction, 
        look_dir = 'pz'
    elseif yaw > (3.14*(1/4)) and yaw < (3.14 *(3/4)) then -- if we are looking in the -x direction
        look_dir = 'nx'
    elseif yaw > (3.14*(3/4)) and yaw < (3.14 *(5/4)) then -- if we are looking in the -z direction
        look_dir = 'nz'
    elseif yaw > (3.14*(5/4)) and yaw < (3.14 *(7/4)) then -- if we are looking in the +x direction
        look_dir = 'px'
    end
    yaw_dir = look_dir
    if vert < (-3.14*(1/4)) then 
        look_dir = "up"
    end
    if vert > (3.14*(1/4)) then
        look_dir = "dn"
    end
    return look_dir, yaw_dir

end



minetest.register_entity("slide_space_slider:p_att",{
    initial_properties = {
        visual = "sprite",
        physical = true,
        collide_with_objects = false,
        hp_max = 32,
        textures = {"blank.png"},
        collisionbox = {-.49,-.49,-.49,.49,.49,.49},
        static_save = false,
        pointable = false,
    },
    _p_name = "",
    _timeout = 0,
    _timer = 0,
    _move_timer = 0,
    on_activate = function(self, staticdata)
        if self._p_name ~= "" then
            self.object:remove()
        end
        if staticdata ~= "" and staticdata ~= nil then
            local data = minetest.parse_json(staticdata) or {}
            self._p_name = data._p_name or ""
        end
    end,
    on_step = function(self,dtime,moveresult)

        local player = minetest.get_player_by_name(self._p_name)
        self._timer = self._timer + dtime
        if self._timer > 1 then
            self._timer = 0
        end

        if vector.length(self.object:get_velocity()) > .01 then 
            self._move_timer = self._move_timer + dtime
        end
        if vector.length(self.object:get_velocity()) <= .01 then
            self._move_timer = 0
        end

        if not player then 
            if self._timeout < 10 then
                self._timeout = self._timeout + dtime
                return
            else
                self.object:remove()
                minetest.chat_send_all("removing")
                return
            end
        end

        local control = player:get_player_control()

        local o_pos = self.object:get_pos()

        
        local node = minetest.get_node(o_pos).name
        if node == "slide_space_nodes:goo" and self._move_timer > .75 then
            self.object:set_acceleration(vector.zero())
            self.object:set_velocity(vector.zero())
            self.object:move_to(vector.round(self.object:get_pos()), true)
        end
        if moveresult.collisions[1] then
            self.object:set_acceleration(vector.zero())
            self.object:set_velocity(vector.zero())
            self.object:set_pos(vector.round(self.object:get_pos()))
        end
        if control.aux1 or vector.length(self.object:get_velocity()) > 30 then
            self.object:set_acceleration(vector.zero())
            self.object:set_velocity(vector.zero())
            p_meta = player:get_meta()
            local checkpoint = p_meta:get_int("checkpoint")
            self.object:set_pos(sss.checkpoints[checkpoint])
        end

        for i,checkpoint in ipairs(sss.checkpoints) do
            if vector.equals(vector.round(self.object:get_pos()),checkpoint) then
                p_meta = player:get_meta()
                local max_unlock = p_meta:get_int("unlocked")
                p_meta:set_int("checkpoint",i)
                if i> max_unlock then
                    p_meta:set_int("unlocked",i)
                end
            end
        end

        if vector.equals(self.object:get_velocity(),vector.zero()) then 


            local look_dir, yaw_dir = sss.get_look_dir(player) 
            local direction = nil
            local yaw_direction
            if look_dir == 'up' then --if we are going up
                direction = vector.new(0,1,0)
            elseif look_dir == 'dn' then --if we are going down
                direction = vector.new(0,-1,0)
            elseif look_dir == 'pz' then -- if we are looking in the +z direction, 
                direction = vector.new(0,0,1)
            elseif look_dir == 'nx' then -- if we are looking in the -x direction
                direction = vector.new(-1,0,0)
            elseif look_dir == 'nz' then -- if we are looking in the -z direction
                direction = vector.new(0,0,-1)
            elseif look_dir == 'px' then -- if we are looking in the +x direction
                direction = vector.new(1,0,0)
            end

            if yaw_dir == 'pz' then -- if we are looking in the +z direction, 
                yaw_direction = vector.new(0,0,1)
            elseif yaw_dir == 'nx' then -- if we are looking in the -x direction
                yaw_direction = vector.new(-1,0,0)
            elseif yaw_dir == 'nz' then -- if we are looking in the -z direction
                yaw_direction = vector.new(0,0,-1)
            elseif yaw_dir == 'px' then -- if we are looking in the +x direction
                yaw_direction = vector.new(1,0,0)
            end

            if self._timer == 0 and direction and yaw_direction then
                -- spawn the arrow particle
                local pos = self.object:get_pos()
                pos = vector.add(pos,vector.multiply(direction,1))
                pos_m_x = 
                
                minetest.add_particlespawner({                  
                    amount = 20,                
                    time = 1,  
                    size = .1,                 
                    collisiondetection = false,
                    object_collision = false,
                    vertical = false,
                    expirationtime = 5,
                    texture = "white.png",
                    playername = player:get_player_name(),
                    glow = 10,
                    pos = {
                        min = vector.add(pos,vector.new(-.5,-.5,-.5)),
                        max = vector.add(pos,vector.new(.5,.5,.5)),
                        pos_tween = {
                            style = "fwd",
                            reps = 1,                 
                            start = 0.0,
                            0, 1,
                        },
                    },
                    minacc = vector.multiply(direction,5),
                    maxacc = vector.multiply(direction,10),
                
                })
            end

            if control.jump and direction then
                self.object:set_acceleration(vector.multiply(direction,3.2))
            end
        end
        

    end,
})


minetest.register_chatcommand("go",{
    description = "go to unlocked level: /go 1 goes to the first level",
    func = function(name, param)
        if param then
            param = tonumber(param)
        end
        if type(param) ~= "number" then
            return false, "[!] Please pass a number."
        end
        local player = minetest.get_player_by_name(name)
        if not player then return end
        p_meta = player:get_meta()
        local max_unlock = p_meta:get_int("unlocked")
        if sss.checkpoints[param] == nil then
            return false, "[!] Please enter a valid level number."
        end
        if param <= max_unlock then
            local obj = player:get_attach()
            if obj then
                obj:set_pos(sss.checkpoints[param])
                return true, "[!] Going to level "..param
            end
        else
            return false, "[!] You have not unlocked that level yet!"
        end

    end,
})