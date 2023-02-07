
function checkValidCharacterName(theText)
	local foundSpace, valid = false, true
	local lastChar, current = ' ', ''
	for i = 1, #theText do
		local char = theText:sub( i, i )
		if char == ' ' then -- it's a space
			if i == #theText then -- space at the end of name is not allowed
				valid = false
				return false, "You cannot have a space at the end\n of the name"
			else
				foundSpace = true -- we have at least two name parts
			end
			
			if #current < 2 then -- check if name's part is at least 2 chars
				valid = false
				return false, "Your name cannot be that small"
			end
			current = ''
		elseif lastChar == ' ' then -- this char follows a space, we need a capital letter
			if char < 'A' or char > 'Z' then
				valid = false
				return false, "You did not use capitals at a start of a name."
			end
			current = current .. char
		elseif ( char >= 'a' and char <= 'z' ) or ( char >= 'A' and char <= 'Z' ) or (char == "'") then -- can have letters anywhere in the name
			current = current .. char
		else -- unrecognized char (numbers, special chars)
			valid = false
			return false, "There are unknown characters \nin the text. You can only use\n A-Z, a-z and spaces"
		end
		lastChar = char
	end

	
	if valid and foundSpace and #theText < 25 and #current >= 2 then
		return true, "Looking good!" -- passed
	else
		return false, "Name is too long or too short \n(min 2, max 25)" -- failed for the checks
	end
end