extends TextureButton

@export_group("My Properties")
@export var button_text: String = "Start"
@export var font_size: int = 49
@export var button_size_x: int = 225
@export var button_size_y: int = 225
@export var button_label_y_offset: int = 8
@export var scene_location: String

@onready var _button_label: Label = $ButtonLabel

func _ready():
	_button_label.text = button_text
	_button_label.add_theme_font_size_override("font_size", font_size)
	custom_minimum_size.x = button_size_x
	custom_minimum_size.y = button_size_y


func _on_button_down():
	_button_label.position += Vector2(0, button_label_y_offset)


func _on_button_up():
	_button_label.position -= Vector2(0, button_label_y_offset)
	get_tree().change_scene_to_file(scene_location)
