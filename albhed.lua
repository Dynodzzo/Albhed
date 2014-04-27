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
}
local vowels = {'a', 'e', 'i', 'o', 'u', 'y'};

local startEscapeChar = '[';
local endEscapeChar = ']';

function isCharacterUppercase(character)
	return string.find(character, '^%u') ~= nil;
end

function isCharacterVowel(character)
	for _, vowel in ipairs(vowels) do
		if (string.lower(character) == vowel) then
			return true;
		end
	end
	
	return false;
end

function getCharacterIndexInAlphabet(character, alphabet)
	for charIndex, char in ipairs(alphabet) do
		if (char == string.lower(character)) then
			return charIndex;
		end
	end
	
	return -1;
end

function getCharacterInAlphabet(charIndex, alphabet)
	return alphabet[charIndex] or '';
end

function getAlbhedPhonetics(text, oldAlphabet)
	local textPhonetics = '';
	local doesEscapeChars = false;
	local separateWord = false;
	
	for charIndex = 1, string.len(text) do
		local oldChar = string.sub(text, charIndex, charIndex);
		local oldCharIndex = getCharacterIndexInAlphabet(oldChar, oldAlphabet);
		local phoneticsChar = '';
		
		if (oldChar == startEscapeChar) then
			doesEscapeChars =  true;
		elseif (oldChar == endEscapeChar) then
			doesEscapeChars = false;
		end
		
		if (doesEscapeChars) then
			phoneticsChar = oldChar;
		else
			phoneticsChar = getCharacterInAlphabet(oldCharIndex, albhedPhoneticsAlphabet);
			
			if (phoneticsChar == '') then
				phoneticsChar = oldChar;
				separateWord = false;
			else
				if (isCharacterUppercase(oldChar)) then
					phoneticsChar = string.upper(phoneticsChar);
				end
				
				if (separateWord) then
					if (not isCharacterVowel(oldChar) and string.len(phoneticsChar) > 1) then
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

function convertTo(text, oldAlphabet, newAlphabet, withPhonetics)
	local textTranslation = '';
	local textPhonetics = '';
	local doesEscapeChars = false;
	
	for charIndex = 1, string.len(text) do
		local oldChar = string.sub(text, charIndex, charIndex);
		local oldCharIndex = getCharacterIndexInAlphabet(oldChar, oldAlphabet);
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
			if (newChar == '') then
				newChar = oldChar;
			else
				if (isCharacterUppercase(oldChar)) then
					newChar = string.upper(newChar);
				end
			end
		end

		textTranslation = textTranslation .. newChar;
	end
	
	if (withPhonetics) then
		textPhonetics = getAlbhedPhonetics(textTranslation, oldAlphabet);
	end
	
	return textTranslation, textPhonetics;
end

function convertToAlbhed(text, withPhonetics)
	return convertTo(text, latinAlphabet, albhedAlphabet, withPhonetics);
end

function convertToLatin(text)
	return convertTo(text, albhedAlphabet, latinAlphabet);
end

local text = 'Lorem ipsum dolor sit amet.';
print(convertToAlbhed(text, true));

