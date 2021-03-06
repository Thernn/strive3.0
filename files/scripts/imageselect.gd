extends Node

var mode = 'portrait' setget mode_set
var person

var portaitsbuilt = false
var bodybuilt = false
var portraitspath = globals.setfolders.portraits
var bodypath = globals.setfolders.fullbody
var portaitsfolder = 'file://' + OS.get_user_data_dir() + '/portraits'

func mode_set(value):
	if mode != value:
		mode = value
		portaitsbuilt = false

func chooseimage():
	if get_node("racelock").is_pressed() == false:
		get_node("search").visible = true
		get_node("search").set_text("")
	else:
		get_node("search").visible = false
	popup()
	if portaitsbuilt == false:
		portaitsbuilt = true
		buildimagelist(mode)
	resort()


func _on_reloadlist_pressed():
	buildimagelist(mode)

func buildimagelist(type = mode):
	var dir = Directory.new()
	var array = []
	var filecheck = File.new()
	var currentpath 
	if type == 'portrait':
		currentpath = portraitspath
	else:
		currentpath = bodypath
	for i in get_node("ScrollContainer/GridContainer").get_children():
		if i.get_name() != "Button":
			i.visible = false
			i.free()
	if dir.dir_exists(currentpath) == false:
		dir.make_dir(currentpath)
	for i in globals.dir_contents(currentpath):
		if filecheck.file_exists(i) && (i.find('.png') >= 0 || i.find('.jpg') >= 0):
			var node = get_node("ScrollContainer/GridContainer/Button").duplicate()
			get_node("ScrollContainer/GridContainer").add_child(node)
			node.get_node("pic").set_texture(globals.loadimage(i))
			node.connect('pressed', self, 'setslaveimage', [i])
			node.get_node("Label").set_text(i.replacen(currentpath,'').replacen('.jpg','').replacen('.png',''))
			node.set_meta("type", i)
	resort()


func resort():
	var strictsearch = get_node("racelock").is_pressed()
	var gender = person.sex
	var race = person.race
	var counter = 0
	if gender == 'futanari':
		gender = 'female'
	race = race.replace("Beastkin ", "").replace("Halfkin ", "")

	
	
	
	for i in get_node("ScrollContainer/GridContainer").get_children():
		i.visible = false
		if i == get_node("ScrollContainer/GridContainer/Button"):
			continue
		if strictsearch == true:
			if i.get_meta('type').findn(race) < 0:
				continue 
		if strictsearch == false && get_node("search").get_text() != '' && i.get_node("Label").get_text().findn(get_node("search").get_text()) < 0:
			continue
		i.visible = true
		counter += 1
	if counter < 1:
		get_node("noimagestext").visible = true
	else:
		get_node("noimagestext").visible = false

func setslaveimage(path):
	if mode == 'portrait':
		person.imageportait = path
	elif mode == 'body':
		person.imagefull = path
	self.visible = false
	updatepage()



func _on_cancelportait_pressed():
	self.visible = false


func _on_racelock_pressed():
	chooseimage()
	resort()


func _on_search_text_changed( text ):
	resort()

func _on_removeportrait_pressed():
	if mode == 'portrait':
		person.imageportait = null
	elif mode == 'body':
		person.imagefull = null
	self.visible = false
	updatepage()

func _on_reverseportrait_pressed():
	if person.unique != null:
		if person.unique == 'Cali':
			person.imageportait = 'res://files/images/cali/caliportrait.png'
		elif person.unique == 'Emily':
			person.imageportait = "res://files/images/emily/emilyportrait.png"
		elif person.unique == 'Tisha':
			person.imageportait = "res://files/images/tisha/tishaportrait.png"
		elif person.unique == 'Chloe':
			person.imageportait = "res://files/images/chloe/chloeportrait.png"
		elif person.unique == 'Yris':
			person.imageportait = "res://files/images/yris/yrisportrait.png"
		elif person.unique == 'Maple':
			person.imageportait = "res://files/images/maple/mapleportrait.png"
		elif person.unique == 'Ayneris':
			person.imageportait = "res://files/images/ayneris/aynerisportrait.png"
		elif person.unique == 'Melissa':
			person.imageportait = "res://files/images/melissa/melissaportrait.png"
		self.visible = false
		updatepage()



func _on_addcustom_pressed():
	get_node("FileDialog").popup()

func _on_FileDialog_file_selected( path ):
	var dir = Directory.new()
	var path2 = path.substr(path.find_last('/'), path.length()-path.find_last('/'))
	dir.copy(path, portraitspath + path2)
	buildimagelist()

func _on_openfolder_pressed():
	OS.shell_open(OS.get_user_data_dir())

func updatepage():
	if person == globals.player:
		get_tree().get_current_scene()._on_selfbutton_pressed()
	else:
		get_tree().get_current_scene().get_node("MainScreen/slave_tab").slavetabopen()
		get_tree().get_current_scene().rebuild_slave_list()


func _on_selectfolder_pressed():
	get_node("selectfolders").popup()
	get_node("selectfolders/chooseportraitolder").set_text(globals.setfolders.portraits)
	get_node("selectfolders/choosebodyfolder").set_text(globals.setfolders.fullbody)


func _on_chooseportraitolder_pressed():
	get_node("folderdialogue").set_meta('meta', "portrait")
	get_node("folderdialogue").popup()
	if portraitspath.find('user://') >= 0:
		get_node("folderdialogue").set_current_path(OS.get_data_dir() + '/' +portraitspath.replace("user://", ''))
	else:
		get_node("folderdialogue").set_current_path(portraitspath)
	

func _on_choosebodyfolder_pressed():
	get_node("folderdialogue").set_meta('meta', "body")
	get_node("folderdialogue").popup()
	if bodypath.find('user://') >= 0:
		get_node("folderdialogue").set_current_path(OS.get_data_dir() + '/' +bodypath.replace("user://", ''))
	else:
		get_node("folderdialogue").set_current_path(bodypath)

func _on_folderdialogue_dir_selected( dir ):
	if get_node("folderdialogue").get_meta("meta") == 'portrait':
		globals.setfolders.portraits = dir
		portraitspath = dir
		buildimagelist()
		_on_selectfolder_pressed()
	elif get_node("folderdialogue").get_meta("meta") == 'body':
		globals.setfolders.fullbody = dir
		bodypath = dir
		buildimagelist()
		_on_selectfolder_pressed()


func _on_closefolderselect_pressed():
	get_node("selectfolders").visible = false


