extends Node2D

@onready var parallax_background = $ParallaxBackground

func _ready():
	# Ensure the ParallaxBackground is visible
	parallax_background.visible = true
