extends HBoxContainer

@export_group("My Properties")
@export var rank_label_text: String = "1 -"
@export var user_label_text: String = "___"
@export var user_time_text: String = "000.00"
@export var font_size: int = 49

var color: String = "#ffffff"

@onready var _rank_label: RichTextLabel = $RankLabel
@onready var _user_label: RichTextLabel = $UserLabel
@onready var _user_time: RichTextLabel = $UserTime


func _ready() -> void:
	_rank_label.text = "[right]%s[/right]" % rank_label_text
	_user_label.text = user_label_text
	_user_time.text = user_time_text
	_rank_label.add_theme_font_size_override("normal_font_size", font_size)
	_user_label.add_theme_font_size_override("normal_font_size", font_size)
	_user_time.add_theme_font_size_override("normal_font_size", font_size)


func gold_label():
	_rank_label.text = "[color=#ffd11b][right]%s[/right][/color]" % _rank_label.text 
	_user_label.text = "[color=#ffd11b]%s[/color]" % _user_label.text
	_user_time.text = "[color=#ffd11b]%s[/color]" % _user_time.text
