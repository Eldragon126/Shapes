extends RichTextLabel
var rand

func _ready():
	rand = randi_range(1,10)
	if rand == 1:
		text = "Where every side has a story."
	elif rand == 2:
		text = "Sharp deals. Round prices. You're acute. And I'm 60!"
	elif rand == 3:
		text = "We take all shapes… especially shady ones."
	elif rand == 4:
		text = "I love your curves... If curves = money"
	elif rand == 5:
		text = "If I had a nickle for every vertex I have, I'd have three"
	elif rand == 6:
		text = "Vintage 90° corner"
	elif rand == 7:
		text = "Rare obtuse edition"
	elif rand == 8:
		text = "Missing vertex. Reward if found."
	elif rand == 9:
		text = "Buddy… triangles only get three... But who's counting?"
	elif rand == 10:
		text = "Don’t mess with the corners."
	else:
		text = "WE BUY LOW, WE SELL ACUTE."
