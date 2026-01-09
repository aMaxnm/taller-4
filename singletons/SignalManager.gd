extends Node

signal on_hurt()
signal on_lives_changed(lives: int)
signal on_bonus_grabbed(score: int)
signal on_score_changed(score: int)
<<<<<<< Updated upstream
signal toggle_pause
signal pause_game
signal resume_game
=======
signal on_game_over()
>>>>>>> Stashed changes
signal on_restart_game()
