-- Utility methods & constants

App.Color = {
	white       = {255, 255, 255, 255},
	black       = {0, 0, 0, 255},
	grey        = {128, 128, 128, 255},
	transparent = {0, 0, 0, 0},
	red         = {255, 0, 0, 255},
	green       = {0, 255, 0, 255},
	blue        = {0, 0, 255, 255},
};

App.Font = {
	small  = love.graphics.newFont(8),
	normal = love.graphics.newFont(12),
	large  = love.graphics.newFont(18),
};