TextBox = Class{}


--no scoll, character limited text box
function TextBox:init(x, y, w, h)

	h = 12
	self.rect = Rectangle(x, y, w, h)
	
	self.scroll = 0
	self.oScroll = 0
	self.text = ""
	self.selected = false
	self.color = gColors.white
	self.fColor = gColors.white
	
	
	
	self.maxChars = math.floor(w / 8)
	
end

function TextBox:typee()

	for k, v in pairs(love.keyboard.keysPressed) do
	
	
		if v and k ~= 'return' and k ~= 'backspace' then
			new = k
			if love.keyboard.shiftDown then
				new = string.upper(new)
			end
			if k == 'space' then
				new = ' ' 
			end
			if k == 'lshift' or k == 'rshift' or k == 'lctrl' or k == 'rctrl' then
				new = ''
			end
			if love.keyboard.shift and string.len(new) > 0 then
				
				new = highCase[new]
				
			end
			
			self.text = self.text .. new
		
		end
		
		
		if k == 'backspace' then
			print('back')
			self.text = string.sub(self.text, 1, string.len(self.text) -1)
		end
	end
	


	
end


function TextBox:update(mx, my)
	
	if self.selected then
		self.color = gColors.blue
	else
		self.color = gColors.white
	end
	
	if love.mouse.isDown(1) then
		if rectContains(self.rect, mx, my) then
			self.selected = true
		else
			self.selected = false
		end
	end
	
	if self.selected then
		self:typee()
	end
	

	
	if string.len(self.text) > self.maxChars then
		self.text = string.sub(self.text, 1, self.maxChars)
	end
		
	
	

end

function TextBox:draw()

	love.graphics.setColor(self.color)
	love.graphics.rectangle("line", self.rect.x, self.rect.y, self.rect.w, self.rect.h)
	
	love.graphics.setFont(gFonts.small)
	love.graphics.setColor(self.fColor)
	
		
	love.graphics.printf(self.text, self.rect.x + 2, self.rect.y + 2, self.rect.w - 4, 'center')
	
	love.graphics.setColor(gColors.white)

end