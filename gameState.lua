-- gameState.lua

local gameState = {}

gameState.curState = nil --Initialize gameState. Current state is nil.

function gameState.switch(newState) --A function to switch between different game states. Takes in newState paramater, state to switch to.
    if gameState.curState and gameState.exit then --Check if there is a curState and if it has an exit function.
        gameState.curState:exit() --Do that exit function. Cleanup before new state.
    end

    gameState.curState = newState --Sets curState to newState. Actual state switching.

    if gameState.curState.load then --Checks if new state has load functions. Performs initialization operations.
        gameState.curState:load()  --Performs them.
    end
end

function gameState.update(dt) --Updating current game state.
    if gameState.curState and gameState.curState.update then --Check if current state has update function
        gameState.curState:update(dt)
    end
end

function gameState.draw()
    if gameState.curState and gameState.curState.draw then
        gameState.curState:draw()
    end
end



return gameState
