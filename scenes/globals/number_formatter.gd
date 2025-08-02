extends Node

const QUINTILLION = 1_000_000_000_000_000_000
const QUADRILLION = 1_000_000_000_000_000
const TRILLION = 1_000_000_000_000
const BILLION = 1_000_000_000
const MILLION = 1_000_000
const THOUSAND = 1_000

## Returns a formatted string of the number to make it more readable at
## a glance
func get_pretty_string(num: float) -> String:
	# If below thousand, return as-is
	if num < THOUSAND:
		return str(floori(num))
	
	# If below a million, put a comma in the middle
	if num < MILLION:
		var thousands = int(num / 1000)
		var hundreds = posmod(num, 1000)
		
		var formatted_str = ''
		if thousands > 0:
			formatted_str += str(thousands) + ','
		
		formatted_str += str(hundreds).pad_zeros(3)
		
		return formatted_str
	
	# Otherwise represent it with 3 decimal places and a word
	var base
	if num >= QUINTILLION:
		base = QUINTILLION
	elif num >= QUADRILLION:
		base = QUADRILLION
	elif num >= TRILLION:
		base = TRILLION
	elif num >= BILLION:
		base = BILLION
	else:
		base = MILLION
	
	var significant_portion = num / base
	var base_text = _get_base_string(base)
	# Truncate to 3 digits
	var significant_string = "%.3f " % significant_portion + base_text
	return  significant_string


## Get the string representation of the base
func _get_base_string(base: float) -> String:
	if base >= QUINTILLION:
		return 'Quintillion'
	elif base >= QUADRILLION:
		return 'Quadrillion'
	elif base >= TRILLION:
		return 'Trillion'
	elif base >= BILLION:
		return 'Billion'
	else:
		return "Million"
