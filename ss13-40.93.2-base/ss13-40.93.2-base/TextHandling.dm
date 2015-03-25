
/proc/dd_file2list(file_path, separator)

	var/file
	if (separator == null)
		separator = "\n"
	if (isfile(file_path))
		file = file_path
	else
		file = file( file_path )
	return dd_text2list(file2text(file), separator)
	return

/proc/dd_replacetext(text, search_string, replacement_string)

	var/textList = dd_text2list(text, search_string)
	return dd_list2text(textList, replacement_string)
	return

/proc/dd_replaceText(text, search_string, replacement_string)

	var/textList = dd_text2List(text, search_string)
	return dd_list2text(textList, replacement_string)
	return

/proc/dd_hasprefix(text, prefix)

	var/start = 1
	var/end = length(prefix) + 1
	return findtext(text, prefix, start, end)
	return

/proc/dd_hasPrefix(text, prefix)

	var/start = 1
	var/end = length(prefix) + 1
	return findText(text, prefix, start, end)
	return

/proc/dd_hassuffix(text, suffix)

	var/start = length(text) - length(suffix)
	if (start)
		return findtext(text, suffix, start, null)
	return

/proc/dd_hasSuffix(text, suffix)

	var/start = length(text) - length(suffix)
	if (start)
		return findText(text, suffix, start, null)
	return

/proc/dd_text2list(text, separator)

	var/textlength = length(text)
	var/separatorlength = length(separator)
	var/textList = new /list(  )
	var/searchPosition = 1
	var/findPosition = 1
	while(1)
		findPosition = findtext(text, separator, searchPosition, 0)
		var/buggyText = copytext(text, searchPosition, findPosition)
		textList += text("[]", buggyText)
		searchPosition = findPosition + separatorlength
		if (findPosition == 0)
			return textList
		else
			if (searchPosition > textlength)
				textList += ""
				return textList
	return

/proc/dd_text2List(text, separator)

	var/textlength = length(text)
	var/separatorlength = length(separator)
	var/textList = new /list(  )
	var/searchPosition = 1
	var/findPosition = 1
	while(1)
		findPosition = findText(text, separator, searchPosition, 0)
		var/buggyText = copytext(text, searchPosition, findPosition)
		textList += text("[]", buggyText)
		searchPosition = findPosition + separatorlength
		if (findPosition == 0)
			return textList
		else
			if (searchPosition > textlength)
				textList += ""
				return textList
	return

/proc/dd_list2text(var/list/the_list, separator)

	var/total = the_list.len
	if (total == 0)
		return
	var/newText = text("[]", the_list[1])
	var/count = 2
	while(count <= total)
		if (separator)
			newText += separator
		newText += text("[]", the_list[count])
		count++
	return newText
	return

/proc/dd_centertext(message, length)

	var/new_message = message
	var/size = length(message)
	if (size == length)
		return new_message
	if (size > length)
		return copytext(new_message, 1, length + 1)
	var/delta = length - size
	if (delta == 1)
		return new_message + " "
	if (delta % 2)
		new_message = " " + new_message
		delta--
	delta = delta / 2
	var/spaces = ""
	var/count = null
	count = 1
	while(count <= delta)
		spaces += " "
		count++
	return spaces + new_message + spaces
	return

/proc/dd_limittext(message, length)

	var/size = length(message)
	if (size <= length)
		return message
	else
		return copytext(message, 1, length + 1)
	return
