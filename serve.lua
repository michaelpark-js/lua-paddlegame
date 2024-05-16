
local paddle = require("paddle")
local testicle = require("ball")
local score = require("score")
local startFont = love.graphics.newFont("Jaro.ttf", 36)
local mainFont = love.graphics.newFont("Jaro.ttf", 18)
local serve = {}

function serve:load()
end

function serve:update(dt)
    paddle:Move(dt)
    testicle:Serve()
    score.enabled = false
end


function serve:draw()
    paddle:Render()
    testicle:Render()
    score:Render()
    serve:DisplayInstructions()

end

function serve:exit()
    love.graphics.clear(0, 0, 0, 255)

end


function serve:DisplayInstructions()
    love.graphics.setFont(mainFont)
    love.graphics.printf("Press S to SHOOT\nA and D to MOVE", 0, WINDOW_HEIGHT/3 + 72, WINDOW_WIDTH, 'center')
end


return serve