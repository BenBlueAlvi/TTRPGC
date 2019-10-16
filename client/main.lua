push = require 'push'
Class = require 'class'
json = require 'json'

require 'Geo'
require 'client'
require 'Chat'
require 'StateMachine'
require 'Button'
require 'TextBox'
require 'DropdownBox'
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







gFonts = {
	['small'] = love.graphics.newFont("font.ttf", 8),
	['medium'] = love.graphics.newFont("font.ttf", 16),
	['large'] = love.graphics.newFont("font.ttf", 32)
}

gColors = {
	['black'] = {0,0,0},
	['white'] = {255,255,255},
	['red'] = {255,0,0},
	['green'] = {0,255,0},
	['blue'] = {100,100,255},
	
}

gStateMachine = StateMachine({
	['play'] =  PlayState(),
	['menu'] =  MenuState(),
	['levelCreation'] =  LevelCreationState(),
	['systemCreation'] =  SystemCreationState()

})

highCase = {
	["1"] = '!',
	["2"] = '@',
	["3"] = '#',
	["4"] = '$',
	["5"] = '%',
	["6"] = '^',
	["7"] = '&',
	["8"] = '*',
	["9"] = '(',
	["0"] = ')',
	["`"] = '~',
	["-"] = '_',
	["="] = '+',
	["["] = '{',
	["]"] = '}',
	["\\"] = '|',
	[";"] = ':',
	["'"] = '"',
	[","] = '<',
	["."] = '>',
	["/"] = '?',
	["q"] = 'Q',
	["w"] = 'W',
	["e"] = 'E',
	["r"] = 'R',
	["t"] = 'T',
	["y"] = 'Y',
	["u"] = 'U',
	["i"] = 'I',
	["o"] = 'O',
	["p"] = 'P',
	["a"] = 'A',
	["s"] = 'S',
	["d"] = 'D',
	["f"] = 'F',
	["g"] = 'G',
	["h"] = 'H',
	["j"] = 'J',
	["k"] = 'K',
	["l"] = 'L',
	["z"] = 'Z',
	["x"] = 'X',
	["c"] = 'C',
	["v"] = 'V',
	["b"] = 'B',
	["n"] = 'N',
	["m"] = 'M',
}

function love.mouse.getAbsPos()
	mx, my = love.mouse.getPosition()
	mx = mx/3
	my = my/3
	
	return mx, my

end

mscrollx = 0
mscrolly = 0
mvelx = 0
mvely = 0
function love.wheelmoved(x, y)
	mvelx = mvelx + x * 20
    mvely = mvely + y * 20
end

function scrollUpdate(dt)
	mscrollx = mscrollx + mvelx * dt
    mscrolly = mscrolly + mvely * dt
 
    -- Gradually reduce the velocity to create smooth scrolling effect.
    mvelx = mvelx - mvelx * math.min( dt * 10, 1 )
    mvely = mvely - mvely * math.min( dt * 10, 1 )
end

function love.load()
	love.keyboard.keysPressed = {}
	love.window.setTitle("TTRPGC")
	math.randomseed(os.time())
	
	mvelx = 0
	mvely = 0
	
	--set up rendering and scaling filter
	love.graphics.setDefaultFilter("nearest", "nearest")
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

	
	
	
	
	
	
	
	gStateMachine:change('menu')
	
	
	
	

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
	scrollUpdate(dt)
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
	love.graphics.setFont(gFonts.small)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, VIRTUAL_HEIGHT - 18)
end




