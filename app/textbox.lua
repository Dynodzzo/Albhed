-- TextBox class.

App.TextBox = App.UIObject:extends({
	__name = 'TextBox',
	text = '',
	font = App.Font.normal,
	underlineWidth = 1,
	underlineOffset = 3,
	underlineY = 0,
	caretColor = App.Color.white,
	caretPosition = {x = 0, y = 0},
	caretHeight = 0,
	caretLeftOffset = 1,
	caretStartAlpha = 0,
	caretAmplitude = 250,
	caretOldDt = 0,
	caretAnimDuration = .7,
	caretBlinkWay = true,
});

function App.TextBox:__init(x, y)
	self.position.x = x;
	self.position.y = y;
	self.size.w = 150;
	self.size.h = 25;
	self.underlineY = self.position.y + self.underlineOffset + self:getFontHeight();
	self.caretPosition.x = x;
	self.caretPosition.y = y;
	self.caretHeight = self:getFontHeight();
	self.caretStartAlpha = self.caretColor[4];
end

function App.TextBox:getFontWidth(text)
	return self.font:getWidth(text);
end

function App.TextBox:getFontHeight()
	return self.font:getHeight();
end

function App.TextBox:getFontSize()
	return self.font:getWidth(), self.font:getHeight();
end

function App.TextBox:getText()
	return self.text;
end

function App.TextBox:append(text)
	self.text = self.text .. text;
	self:updateCaret();
end

function App.TextBox:pop()
	local maxTextLength = string.len(self.text) - 1;
	self.text = string.sub(self.text, 1, maxTextLength);
	self:updateCaret();
end

function App.TextBox:updateCaret()
	self.caretPosition.x = self.position.x + self.caretLeftOffset + self:getFontWidth(self.text);
end

function App.TextBox:update(dt)
	if (not self.caretBlinkWay) then
		self.caretColor[4] = App.Easing:outQuint(self.caretStartAlpha, self.caretAmplitude, self.caretOldDt, self.caretAnimDuration);
		self.caretOldDt = self.caretOldDt+ dt;
	else
		self.caretColor[4] = App.Easing:outSine(self.caretStartAlpha, -self.caretAmplitude, self.caretOldDt, self.caretAnimDuration);
		self.caretOldDt = self.caretOldDt+ dt;
	end
	
	if (self.caretOldDt >= self.caretAnimDuration) then
		self.caretBlinkWay = not self.caretBlinkWay;
		self.caretOldDt = 0;
		self.caretStartAlpha = self.caretColor[4];
	end
end

function App.TextBox:draw()
	love.graphics.setColor(self.color);
	love.graphics.setLineWidth(self.underlineWidth);
	love.graphics.print(self.text, self.position.x, self.position.y);
	love.graphics.line(self.position.x, self.underlineY, self.position.x + self.size.w, self.underlineY);
	love.graphics.setColor(self.caretColor);
	love.graphics.line(self.caretPosition.x, self.caretPosition.y, self.caretPosition.x, self.caretPosition.y + self.caretHeight);
end