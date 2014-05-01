-- Button class.

App.Button = App.UIObject:extends({
	__name          = 'Button',
	text            = 'Button',
	fixed           = false,
	font            = App.Font.normal,
	backgroundColor = App.Color.grey,
	borderColor     = App.Color.white,
	borderWidth     = 1,
	clickEvent      = nil,
});

function App.Button:__init(text, x, y, color, font)
	self.text  = text or self.text;
	self.color = color or self.color;
	self:setPosition(x, y);
	self:setFont(font);
end

function App.Button:cleanUp()
	self.text  = nil;
	self.fixed = nil;
	self.font  = nil;
	App.Button.super.cleanUp(self);
end

function App.Button:setSize(w, h)
	if (not self.fixed) then
		App.Button.super.setSize(self, w, h);
	end
end

function App.Button:setFont(font)
	self.font = font or self.font;

	if (not self.fixed) then
		self.size.w = self.font:getWidth(self.text);
		self.size.h = self.font:getHeight();
	end
end

function App.Button:isInside(x, y)
	return (
		self.position.x < x and
		self.position.x + self.size.w > x and
		self.position.y < y and
		self.position.y + self.size.h > y
	) and true or false;
end

function App.Button:draw()
	love.graphics.setColor(self.backgroundColor);
	love.graphics.polygon(
		'fill', {
			self.position.x,
			self.position.y,
			self.position.x + self.size.w,
			self.position.y,
			self.position.x + self.size.w,
			self.position.y + self.size.h,
			self.position.x,
			self.position.y + self.size.h,
		}
	);
	if (self.borderWidth > 0) then
		love.graphics.setColor(self.borderColor);
		love.graphics.setLineWidth(self.borderWidth);
		-- love.graphics.setLineStyle(self.borderStyle);
		love.graphics.polygon(
			'line', {
				self.position.x,
				self.position.y,
				self.position.x + self.size.w,
				self.position.y,
				self.position.x + self.size.w,
				self.position.y + self.size.h,
				self.position.x,
				self.position.y + self.size.h,
			}
		);
	end
	love.graphics.setColor(self.color);
	love.graphics.setFont(self.font);
	love.graphics.print(self.text, self.position.x, self.position.y);
end

function App.Button:mousepressed(x, y, button)
	if (button == 'l') then
		if (self:isInside(x, y)) then
			-- self:onClick();
			-- self.clickEvent();
			if (self.clickEvent) then
				self.clickEvent();
			end
		end
	end
end
