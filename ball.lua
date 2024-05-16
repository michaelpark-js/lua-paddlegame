
local ball= {}
ball.rad = 5
ball.x = WINDOW_WIDTH / 2 - ball.rad
ball.y = WINDOW_HEIGHT - ball.rad - 100
ball.dx = 0 --x coordinate direction
ball.dy = 0 --y coord direction (x + dx, y + dy)
local chance = 0.5

ball.spritesheet = love.graphics.newImage('Sprites/paddles_and_balls.png')
ball.spritesheetWidth = 192
ball.spritesheetHeight = 96

ball.quadHeight = 5
ball.quadWidth = 5
ball.quad = love.graphics.newQuad(112, 43, ball.quadWidth, ball.quadHeight, ball.spritesheetWidth, ball.spritesheetHeight)

local paddle = require("paddle")
local score = require("score")
local sounds = require("sounds")
local bricks = require("bricks")


function ball:Render()
    --love.graphics.circle('fill', self.x, self.y, self.rad)
    local scaleX = (self.rad*2) / self.quadWidth
    local scaleY = (self.rad*2) / self.quadHeight
    love.graphics.draw(self.spritesheet, self.quad, self.x, self.y, 0, scaleX, scaleY, 0, 0)



end

function ball:Reset()
    self.rad = ball.rad
    self.x = WINDOW_WIDTH / 2 - self.rad
    self.y = WINDOW_HEIGHT - self.rad - 100
    self.dx = 0
    self.dy = -1

end

function ball:RandomDirection()
    self.dx = love.math.random(-1, 1)
    self.dy = love.math.random(-1, 1)
    return self.dx, self.dy
end

function ball:Serve()
    --Follow paddle
    self.x = paddle.x + paddle.width/2 - self.rad
    self.y = WINDOW_HEIGHT - ball.rad - 50
    if love.keyboard.isDown('space') then
        self.dy = -1 -- Move upwards (adjust the speed as needed)
        self.dx = 0 -- Set a random horizontal movement. Skill means you're allowed to aim?
    end
end





function ball:Move()
    local nextX = self.x + self.dx
    local nextY = self.y + self.dy

    --Check if the next position hits the left or right wall
    if nextX < 0 or nextX > WINDOW_WIDTH - self.rad * 2 then
        self.dx = -self.dx --Reverse the x direction
        sounds['wall_hit']:play()
    end
    --Check if the next position hits the top or bottom wall
    if nextY < 0 or nextY > WINDOW_HEIGHT - self.rad * 2 then
        self.dy = -self.dy --Reverse the y direction
        sounds['wall_hit']:play()
        nextY = 0
    end

    -- Check for collision with the paddle
    if nextX + self.rad * 2 > paddle.x and nextX < paddle.x + paddle.width and
     nextY + self.rad * 2 > paddle.y and nextY < paddle.y + paddle.height then

        sounds['paddle_hit']:play()
        
        -- Calculate collision angle
        local paddleCenterX = paddle.x + paddle.width / 2
        local relativeIntersectX = (self.x + self.rad) - paddleCenterX
        local normalizedIntersectX = relativeIntersectX / (paddle.width / 2)
        local collisionAngle = normalizedIntersectX * math.rad(45)  -- 45 degrees

        -- Change ball direction based on collision angle
        local speed = math.sqrt(self.dx * self.dx + self.dy * self.dy)
        self.dx = speed * math.sin(collisionAngle)
        self.dy = -speed * math.cos(collisionAngle)

        --Increment score
        score:IncScore()
    end

    -- Check for collision with a brick
    for row = 1, bricks.row do
    for col = 1, bricks.column do
        local brickX = (col - 1) * bricks.width
        local brickY = (row - 1) * bricks.height
        
        --      Ball Right  > Brick Left  and  Ball Left < Brick Right
        if nextX + self.rad * 2 > brickX and nextX < brickX + bricks.width and
        -- and Ball Bottom  > Brick Top and Ball Top < Brick Bottom
        nextY + self.rad * 2 > brickY and nextY < brickY + bricks.height then
            
            bricks:HitBrick(row, col)
          -- Bounce off the brick

            --If moving right and not brick 
                if self.dx > 0 and nextX <= brickX then
                    self.dx = -self.dx
                elseif self.dx < 0 and nextX >= brickX + bricks.width then
                    self.dx = -self.dx
                end

                if self.dy > 0 and nextY <= brickY then
                    self.dy = -self.dy
                elseif self.dy < 0 and nextY >= brickY + bricks.height then
                    self.dy = -self.dy
                end
        end
    end
end
    --Update the position
    self.x = self.x + self.dx
    self.y = self.y + self.dy


end


return ball