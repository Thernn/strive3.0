extends Control


var mouse_in = false
var dragging = false
onready var size = $TextureRect.get_size()
var offset = Vector2()
var status = 'none'

func _ready():
	for i in get_node("TextureRect/roads").get_children():
		i.connect("mouse_entered",self,'showtooltip',[i])
		i.connect("mouse_exited",globals,'hidetooltip')

func _input(event):
	if event.is_action_pressed("LMB"):
		var eventpos = event.global_position
		var barpos = $TextureRect.get_global_position()
		size = $TextureRect.get_size()
		var target_rect = Rect2(barpos.x, barpos.y, size.x, size.y)
		if target_rect.has_point(eventpos):
			status = 'clicked'
			offset = barpos - eventpos
	if event.is_action_released("LMB"):
		status = 'none'
	if status == 'clicked' and event.is_class("InputEventMouseMotion"):
		status = 'dragging'
	#centermap('frostford')
	if status == 'dragging':
		$TextureRect.set_global_position(event.global_position+offset)

func _process(delta):
	var rect = $TextureRect.get_global_rect()
	var parentrect = get_parent().get_global_rect()
	if rect.position.x > parentrect.position.x:
		$TextureRect.rect_global_position.x = parentrect.position.x 
	if rect.position.y > parentrect.position.y:
		$TextureRect.rect_global_position.y = parentrect.position.y 
	if rect.end.x < parentrect.end.x:
		$TextureRect.rect_global_position.x += ((parentrect.end.x) - (rect.end.x))
	if rect.end.y < parentrect.end.y:
		$TextureRect.rect_global_position.y += ((parentrect.end.y) - (rect.end.y))
#	if $TextureRect.get_global_rect().encloses(get_parent().get_global_rect()) == false:
#		$TextureRect.rect_global_position = 

func showtooltip(node):
	var name = node.get_name()
	var text = globals.main.get_node('explorationnode').zones[name].name
	globals.showtooltip(text)

func centermap(name):
	var node = find_node(name)
	var centerscreen = Vector2(get_parent().rect_global_position.x, get_parent().rect_global_position.y) + Vector2(get_parent().rect_size.x/2, get_parent().rect_size.y/2)
	var center = node.rect_global_position
	var nodepos = $TextureRect.rect_global_position
	#print(centerscreen-center)
	$TextureRect.set_global_position(nodepos-center+centerscreen)
	$TextureRect/player.set_global_position(node.rect_global_position)