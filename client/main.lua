push = require 'push'
Class = require 'class'
json = require 'json'

require 'client'
require 'Chat'
require 'StateMachine'
require 'states/PlayState'
require 'states/MenuState'
require 'states/LevelCreationState'
require 'states/SystemCreationState'



WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--CLIENT = Client("192.168.0.12", 7777)


love.physics.setMeter(32)

connTimer = 1




gStateMachine = StateMachine({
	['play'] =  PlayState(),
	['menu'] =  MenuState(),
	['levelCreation'] =  LevelCreationState(),
	['systemCreation'] =  SystemCreationState()

})


function love.load()
	love.keyboard.keysPressed = {}
	love.window.setTitle("TTRPGC")
	math.randomseed(os.time())
	
	
	
	--set up rendering and scaling filter
	love.graphics.setDefaultFilter("nearest", "nearest")
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

	love.graphics.setFont(love.graphics.newFont("font.ttf", 8))
	
	
	
	
	
	chat = Chat()
	gStateMachine:change('play', 0)
	
	
	
	

end


function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	
	if key == 'lshift' or key == 'rshift' then
		love.keyboard.shiftDown = true
	end
	
end

function love.keyreleased(key)
	if key == 'lshift' or key == 'rshift' then
		love.keyboard.shiftDown = false
	end
	
	
end

--use for getting if key just pressed
function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end


--resize function, don't modify
function love.resize(w, h)
	push:resize(w, h)
end

function love.update(dt)
	
	gStateMachine:update(dt)
	
	
	
	--reset keysPressed table
	love.keyboard.keysPressed = {}
end

function love.draw()
	love.graphics.clear(0,0,0,1)
	push:apply('start')
	
	

	gStateMachine:draw()
	
	

	
	displayFPS()

	push:apply('end')
end

function displayFPS()
    -- simple FPS display across all states
   
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, VIRTUAL_HEIGHT - 18)
end


