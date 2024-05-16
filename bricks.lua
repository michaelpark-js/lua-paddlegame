local bricks = {}

    bricks.width = 40
    bricks.height = 20
    bricks.row = 6
    bricks.column = 12 --windowWidth is 480. brickWidth is 40...

    bricks.ssheet = love.graphics.newImage('Sprites/bricks.png')
    bricks.sswidth = 256
    bricks.ssheight = 96
    bricks.quadWidth = 32
    bricks.quadHeight = 16
    bricks.quad = love.graphics.newQuad(112, 32, bricks.quadWidth, bricks.quadHeight, bricks.sswidth, bricks.ssheight)


        --x,y,width,height,sw,sh)

    bricks.grid = {}
    bricks.destroyed = false --grid of bricks






    function bricks:Render(x, y, index)
        if not self.destroyed[index] then
            local scaleX = self.width / self.quadWidth
            local scaleY = self.height / self.quadHeight
            love.graphics.draw(self.ssheet, self.quad, x, y, 0, scaleX, scaleY, 0, 0)      
        end
    end

    function bricks:Reset()
        for i = 1, #self.grid do
            bricks.destroyed[i] = false
        end
    end



-- Function to lay out bricks in table
function bricks:LayBricks()
    self.grid = {} --clear
    --Initialize grid
    for row = 1, bricks.row do
        for col = 1, bricks.column do
            local brickX = (col - 1) * self.width
            local brickY = (row - 1) * self.height

            table.insert(self.grid, {x = brickX, y = brickY})
            self.destroyed[(row - 1) * bricks.column + col] = false 
    
    
        end
    end
end

function bricks:HitBrick(row, col)
    local index = (row - 1) * bricks.column + col
    bricks.destroyed[index] = true
    table.remove(self.grid, index)  -- Remove the brick from the grid

    -- Update the indices of remaining bricks in the destroyed table
    for i = index, #self.grid - 1 do
        self.destroyed[i] = self.destroyed[i + 1]
    end
    self.destroyed[#self.grid + 1] = nil  -- Remove the last element
end


return bricks










