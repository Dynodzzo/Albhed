-- UIObject class.

App.UIObject = App.Class({
	__name = 'UIObject',
	position = {x = 0, y = 0},
	size = {w = 10, h = 10},
	color = App.Color.white,
});

-- Position
function App.UIObject:getX()
	return self.position.x;
end

function App.UIObject:getY()
	return self.position.y;
end

function App.UIObject:setX(x)
	self.position.x = x;
end

function App.UIObject:setY(y)
	self.position.y = y;
end

function App.UIObject:getPosition()
	return self.position.x, self.position.y;
end

function App.UIObject:setPosition(x, y)
	self.position.x = x or self.position.x;
	self.position.y = y or self.position.y;
end

-- Size
function App.UIObject:getW()
	return self.size.w;
end

function App.UIObject:getH()
	return self.size.h;
end

function App.UIObject:getSize()
	return self.size.w, self.size.h
end