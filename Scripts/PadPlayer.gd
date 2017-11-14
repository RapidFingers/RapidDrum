extends Node

# Timer player
var player
# Track to play
var track
# Kit to play
var drumKit
# Play list to play
var playList = []
# Play step
var step = 0
# Playlist count
var listCount = 0

func _ready():
	player = get_node("PlayerTimer")

# Set kit to play
func setKit(kit):
	drumKit = kit
	
# Set track for playing
func setTrack(tr):
	track = tr

# Create playlist for kit
func createPlaylist():
	playList.clear()
	var count = track.getCount()
	for x in range(0, count):
		var coll = track.getPadCollection(x)
		if not coll.hasPads():
			continue
			
		var collSum = coll.getColSumm()
		for cl in collSum:
			playList.append(cl)
	
	listCount = len(playList)

# Start play
func play():
	step = 0
	createPlaylist()
	player.start()

# Stop play
func stop():
	player.stop()

# On timer
func _on_PlayerTimer_timeout():
	if step >= listCount:
		step = 0
		
	var pattern = playList[step]
	step += 1
	
	drumKit.play(pattern)
