
local ctx = GS.new()
function ctx:enter(dt)
    GS.push(core.states.loading)
    love.mouse.setGrabbed(true)
end

function get_nil()
    return "nil" 

end
function ctx:update(dt)
    for k,v in core.system.orderedPairs(game.system_categories.update) do
        v.update(dt)
    end
end
function ctx:draw()
    love.graphics.push()
  love.graphics.translate(-game.systems.scroll.x, -game.systems.scroll.y)
 
      for k,v in core.system.orderedPairs(game.system_categories.draw) do
        v.draw()
    end
    love.graphics.pop()


end

function ctx:leave()
    love.mouse.setGrabbed(false)
    print('leaving')
end
return ctx
