extends Control

var player_words = []
var current_story
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText
onready var Label = $VBoxContainer/HBoxContainer/Label

func _ready():
	set_current_story()
#	var words = ["War", "War", "war", "war"];
#	var fallout = "%s. %s never changes. In the year 1945, my great, great grandfather, serving in the army, wondered when he'd get to go home to his wife and the son he'd never seen. He got his wish when the US ended World War II by dropping atomic bombs on Hiroshima and Nagasaki. The World awaited Armageddon, instead something miraculous happened. We began to use atomic energy not as a weapon, but as a nearly limitless source of power. People enjoyed luxuries once though the realm of science fiction. Domestic robots, fusion powered cars, portable computers. But then, in the 21st century, people awoke from the American Dream. Years of consumption lead to shortages of nearly every major resource. The entire world unraveled. Peace became a distant memory. It is now the year 2077. We stand on the brink of total war, and I am afraid for myself, my wife, for my infant son. Because if my time in the army taught me one thing: it's that %s, %s never changes.";
#	#print(fallout % words);
#	var smallTest = "testing"
	DisplayText.text = "Welcome to Loony Lips! This is basically the poor man's version of Mad Libs " #story % prompts #fallout % words;
	check_player_words_length()
	PlayerText.grab_focus()

func set_current_story():
	randomize()
	var stories = get_from_json("StoryBook.json")
	current_story = stories[randi() % stories.size()]
	
func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _on_PlayerText_text_entered(new_text):
	add_to_player_words()
	
func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

func update_DisplayText(words):
	DisplayText.text = words
	PlayerText.clear()

func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()

func is_story_done():
	return player_words.size() == current_story.prompts.size()
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	DisplayText.text += "May I have a "+current_story.prompts[player_words.size()]+ " please?"

func end_game():
	PlayerText.queue_free()
	Label.text = "Again!"
	tell_story()
