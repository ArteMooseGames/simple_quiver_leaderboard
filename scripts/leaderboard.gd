extends MarginContainer

signal valid_initials_entered

const LEADERBOARD_ID: String = "your-leaderboard-id-here"

var _player_initials: String = ""
var _existing_player_score: Dictionary = {}
var _player_score_dict: Dictionary = {}
var _current_leaderboard: Dictionary = {}
var _current_leaderboard_scores: Array = []

var _rank_node_root: String = "VBoxContainer/TopSection/MarginContainer/VBoxContainer/HBoxContainer"
var _left_rank_path: String = _rank_node_root + "/LeaderboardLabelsLeft"
var _right_rank_path: String = _rank_node_root + "/LeaderboardLabelsRight"

var _rank_node_paths: Dictionary = {
	0: _left_rank_path + "/Rank1",
	1: _left_rank_path + "/Rank2",
	2: _left_rank_path + "/Rank3",
	3: _left_rank_path + "/Rank4",
	4: _left_rank_path + "/Rank5",
	5: _right_rank_path + "/Rank6",
	6: _right_rank_path + "/Rank7",
	7: _right_rank_path + "/Rank8",
	8: _right_rank_path + "/Rank9",
	9: _right_rank_path + "/Rank10",
}

@onready var _score_label: RichTextLabel = $VBoxContainer/TopSection/MarginContainer/VBoxContainer/LabelContainer/ScoreLabel
@onready var _user_input: LineEdit = $VBoxContainer/BottomSection/MarginContainer/HBoxContainer/UserInput


func _ready() -> void:
	# Update score label
	_score_label.text = "Your Score: %s" % Globals.score
	
	# Check if user has a previously submitted score under a guest account.
	# Use await to wait for the call the the Quiver DB before proceeding.
	await _check_for_previous_player_score()

	if _player_initials.length() < 3:
		# Allow user to enter initials
		# User can now enter initials and click enter to submit. 
		# This triggers the signal that runs `_on_user_input_text_submitted`
		_user_input.visible = true
		_user_input.grab_focus()
		await valid_initials_entered
		
	# Post the new score. This will replace the user's previous score if it
	#	is a better score.
	await Leaderboards.post_guest_score(LEADERBOARD_ID, Globals.score, _player_initials)
	
	# Now that the user's score is in the leaderboard, we can retrieve the top 10.
	await _update_current_leaderboard()

	# Now that we have an updated top 10, we can post it to the scene.
	_build_ranks_from_leaderboard()


func _check_for_previous_player_score():
	# This retrieves a dictionary that is a quiver score object. 
	# If a player has logged a score with their current device, this will 
	# 	return an object that has a "scores" key.
	# "scores" holds a list of dictionaries of score entries. 
	# Here, we are requestingthe highest score only, since we set up
	#	the leaderboard to only store the best score per user.
	_existing_player_score = await Leaderboards.get_player_scores(LEADERBOARD_ID, 0, 1)
	
	if len(_existing_player_score["scores"]) > 0:
		# We only need the single score entry.
		_player_score_dict = _existing_player_score["scores"][0]
		_player_initials = _player_score_dict["name"]
	else:
		print_debug("No initials found.")


func _update_current_leaderboard():
	_current_leaderboard = await Leaderboards.get_scores(LEADERBOARD_ID, 0, 10)
	_current_leaderboard_scores = _current_leaderboard["scores"]


func _build_ranks_from_leaderboard():
	var _entry_at_current_rank: Dictionary = {}
	
	for i in range(len(_current_leaderboard_scores)):
		_entry_at_current_rank = _current_leaderboard_scores[i]
		get_node(_rank_node_paths[i] + "/UserLabel").text = _entry_at_current_rank["name"]
		get_node(_rank_node_paths[i] + "/UserTime").text = str("%.2f" % _entry_at_current_rank["score"])
		
		# We will highlight the current player if they are in the top 10.
		if _entry_at_current_rank["is_current_player"]:
			get_node(_rank_node_paths[i]).gold_label()


func _on_user_input_text_submitted(new_text: String) -> void:
	_player_initials = new_text.to_upper()
	# Validate text (require 3)
	if len(_player_initials) != 3:
		reset_user_input()
	# If text not 3 long, reset the node and put a red box around it? 
	else:
		emit_signal("valid_initials_entered")
		_user_input.queue_free()


func reset_user_input() -> void:
	_user_input.placeholder_text = "3 Initials Required"
	_user_input.text = ""
	_user_input.editable = true
