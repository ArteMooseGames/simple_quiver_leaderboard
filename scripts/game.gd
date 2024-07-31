extends NinePatchRect

@onready var _user_score: LineEdit = $MarginContainer/VBoxContainer/LineEdit


func _ready() -> void:
	_user_score.grab_focus()


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.is_valid_float() or new_text.is_valid_int():
		var _new_score: float = float(new_text)
		Globals.score = _new_score
		get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")
	else:
		_reset_user_input()


func _reset_user_input() -> void:
	_user_score.placeholder_text = "Int/Float Only"
	_user_score.text = ""
	_user_score.editable = true
