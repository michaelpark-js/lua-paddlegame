local paddle = require("paddle")
local ball = require("ball")
local score = require("score")
local brick = require("brick")
local startFont = love.graphics.newFont("Jaro.ttf", 36)
local mainFont = love.graphics.newFont("Jaro.ttf", 18)


local play = {}

function play:load()

    brick:InitializeGrid()

end

function play:update(dt)
    ball:Move()
    paddle:Move(dt)
    score.enabled = true
end

function play:draw()
    ball:Render()
    paddle:Render()
    score:Render()
    
    love.graphics.printf("Play", 0, WINDOW_HEIGHT/3 + 72, WINDOW_WIDTH, 'center')

    brick:Render()
end

return play