DropdownBox = Class{}

function DropdownBox:init(x, y, w, title, options)

	
	self.rect = Rectangle(x, y, w, 12)
	self.selected = false
	self.color = gColors.white
	self.fColor = gColors.white

	self.options = options
	self.title = title
	self.value = nil
	
end


function DropdownBox:update(mx, my)

	if self.selected then
		self.color = gColors.blue
	else
		self.color = gColors.white
	end
	
	if self.value == nil then
		self.color = gColors.red
	end
	
	if love.mouse.isDown(1) then
		if rectContains(self.rect, mx, my) then
			self.selected = true
		else
			self.selected = false
		end
	end

end

function DropdownBox:draw()

	love.graphics.setColor(self.color)
	love.graphics.rectangle("line", self.rect.x, self.rect.y, self.rect.w, self.rect.h)
	
	love.graphics.printf(self.title, self.rect.x + 2, self.rect.y + 2 - self.rect.h, self.rect.w - 4, 'center')
	
	love.graphics.setFont(gFonts.small)
	love.graphics.setColor(gColors.white)
	if self.value ~= nil then
		love.graphics.printf(self.value, self.rect.x + 2, self.rect.y + 2, self.rect.w - 4, 'center')
	end
	
	if self.selected then
		for k, v in pairs(self.options) do
			love.graphics.rectangle("line", self.rect.x + 2, self.rect.y + k * 14, self.rect.w - 4, self.rect.h)
			love.graphics.printf(v, self.rect.x + 2, self.rect.y + 2 + k * 14, self.rect.w - 4, 'center')
		end
	end
	
	
end