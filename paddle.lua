--paddle.lua


local paddle = {}
paddle.x = WINDOW_WIDTH - 30
paddle.y = WINDOW_HEIGHT - 40
paddle.width = 10*4
paddle.height = 10
paddle.speed = 300
paddle.sprite = love.graphics.newImage('Sprites/paddles_and_balls.png') --192 x 96 pixels
paddle.spriteWidth = 192
paddle.spriteHeight = 96
paddle.quadWidth = 4 * 8
paddle.quadHeight = 1 * 8

paddle.quad = love.graphics.newQuad(32, 40, paddle.quadWidth, paddle.quadHeight, paddle.spriteWidth, paddle.spriteHeight)


--love.graphics.newQuad(x,y,width,height,sw,sh)





function paddle:Move(dt)
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.x = math.max(self.x - 1 * dt * self.speed, 0) --Cannot be negative.
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.x = math.min(self.x + 1 * dt * self.speed, WINDOW_WIDTH - self.width) --Cannot exceed limit of screen.
    end
end

function paddle:Reset()
    self.x = (WINDOW_WIDTH / 2) - (self.width/2)
    self.y = WINDOW_HEIGHT - 40
    self.width = paddle.width
    self.height = paddle.height
    self.speed = paddle.speed
end


function paddle:Render()
    --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    local scaleX = self.width / self.quadWidth
    local scaleY = self.height / self.quadHeight

    love.graphics.draw(self.sprite, self.quad, self.x, self.y, 0, scaleX, scaleY, 0, 0)

end

function paddle:new(t)
    t = t or {}
    setmetatable (t, self)
    self.__index = self
    return t
end
return paddle --This tells lua to assign the paddle table to the variable in main.lua
                --Otherwise it'll assign true to that variable, which doesn't make sense.
--Needed for table to be correctly assigned to variable in main.


