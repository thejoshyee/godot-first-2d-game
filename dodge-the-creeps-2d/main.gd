extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	print("new_game called!")  # ADD THIS
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	


func _on_mob_timer_timeout() -> void:
	print("Trying to spawn mob!") 
	# new mob instance
	var mob = mob_scene.instantiate()
	
	# choose random location on path2d
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# set the mobs pos to the random location
	mob.position = mob_spawn_location.position
	
	# set the mobs direction prependicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# add some randomness to the direction
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# choose the velocity for the mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	#spawn the mob by additing to the Main Scene
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score += 1


func _on_start_timer_timeout() -> void:
	print("StartTimer finished!")  # ADD THIS
	$MobTimer.start()
	$ScoreTimer.start()
