class_name CombatActionButton
extends Button

var combat_action : CombatAction

func Set_Combat_Action (ca : CombatAction):
	combat_action = ca
	text = ca.display_name
	
	
