extends Node

var weapons : Array[Weapon] = []

# Used for choosing random weapon as a reward
var all_possible_weapons : Array[Weapon] = []

@onready var weapons_node = get_tree().get_first_node_in_group("player").get_node("Weapons")

func _ready() -> void:
	# Get weapons player started with
	for node in weapons_node.get_children():
		if typeof(node) == typeof(Weapon):
			weapons.append(node)


func get_all_upgrades():
	var all_upgrades = []
	for weapon in weapons:
		all_upgrades.append_array(weapon.get_available_upgrades())
	return all_upgrades

# returns specified amount of upgrades chosen randomly 
func get_randomly_chosen_upgrades(amount: int, avoided_upgrades = []):
	# Geting upgrades from each weapon
	var all_upgrades = get_all_upgrades()
	for avoid_upgrade in avoided_upgrades:
		if avoid_upgrade in all_upgrades:
			all_upgrades.erase(avoid_upgrade)
	# Checking if array of upgrades is empty	
	if all_upgrades.size() == 0:
		return	
	# Array for drawn upgrades
	var drawn_upgrades = []
	# Drawing cards by their weight
	for i in amount:
		var overall_chance = 0
		for upgrade in all_upgrades:
			overall_chance += upgrade.weight	
		var random_number = randf_range(0, overall_chance)
		var offset: float = 0
		for upgrade in all_upgrades:
			if random_number < upgrade.weight + offset:
				drawn_upgrades.append(upgrade)
				all_upgrades.erase(upgrade)
				break
			else:
				offset += upgrade.weight
				
	return drawn_upgrades
