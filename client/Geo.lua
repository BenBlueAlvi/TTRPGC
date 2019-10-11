Vector2 = Class{}

function Vector2:init(x, y)
	self.x = x
	self.y = y
end


function Vector2:dot(v)
	return self.x * v.x + self.y * v.y;
end

function Vector2:perp(v)

	return Vector2(-y, x);
end

function Vector2:subtract(v)
	return Vector2(self.x - v.x, self.y - v.y)
end


Rectangle = Class{}

function Rectangle:init(x, y, w, h)
	self.x = x
	self.y = y
	self.w = w
	self.h= h
	self.pts = {Vector2(x, y), Vector2(x + w, y), Vector2(x, y + h), Vector2(x + w, y + h)}
	self.center = Vector2(x + w/2, y + h/2)
	
	self.top = self.y + self.h
	self.right = self.x + self.w
	
end

function Rectangle:update()
	
	self.center = Vector2()
	
end

function Rectangle:rotateTo(amt)
	radius = math.sqrt(math.pow(w/2, 2) + math.pow(h/2, 2))

end


function _projectionInterval2D(normal, pts, minE, maxE)

	minE = pts[1]:dot(normal)
	maxE = minE 
	for i = 1, table.getn(pts), 1 do
	
		d = pts[k + 1]:dot(normal)
		minE = math.min(minE, d)
		maxE = math.max(maxE, d)
	end
	

end


function SATCollide2D(pts1, pts2)

	normal = Vector2(0,0)
	min1, max1, min2, max2 = 0, 0, 0, 0

	--check pts1
	prev = table.getn(pts1)-1
	for k, v in pairs(pts1) do
	
	
		normal = pts1[k]:subtract(pts1[prev]):perp()
	
		_projectionInterval2D(normal, pts1, numA, min1, max1)
		_projectionInterval2D(normal, pts2, numB, min2, max2)
		if max1 <= min2 or max2 <= min1 then
			return false
		end
		prev = k
	end

	--check pts2
	prev = table.getn(pts2)-1
	for k, v in pairs(pts1) do
	
		normal = pts2[k]:subtract(pts2[prev]):perp()
		_projectionInterval2D(normal, pts1, numA, min1, max1)
		_projectionInterval2D(normal, pts2, numB, min2, max2)
		if max1 <= min2 or max1 <= min2 then
			return false
		end
		prev = k
	end

	return true;
end


function AABBcollide(rect1, rect2)
	if rect1.x < rect2.x + rect2.w and rect1.x + rect1.w > rect2.x and rect1.y < rect2.y + rect2.h and rect1.y + rect1.h > rect2.y then
		return true
	end
	return false
end

function rectContains(rect, x, y)
	if rect.x < x and rect.right > x and rect.top > y and rect.y < y then
		return true
	end
	return false
end

function pointAt(x, y, x2, y2)

		yDiff = y - y2
		xDiff = x - x2
		newAngle = math.deg(math.atan2(yDiff, xDiff)) + 180


		return newAngle;
end