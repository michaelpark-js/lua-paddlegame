--main.lua

--Note, best practice is apparently to always use local variables if possible.
WINDOW_HEIGHT = 800
WINDOW_WIDTH = 480


local gameState = require("gameState")
local start = require("start")
local serve = require("serve")
local play = require("play")

function love.load()
    gameState.switch(start)

end

function love.keypressed(key)

    if key == 'escape' then
         love.event.quit()
    end
    if key == 'return' then
        gameState.switch(start)
    end
    

    if gameState.curState == start then
        if key == 'space' then
            gameState.switch(serve)
        end
    end

    if gameState.curState == serve then
        if key == 's' then
            gameState.switch(play)
        end
    end
end




function love.update(dt)

    gameState.update(dt)

end




function love.draw()
    gameState.draw()

end


