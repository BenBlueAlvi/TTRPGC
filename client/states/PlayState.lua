PlayState = Class{}

CLIENT = Client("127.0.0.1", 7777)
PID = math.random(1, 1000)

function PlayState:init()
	love.graphics.setDefaultFilter("nearest", "nearest")

	
end


function PlayState:enter()
	CLIENT:connect(PID)
end

function PlayState:exitt()

end

function PlayState:update(dt)
	CLIENT:update()
	chat:update()
	
	
	if connTimer > 0 then --player connection
		connTimer = connTimer - dt
		print(connTimer)
		if connTimer <= 0 then
			CLIENT:sendPlayerConnect()
		end
	end
	
end

function PlayState:draw()


	love.graphics.printf("recieved", 0, 10, VIRTUAL_WIDTH, 'center')
	love.graphics.printf(':' .. CLIENT.last, 0, 50, VIRTUAL_WIDTH, 'center')
	
	
	if CLIENT.connected then
		love.graphics.printf("connected!", 0, 10, VIRTUAL_WIDTH, 'left')
	else
		love.graphics.printf("disconnected!", 0, 10, VIRTUAL_WIDTH, 'left')
	end
	
	chat:draw()
	
end