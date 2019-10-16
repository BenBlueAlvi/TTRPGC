Chat = Class{}


function Chat:init()
	self.lines = {}
	self.typeLine = ""
	
		
end


function Chat:update()
	
	--check for relevent data
	local chat = CLIENT:getCommand('chat', true)
	if chat then
		
			table.insert(self.lines, chat['message'])
		
		
		--TODO and chat limit
	end
	
	--check for key input 
	for k, v in pairs(love.keyboard.keysPressed) do
	
	
		if v and k ~= 'return' and k ~= 'backspace' then
			new = k
			if love.keyboard.shiftDown then
				new = string.upper(new)
			elseif k == 'space' then
				new = ' ' 
			elseif k == 'lshift' or k == 'rshift' or k == 'lctrl' or k == 'rctrl' then
				new = ''
			end
			
			
			if love.keyboard.shift and string.len(new) > 0 then
				
				new = highCase[new]
				
			end
			
			
			
			self.typeLine = self.typeLine .. new
		
		end
		
		if k == 'backspace' then
			print('back')
			self.typeLine = string.sub(self.typeLine, 1, string.len(self.typeLine) -1)
		end
		
	end
	
	--send it
	if love.keyboard.wasPressed('return') and string.len(self.typeLine) > 0 then
		print(self.typeLine)
		CLIENT:sendChat(self.typeLine)
		--clear typing line
		self.typeLine = ""
	end
	
end


function Chat:draw()
	
	--
	n = table.getn(self.lines)
	for k, v in pairs(self.lines) do
		love.graphics.printf(':' .. v, 0, VIRTUAL_HEIGHT - 10 * (n - k + 1) - 10, VIRTUAL_WIDTH, 'right')
		
	end
	love.graphics.printf('>>>' .. self.typeLine, 0, VIRTUAL_HEIGHT - 10, VIRTUAL_WIDTH, 'right')
end

function Chat:addMessage(m)
	table.insert(self.lines, '[' .. m .. ']')
end