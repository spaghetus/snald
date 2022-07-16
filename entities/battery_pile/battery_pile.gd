extends QodotEntity

var battery = preload("res://entities/battery_pile/physical_battery.tscn")

var batteries = []

# Called when the node enters the scene tree for the first time.
func _ready():
	EventMan.connect("on", self, "on")
	pass # Replace with function body.

func on(circuit: String):
	if circuit == "give_battery":
		var b: RigidBody = battery.instance()
		batteries.append(b)
		add_child(b)
		b.global_transform = $spawn_position.global_transform
		b.transform.origin += Vector3(
			rand_range(-0.25, 0.25),
			rand_range(-0.25, 0.25),
			rand_range(-0.25, 0.25)
		)
	if circuit == "use_battery":
		var b: Node = batteries.pop_front()
		if not b:
			return
		remove_visitor(b)
		EventMan.power += 20.0

func remove_visitor(n: Node):
	for c in n.get_children():
		remove_visitor(c)
	n.remove_and_skip()