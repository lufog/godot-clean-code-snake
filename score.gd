class_name Score extends Control


@onready var score_label: Label = $HBox/ScoreLabel


func update(snake_length: int) -> void:
	score_label.text = str(snake_length - 2)
