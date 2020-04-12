extends Control


func _ready():
	var words = ["War", "War", "war", "war"];
	var fallout = "%s. %s never changes. In the year 1945, my great, great grandfather, serving in the army, wondered when he'd get to go home to his wife and the son he'd never seen. He got his wish when the US ended World War II by dropping atomic bombs on Hiroshima and Nagasaki. The World awaited Armageddon, instead something miraculous happened. We began to use atomic energy not as a weapon, but as a nearly limitless source of power. People enjoyed luxuries once though the realm of science fiction. Domestic robots, fusion powered cars, portable computers. But then, in the 21st century, people awoke from the American Dream. Years of consumption lead to shortages of nearly every major resource. The entire world unraveled. Peace became a distant memory. It is now the year 2077. We stand on the brink of total war, and I am afraid for myself, my wife, for my infant son. Because if my time in the army taught me one thing: it's that %s, %s never changes.";
	#print(fallout % words);

	#$VBoxContainer/DisplayText.text = fallout % words;


func _on_PlayerText_text_entered(new_text):
	update_DisplayText(new_text)
	
func update_DisplayText(new_text):
	$VBoxContainer/DisplayText.text = new_text;
	$VBoxContainer/PlayerText.clear();
	pass
