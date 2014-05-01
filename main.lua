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
	
	love.keyboard.setKeyRepeat(true);
	
	App.lblUntranslatedText = App.Label:new('Input text', 50, 50);
	App.lblTranslatedText = App.Label:new('Al Bhed', 50, 90);
	
	App.tbxUntranslatedText = App.TextBox:new(150, 50);
	App.btnTranslateText = App.Button:new('Translate', 50, 120);
	App.btnTranslateText.clickEvent = btnTranslateClick;
	
	App.translator = App.Translator:new();
	App.translator:addAlphabet('latin', latinAlphabet);
	App.translator:addAlphabet('albhed', albhedAlphabet);
	App.translator:addAlphabet('albhedPho', albhedPhoneticsAlphabet);
end

function love.draw()
	App.lblUntranslatedText:draw();
	App.lblTranslatedText:draw();
	App.tbxUntranslatedText:draw();
	App.btnTranslateText:draw();
end

function love.update(dt)
	App.tbxUntranslatedText:update(dt);
end

function love.keypressed(key)
	if (key == 'backspace') then
		App.tbxUntranslatedText:pop();
	end
end

function love.mousepressed(x, y, button)
	App.btnTranslateText:mousepressed(x, y, button);
end

function love.textinput(text)
	App.tbxUntranslatedText:append(text);
end

function btnTranslateClick()
	local untranslatedText = App.tbxUntranslatedText:getText();
	local albhedText = App.translator:convertTo(untranslatedText, 'latin', 'albhed');
	App.lblTranslatedText:setText(albhedText);
	albhedText = string.gsub(albhedText, ' ', '%%20');
	
	local data, serverResponse = App.Http.request(GoogleTTSBaseUrl .. albhedText);
	local soundData = 0;
	local audio = 0;
	
	print(serverResponse, type(serverResponse));
	
	if (data and serverResponse == 200) then
		love.filesystem.write('test.mp3', data);
		local doesSoundExists = love.filesystem.exists('test.mp3');
		love.graphics.setColor(App.Color.white);
		
		if (doesSoundExists) then
			soundData = love.sound.newSoundData('test.mp3');
			audio = love.audio.newSource(soundData);
			audio:play();
		end
	end
end

