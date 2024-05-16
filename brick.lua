local brick = {}

    brick.width = 40
    brick.height = 20
    brick.row = 6
    brick.column = 12 --windowWidth is 480. brickWidth is 40...

    brick.ssheet = love.graphics.newImage('Sprites/bricks.png')
    brick.sswidth = 256
    brick.ssheight = 96
    brick.quadWidth = 32
    brick.quadHeight = 16
    brick.quad = love.graphics.newQuad(112, 32, bricks.quadWidth, bricks.quadHeight, bricks.sswidth, bricks.ssheight)


    brick.grid = {}

    function brick:InitializeGrid()

        self.grid = {}
        for row = 1, brick.row do 
            for col = 1, brick.column do

                local x = (row - 1) * self.width
                local y = (col - 1) * self.height
                
                --           table,      what to insert(the bricks position itself)
                table.insert(self.grid, {x = x, y = y})

            end
        end
    end


    function brick:Render(x, y)
        for _, brickData in ipairs(brick.grid) do
            local scaleX = self.width / self.quadWidth
            local scaleY = self.height / self.quadHeight
            love.graphics.draw(self.ssheet, self.quad, x, y, 0, scaleX, scaleY, 0, 0)      
        end
    end

return brick