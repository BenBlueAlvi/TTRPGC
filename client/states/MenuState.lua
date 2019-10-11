MenuState = Class{}


function MenuState:init()
	love.graphics.setDefaultFilter("nearest", "nearest")
	
	playButton = Button(VIRTUAL_WIDTH/4, 50 + 25, VIRTUAL_WIDTH/2, 18, "play", gFonts.medium, gColors.white, "line", gColors.white)
	playButton:setHoverState("fill", gColors.white, gColors.black)
	
	sysButton = Button(VIRTUAL_WIDTH/4, 75 + 25, VIRTUAL_WIDTH/2, 18, "system creator", gFonts.medium, gColors.white, "line", gColors.white)
	sysButton:setHoverState("fill", gColors.white, gColors.black)
	
	mapButton = Button(VIRTUAL_WIDTH/4, 100 + 25, VIRTUAL_WIDTH/2, 18, "map creator", gFonts.medium, gColors.white, "line", gColors.white)
	mapButton:setHoverState("fill", gColors.white, gColors.black)
end


function MenuState:enter()

end

function MenuState:exitt()

end

function MenuState:update(dt)
	mx, my = love.mouse.getPosition()
	mx = mx/3
	my = my/3
	playButton:update(mx, my)
	sysButton:update(mx, my)
	mapButton:update(mx, my)
	
	
	if playButton.pressed then
		gStateMachine:change('play')
	
	elseif sysButton.pressed then
		gStateMachine:change('systemCreation')
	elseif mapButton.pressed then
		gStateMachine:change('levelCreation')
	end
	
end

function MenuState:draw()
	
	playButton:draw()
	sysButton:draw()
	mapButton:draw()
	
end