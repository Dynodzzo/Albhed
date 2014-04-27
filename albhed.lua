local latinAlphabet = {
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
};
local albhedAlphabet = {
	'y', 'p', 'l', 't', 'a', 'v', 'k', 'r', 'e', 'z', 'g', 'm', 's',
	'h', 'u', 'b', 'x', 'n', 'c', 'd', 'i', 'j', 'f', 'q', 'o', 'w',
};
local startEscapeChar = '[';
local endEscapeChar = ']';

function isCharacterUppercase(character)
	return string.find(character, '^%u') ~= nil;
end

function getCharacterIndexInAlphabet(character, alphabet)
	for charIndex, char in ipairs(alphabet) do
		if (char == character) then
			return charIndex;
		end
	end
	
	return -1;
end

function getCharacterInAlphabet(charIndex, alphabet)
	return alphabet[charIndex] or '';
end

function convertTo(text, oldAlphabet, newAlphabet)
	local textTranslation = '';
	local doesEscapeChars = false;
	
	for charIndex = 1, string.len(text) do
		local oldChar = string.sub(text, charIndex, charIndex);
		local oldCharIndex = getCharacterIndexInAlphabet(string.lower(oldChar), oldAlphabet);
		local newChar = '';
		
		if (oldChar == startEscapeChar) then
			doesEscapeChars =  true;
		elseif (oldChar == endEscapeChar) then
			doesEscapeChars = false;
		end

		if (doesEscapeChars) then
			newChar = oldChar;
		else
			newChar = getCharacterInAlphabet(oldCharIndex, newAlphabet);
			newChar = (newChar == '') and oldChar or newChar;
			
			if (isCharacterUppercase(oldChar)) then
				newChar = string.upper(newChar);
			end
		end

		textTranslation = textTranslation .. newChar;
	end
	
	return textTranslation;
end

function convertToAlbhed(text)
	return convertTo(text, latinAlphabet, albhedAlphabet);
end

function convertToLatin(text)
	return convertTo(text, albhedAlphabet, latinAlphabet);
end

local text = 'Hello world, [niggaaaaaz] !';
print(convertToAlbhed(text));

