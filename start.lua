
WINDOW_HEIGHT = 800
WINDOW_WIDTH = 480

local paddle = require("paddle")
local testicle = require("ball")
local score = require("score")
local bricks = require("bricks")

local startFont = love.graphics.newFont("Jaro.ttf", 36)
local mainFont = love.graphics.newFont("Jaro.ttf", 18)


local start = {}

function start:load()

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        vsync = false,
    })

    --Reset Paddle Position
    paddle:Reset()
    --Reset ball position
    testicle:Reset()
    --Reset Score
    score:Reset()
    --Reset Bricks
    bricks:Reset()
end


function start:update(dt)
    paddle:Move(dt)
    testicle:Move()
    score.enabled = false
end

function start.draw()
    paddle:Render()
    testicle:Render()
    start:DisplayTitle()
end


function start:exit()
    love.graphics.clear(0, 0, 0, 255)
    
end



function start:DisplayTitle()
        love.graphics.setFont(startFont)
        love.graphics.printf("PADDLE GAME", 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, 'center')
        love.graphics.setFont(mainFont)
        love.graphics.printf("Press SPACE to PLAY", 0, WINDOW_HEIGHT/3 + 72, WINDOW_WIDTH, 'center')
end

return start