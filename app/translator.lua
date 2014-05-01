-- Translator class.

App.Translator = App.Class({
	__name  = 'Translator',
	startEscapeChar = '[',
	endEscapeChar = ']',
	alphabets = {},
	vowels = {'a', 'e', 'i', 'o', 'u', 'y'};
});

function App.Translator:isCharacterUppercase(character)
	return string.find(character, '^%u') ~= nil;
end

function App.Translator:isCharacterVowel(character)
	for _, vowel in ipairs(self.vowels) do
		if (string.lower(character) == vowel) then
			return true;
		end
	end
	
	return false;
end

function App.Translator:addAlphabet(name, alphabet)
	self.alphabets[name] = alphabet;
end
	
function App.Translator:getCharacterIndexInAlphabet(character, alphabetName)
	for charIndex, char in ipairs(self.alphabets[alphabetName]) do
		if (char == string.lower(character)) then
			return charIndex;
		end
	end
	
	return -1;
end

function App.Translator:getCharacterInAlphabet(charIndex, alphabetName)
	return self.alphabets[alphabetName][charIndex] or '';
end

function App.Translator:getAlbhedPhonetics(text, oldAlphabetName)
	local textPhonetics = '';
	local doesEscapeChars = false;
	local separateWord = false;
	
	for charIndex = 1, string.len(text) do
		local oldChar = string.sub(text, charIndex, charIndex);
		local oldCharIndex = self:getCharacterIndexInAlphabet(oldChar, oldAlphabetName);
		local phoneticsChar = '';
		
		if (oldChar == self.startEscapeChar) then
			doesEscapeChars =  true;
		elseif (oldChar == self.endEscapeChar) then
			doesEscapeChars = false;
		end
		
		if (doesEscapeChars) then
			phoneticsChar = oldChar;
		else
			phoneticsChar = self:getCharacterInAlphabet(oldCharIndex, 'albhedPho');
			
			if (phoneticsChar == '') then
				phoneticsChar = oldChar;
				separateWord = false;
			else
				if (self:isCharacterUppercase(oldChar)) then
					phoneticsChar = string.upper(phoneticsChar);
				end
				
				if (separateWord) then
					if (not self:isCharacterVowel(oldChar) and string.len(phoneticsChar) > 1) then
						phoneticsChar = '-' .. phoneticsChar;
					end
				end
				
				separateWord = true;
			end
		end
		
		textPhonetics = textPhonetics .. phoneticsChar;
	end
	
	return textPhonetics;
end

function App.Translator:convertTo(text, oldAlphabetName, newAlphabetName, withPhonetics)
	local textTranslation = '';
	local textPhonetics = '';
	local doesEscapeChars = false;
	
	for charIndex = 1, string.len(text) do
		local oldChar = string.sub(text, charIndex, charIndex);
		local oldCharIndex = self:getCharacterIndexInAlphabet(oldChar, oldAlphabetName);
		local newChar = '';
		
		if (oldChar == self.startEscapeChar) then
			doesEscapeChars =  true;
		elseif (oldChar == self.endEscapeChar) then
			doesEscapeChars = false;
		end

		if (doesEscapeChars) then
			newChar = oldChar;
		else
			newChar = self:getCharacterInAlphabet(oldCharIndex, newAlphabetName);
			if (newChar == '') then
				newChar = oldChar;
			else
				if (self:isCharacterUppercase(oldChar)) then
					newChar = string.upper(newChar);
				end
			end
		end

		textTranslation = textTranslation .. newChar;
	end
	
	if (withPhonetics) then
		textPhonetics = self:getAlbhedPhonetics(textTranslation, oldAlphabetName);
	end
	
	return textTranslation, textPhonetics;
end

function App.Translator:convertToAlbhed(text, withPhonetics)
	return self:convertTo(text, latinAlphabet, albhedAlphabet, withPhonetics);
end

function App.Translator:convertToLatin(text)
	return self:convertTo(text, albhedAlphabet, latinAlphabet);
end
