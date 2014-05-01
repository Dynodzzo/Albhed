-- Label class.

App.Label = App.UIObject:extends({
	__name          = 'Label',
	text            = 'Label',
	fixed           = false,
	font            = App.Font.normal,
	backgroundColor = App.Color.transparent,
	borderColor     = App.Color.transparent,
	borderWidth     = 1,
	borderStyle     = 'smooth',
});

function App.Label:__init(text, x, y, color, font)
	self.text  = text or self.text;
	self.color = color or self.color;
	self:setPosition(x, y);
	self:setFont(font);
end

function App.Label:cleanUp()
	self.text  = nil;
	self.fixed = nil;
	self.font  = nil;
	App.Label.super.cleanUp(self);
end

function App.Label:setSize(w, h)
	if (not self.fixed) then
		App.Label.super.setSize(self, w, h);
	end
end

function App.Label:setFont(font)
	self.font = font or self.font;

	if (not self.fixed) then
		self.size.w = self.font:getWidth(self.text);
		self.size.h = self.font:getHeight();
	end
end

function App.Label:setText(text)
	self.text = text;
end

function App.Label:draw()
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
		love.graphics.setLineStyle(self.borderStyle);
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

function App.Label:mousepressed(x, y, button)
	if (button == 'l') then
		if (self:isInside(x, y)) then
			self:onClick();
		end
	end
end
