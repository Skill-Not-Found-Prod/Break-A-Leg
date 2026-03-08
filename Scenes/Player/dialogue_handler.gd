extends Node2D

var host

@onready var text = %Dialogue
@onready var portrait = %Port

var speaking = false
var delay = 0

const SET_DELAY = 1

var dialogue = {
	"Portrait" : [],
	"Lines" : ["How are you?", "Woah it works", "Baller"],
}

var current_line = 0

func _ready():
	host = get_parent()

func _physics_process(_delta: float) -> void:
	
	if speaking:
		
		if text.visible_characters >= text.text.length():
			if Input.is_action_just_pressed("ContinueDialogue"):
				NextLine()
		else:
			if delay <= 0:
				text.visible_characters += 1
				delay = SET_DELAY
			else:
				delay -= 1

func StartDialogue():
	current_line = 0
	host.CanMove = false
	speaking = true
	update_info()

func EndDialogue():
	host.CanMove = true
	speaking = false

func NextLine():
	current_line += 1
	update_info()

func update_info():
	
	if current_line <= dialogue["Lines"].size() - 1:
		update_portrait()
		update_line()
	else:
		EndDialogue()

func update_portrait():
	if dialogue["Portrait"][current_line] != null:
		if dialogue["Portrait"][current_line] is String:
			if portrait.texture != load(dialogue["Portrait"][current_line]):
				portrait.texture = load(dialogue["Portrait"][current_line])
				%DialogueAnimationPlayer.play("New Portrait")
		elif dialogue["Portrait"][current_line] is PackedScene:
			if portrait.texture != dialogue["Portrait"][current_line]:
				portrait.texture = dialogue["Portrait"][current_line]
				%DialogueAnimationPlayer.play("New Portrait")
		else:
			portrait.texture = preload("res://icon.png")

func update_line():
	text.visible_characters = 0
	if dialogue["Lines"][current_line] != null:
		text.text = dialogue["Lines"][current_line]
