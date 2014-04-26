local latinAlphabet = {
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
};
local albhedAlphabet = {
	'y', 'p', 'l', 't', 'a', 'v', 'k', 'r', 'e', 'z', 'g', 'm', 's',
	'h', 'u', 'b', 'x', 'n', 'c', 'd', 'i', 'j', 'f', 'q', 'o', 'w',
};
local startEscapeChars = '[';
local endEscapeChars = ']';

function isCharacterUppercase(character)
	return character == string.upper(character);
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

function escapingCharsFound(char)
	if (char == startEscapeChars) then
		doesIgnoreChars = true;
	elseif (char == endEscapeChars) then
		doesIgnoreChars = false;
	end
end

function convertTo(text, oldAlphabet, newAlphabet)
	local doesIgnoreChars = false;
	local textTranslation = '';
	
	for charIndex = 1, string.len(text) do
		local oldChar = string.sub(text, charIndex, charIndex);
		local oldCharIndex = getCharacterIndexInAlphabet(string.lower(oldChar), oldAlphabet);
		local newChar = '';

		doesIgnoreChars = escapingCharsFound(oldChar);

		if (doesIgnoreChars) then
			newChar = oldChar;
		else
			newChar = getCharacterInAlphabet(oldCharIndex, newAlphabet);
			
			if (newChar == '') then
				newChar = oldChar;
			end
			
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

