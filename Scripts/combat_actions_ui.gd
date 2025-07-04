extends Panel
@onready var button_container = $button_container
@onready var combat_actions = "res://Combat actions/"
var ca_buttons : Array[CombatActionButton]

@onready var description_text : RichTextLabel = $RichTextLabel
@onready var game_manager = $"../.."

func _ready():
	
	print(button_container.get_children())
	
	for child in button_container.get_children():
		ca_buttons.append(child)
		child.pressed.connect(_button_pressed.bind(child))
		child.mouse_entered.connect(_button_entered.bind(child))
		child.mouse_exited.connect(_button_exited.bind(child))
	print(ca_buttons)

		
func set_combat_actions (actions : Array[CombatAction]):
	for i in len(ca_buttons):
		if i >= len(actions):
			ca_buttons[i].visible = false
			continue
			
		ca_buttons[i].visible = true
		ca_buttons[i].Set_Combat_Action(actions[i])
	
		
func _button_pressed (button : CombatActionButton):
	print("Button pressed")
	if(button.text == "Magic"):
		print("Ha!")
	else:
		game_manager.player_cast_combat_action(button.combat_action)
	


func _button_entered (button : CombatActionButton):
	var ca = button.combat_action
	description_text.text = "[b]" + ca.display_name + "[/b]\n" + ca.description
	
func _button_exited (button : CombatActionButton):
	description_text.text = ''
	
func _on_pass_turn_button_pressed():
	game_manager.next_turn()
