local latinAlphabet = {
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
};
local albhedAlphabet = {
	'y', 'p', 'l', 't', 'a', 'v', 'k', 'r', 'e', 'z', 'g', 'm', 's',
	'h', 'u', 'b', 'x', 'n', 'c', 'd', 'i', 'j', 'f', 'q', 'o', 'w',
};

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

function convertToAlbhed(text)
	local albhedTranslation = '';
	
	for charIndex = 1, string.len(text) do
		local latinChar = string.sub(text, charIndex, charIndex);
		local latinCharIndex = getCharacterIndexInAlphabet(string.lower(latinChar), latinAlphabet);
		local albhedChar = getCharacterInAlphabet(latinCharIndex, albhedAlphabet);
		
		if (albhedChar == '') then
			albhedChar = latinChar;
		end
		
		if (isCharacterUppercase(latinChar)) then
			albhedChar = string.upper(albhedChar);
		end
		
		albhedTranslation = albhedTranslation .. albhedChar;
	end
	
	return albhedTranslation;
end

local text = 'Acide mon gars !';
print(convertToAlbhed(text));