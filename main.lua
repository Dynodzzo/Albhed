App = {};

local GoogleTTSBaseUrl = 'http://translate.google.com/translate_tts?ie=utf-8&tl=en&q=';
local latinAlphabet = {
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
};
local albhedAlphabet = {
	'y', 'p', 'l', 't', 'a', 'v', 'k', 'r', 'e', 'z', 'g', 'm', 's',
	'h', 'u', 'b', 'x', 'n', 'c', 'd', 'i', 'j', 'f', 'q', 'o', 'w',
};
local albhedPhoneticsAlphabet = {
	'ah', 'bae', 'ku', 'de', 'eay', 'fe', 'ge', 'ha', 'ee', 'jae', 'kuk', 'lu', 'm',
	'n', 'oh', 'pe', 'q', 'ra', 'see', 'te', 'oo', 'fu', 'w', 'x', 'ae', 'z',
};

function love.load()
	require('app.init');
	
	App.tbxUntranslatedText = App.TextBox:new(50, 50);
	
	local translator = App.Translator:new();
	translator:addAlphabet('latin', latinAlphabet);
	translator:addAlphabet('albhed', albhedAlphabet);
	translator:addAlphabet('albhedPho', albhedPhoneticsAlphabet);
	local albhedText = translator:convertTo('Hello', 'latin', 'albhed');
	-- albhedText = string.format();
	local data = App.Http.request(GoogleTTSBaseUrl .. albhedText);
	
	if (data) then
		-- love.filesystem.write('test.mp3', data);
	end
end

function love.draw()
	App.tbxUntranslatedText:draw();
end

function love.update(dt)
	App.tbxUntranslatedText:update(dt);
end

function love.keypressed(key)
	if (key == 'backspace') then
		App.tbxUntranslatedText:pop();
	end
end

function love.textinput(text)
	App.tbxUntranslatedText:append(text);
end

