
local score = {}
score.val = 0
score.enabled = false


function score:Render()
    love.graphics.printf(self.val, -20, WINDOW_HEIGHT - 30, WINDOW_WIDTH, 'right')
end
    --text x y limit align)

function score:Reset()
    self.val = 0
end

function score:IncScore()
    if self.enabled == true then
        self.val = self.val + 1
        return self.val
    end
end


return score