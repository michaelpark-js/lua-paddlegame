local sounds = {
    ['wall_hit'] = love.audio.newSource('wall_hit.wav', 'static'), -- static means wav file is held in memory when called
    ['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static')

}

return sounds