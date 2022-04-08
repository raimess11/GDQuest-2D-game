extends Node

signal score_update
signal player_died

var score = 0 setget set_score
var died = 0 setget set_died

func reset() -> void:
	score = 0
	died = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_update")

func set_died(value: int) -> void:
	died = value
	emit_signal("player_died")
