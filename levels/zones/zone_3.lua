require 'entities.aim_enemy'
local entities = {}
entities[1] = {get_aim_enemy, 100, 100}
entities[2] = {get_aim_enemy, 200, 100}
return {entities = entities, zone_condition = {MOVEMENT, 3000}, unloaded = true}