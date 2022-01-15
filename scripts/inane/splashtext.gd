extends RichTextLabel
var splashes= [
	"not safe for human consumption",
	"now with 100% more crime!",
	"donkey kong is my favourite marvel superhero!",
	"splash text go here",
	"Tell me who you're working for.",
	"The secret to happiness is tea.",
	"Try our other games!",
	"now with more splashtext",
	"Knock knock!",
	"Who's there?",
	"I see no God up here other than ME!",
	"80% cyber secure!",
	"80% cyber secure... more or less",
	"Terraria isn't actually real, don't let them trick you.",
	"We know the Silksong release date, we just aren't telling you.",
	"Send splash text ideas pls",
	"run",
]

func _ready():
	randomize()
	randomize()
	var touse = (randi() % splashes.size() - 1)
	bbcode_text = "[color=blue]" + splashes[touse] + "[/color]"

