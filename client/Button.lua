Button = Class{}

function Button:init(x, y, w, h, text, font, fColor, fill, color)
	self.rect = Rectangle(x, y, w, h)
	
	self.text = text
	self.font = font
	
	self.fill = fill
	self.color = color
	self.fColor = fColor
	
	self.hFill = fill
	self.hColor = color
	self.hfColor = color
	
	
	self.hover = false
	self.pressed = false
	
end

function Button:setHoverState(fill, color, fColor)
	self.hFill = fill
	self.hColor = color
	self.hfColor = fColor
end

function Button:update(mx, my)
	self.hover = false
	self.pressed = false

	if rectContains(self.rect, mx, my) then
	
		self.hover = true
		if love.mouse.isDown(1) then
			self.pressed = true
		end
	end
end

function Button:draw()
	
	if self.hover then
		--hover render
		love.graphics.setColor(self.hColor)
		love.graphics.rectangle(self.hFill, self.rect.x, self.rect.y, self.rect.w, self.rect.h)
		love.graphics.setColor(self.hfColor)
		love.graphics.printf(self.text, self.rect.x, self.rect.y + math.floor(self.rect.h/4), self.rect.w, 'center')
	else
		--non hover render
		love.graphics.setColor(self.color)
		love.graphics.rectangle(self.fill, self.rect.x, self.rect.y , self.rect.w, self.rect.h)
		love.graphics.setColor(self.fColor)
		love.graphics.printf(self.text, self.rect.x, self.rect.y  + math.floor(self.rect.h/4), self.rect.w, 'center')
	end
	
	
end