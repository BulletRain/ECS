local loading = {}
loading.loaded = 1
-- Loading screen phases, split up loading code among these phases
loading.phases = {
    core.reset_game,
    function()
        

        -- add required systems
        core.system.add( require 'systems.basicphysics.velocity_from_acceleration', {"update"})
        core.system.add( require 'systems.basicphysics.position_from_velocity',  {"update"})
        core.system.add( require 'systems.basicphysics.acceleration_from_mass',  {"update"})
        core.system.add( require 'systems.basicphysics.draw_from_mass_and_position',  {"draw"})
        core.system.add( require 'systems.player_input.basic_move', {"update"})
        core.system.add( require 'systems.draw_functions.draw_square',  {"draw"})
        core.system.add( require 'systems.draw_functions.draw_image',  {"draw"})

        core.system.add( require 'systems.light_system'(),  {"update","draw"})
        core.system.add( require 'systems.scroll',  {"update"})
        
        core.system.add( require 'systems.zone_loading_system',  {"update"})
        core.system.add( require 'systems.zone_unloading_system',  {"update"})
        core.system.add( require 'systems.image_loader',  {"update"})

        --core.system.add( require 'systems.entity_remain_within_camera',  {"update"})
        core.system.add( require 'systems.draw_direction_debug',  {"draw"})
        core.system.add( require 'systems.aim_class',  {"update"})
        game.resources = {}
        -- require component types
    end, 
    function()
        require 'components.simple_image'
        -- require entity types
        require 'entities.agent'
        require 'entities.planet'
        require 'entities.player'
        require 'entities.aim_enemy'
        require 'entities.zone'

        entity = core.entity.add(get_new_player(300,300))
        

        require 'levels.level1'

end,
    function()
        if game.system_categories.load then
        for k,v in core.system.orderedPairs(game.system_categories.load) do
            v.load(dt)
        end
    end

    end
}

function loading:enter(from)
    print("STARTING LOADING")
end
-- Leave loading screen
function loading:leave(from)

       for k,v in pairs(game.systems) do
        print("Running system "..v.name)
    end
    print("FINISHED LOADING")
    to_load = false
end
function loading:update()
    if self.loaded <= #self.phases then
        self.phases[self.loaded]()
        self.loaded = self.loaded + 1
--        love.timer.sleep(0.01)

    else
        GS:pop()
    end

end
-- Draw loading screen
function loading:draw()
    
end
function loading:keypressed(key)

end
return loading


