extends Node

var introtext = "The world of Acheron is going through a period of peace. What few local disputes between cities and regions emerge are quickly prevented and resolved by the major leading and governing force: The Mage's Order. The brightest, richest and most powerful people all aiming to join the most advanced organization out there. Of course, magic, mainly in the form of mind and body manipulations, is well-respected by the whole civilization and is controlled very strictly and scientifically. By utilizing it, The Mage's Order has managed to become what it is now. With it’s rise to power recruitment is now open to any who can prove themselves. Naturally, older members still carry the elitist attitude and look down on those who originate from lesser standing.\n\nWhile magic can be eventually learned and executed by anyone, everything comes at cost. Mana, the source of raw magic, can rarely be obtained directly from nature. The most dominant source for everyone's use is biological life. There are two generally acknowledged options for modern wizards to collect mana for their needs: pain and pleasure. Using other living beings as the source, they can extract and preserve their dormant magic energy either by inflicting wounds and pain, which makes them release accumulated mana, or by indulging in sexual activities, which proved to be nearly as effective at that. Both actions being very essential to life theorized to be a part of the existing great law of things which eventually made it possible for all live beings to form and connects them to this day. \n\nOn the other hand, the average person's survival proves to be hard even at these times of relative peace. Constant shortage of food in many regions and high birth rate makes it hard for many to find a reasonable place in society and as a result they end up becoming outlaws. For those who cannot provide for themselves, slavery has become common practice and is strictly regulated by the government. It serves as a reasonable option for many individuals who seek a better opportunity to their conditions. Slaves make an efficient option for mana gathering. "
var introtext2 = "Although you have managed to dodge any sort of terrible fate, your life still wasn't anything to be happy about. That changed one day when you received a message, informing you that your old uncle had recently passed away. You barely remembered anything about him, but there were no other close relatives and as such he bequeathed his belongings to you. \n\nWhat surprised you even more; it was a reasonably sized two story mansion near one of the local city centers. While  there's really nothing special about it, a building of this degree is a respectable possession on its own. After making up your mind you leave your old life for this new, better opportunity to make a name for yourself. Access to the local Mage's Order will also allow you to gain access to more power and knowledge, as long as you can be accepted into it... Be it a taste of real political power, rowdy big city life, or magic research, you will figure it out once you get there. Managing your own estate might prove to be difficult, but nothing should be too bad once you get a few personal servants..."
var five = globals.patronlist.five
var ten = globals.patronlist.ten

func _ready():
	buildportraitarray()
	
	globals.showalisegreet = false
	if OS.get_name() == "HTML5":
		globals.rules.custommouse = false
	globals.resources.panel = null
	var text = ''
	$warning.visible = true
	$TextureFrame.visible = false
	get_node("TextureFrame/changelog/RichTextLabel").set_selection_enabled(true)
	globals.clearstate()
	five.sort()
	ten.sort()
	text = 'Game design, code and writing: Maverik\nLeading Artist: Warm Tail\n\nSex scenes: NK, Lamoli\n\nWriting and proofreading helpers: Kalderza, Shvan, Xero, Dr. Nobody, Anti-No\n\nPlease contact me if you helped me somewhere and I forgot to mention you.\n\nSpecial notion to all patreons:'
	text += '\n\n$10+ Supporters: [color=green]'
	for i in ten:
		text += i + ', '
	text.erase(text.length()-2, 2)
	text += '[/color]\n\nLegacy Supporters: '
	for i in five:
		text += i + ', '
	text.erase(text.length()-2, 2)
	text += "\n\nIcons: http://game-icons.net \nOST: The Sixth Gate Music \n'Mystery Bazaar', 'Corruption' by Kevin MacLeod (incompetech.com)\nLicensed under Creative Commons: By Attribution 3.0 License\nhttp://creativecommons.org/licenses/by/3.0/"
	text += "\n\nSponsored links: \n\nHomura - https://homurascaptions.com"
	get_node("TextureFrame/creditpanel/RichTextLabel").set_bbcode(text)
	if globals.rules.fullscreen == true:
		OS.set_window_fullscreen(true)
#	if globals.rules.oldresize == true:
#		get_tree().set_screen_stretch(1, 1, Vector2(globals.rules.screenwidth,globals.rules.screenheight))
	charcreateinitiate()
	globals.modsfile._ready()
#--------------------------------------------------------------
	get_node("TextureFrame/newgame/stage6/chardescript").connect("meta_clicked",self,'_on_chardescript_meta_clicked')
	get_node("TextureFrame/newgame/stage6/furcolor").connect("item_selected",self,'_on_furcolor_item_selected')
	
	if !get_node("TextureFrame/newgame/stage6").has_node("scalescolor"):
		var newopbutton = OptionButton.new()
		newopbutton.name = "scalescolor"
		newopbutton.add_to_group('lookoption')
		get_node("TextureFrame/newgame/stage6").add_child(newopbutton)
		get_node("TextureFrame/newgame/stage6/scalescolor").rect_position = Vector2(532, 73)
		get_node("TextureFrame/newgame/stage6/scalescolor").rect_size = Vector2(148, 39)
		get_node("TextureFrame/newgame/stage6/scalescolor").connect("item_selected",self,'_on_scalescolor_item_selected')
		var newlabel = Label.new()
		newlabel.name = "Label"
		newlabel.text = 'Scales Color'
		newlabel.align = HALIGN_CENTER
		get_node("TextureFrame/newgame/stage6/scalescolor").add_child(newlabel)
		get_node("TextureFrame/newgame/stage6/scalescolor/Label").rect_position = Vector2(13, -14)
		get_node("TextureFrame/newgame/stage6/scalescolor/Label").rect_size = Vector2(114, 20)
		
	if !get_node("TextureFrame/newgame/stage6").has_node("featherscolor"):
		var newopbutton1 = OptionButton.new()
		newopbutton1.name = "featherscolor"
		newopbutton1.add_to_group('lookoption')
		get_node("TextureFrame/newgame/stage6").add_child(newopbutton1)
		get_node("TextureFrame/newgame/stage6/featherscolor").rect_position = Vector2(532, 73)
		get_node("TextureFrame/newgame/stage6/featherscolor").rect_size = Vector2(148, 39)
		get_node("TextureFrame/newgame/stage6/featherscolor").connect("item_selected",self,'_on_featherscolor_item_selected')
		var newlabel = Label.new()
		newlabel.name = "Label"
		newlabel.text = 'Feathers Color'
		newlabel.align = HALIGN_CENTER
		get_node("TextureFrame/newgame/stage6/featherscolor").add_child(newlabel)
		get_node("TextureFrame/newgame/stage6/featherscolor/Label").rect_position = Vector2(13, -14)
		get_node("TextureFrame/newgame/stage6/featherscolor/Label").rect_size = Vector2(114, 20)
		
#--------------------------------------------------------------


var maintheme = globals.musicdict.maintheme

func music():
	var music = get_node("music")
	if globals.rules.musicvol == 0:
		return
	var path = ''
	music.set_autoplay(true)
	music.set_stream(maintheme)
	music.play(0)
	music.set_volume_db(globals.rules.musicvol)




func _on_warningconfirm_pressed():
	get_node("TextureFrame").visible = true
	$warning.visible = false
	music()

func _on_warningcancel_pressed():
	_on_exit_pressed()

func _on_exit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_node("TextureFrame/newgame").visible = true
	advancestage()

var filesname = 'user://saves/autosave'

func _on_SavePanel_visibility_changed():
	$TextureFrame/SavePanel.visible = true
	var node
	var pressedsave
	var moddedtext
	for i in get_node("TextureFrame/SavePanel/ScrollContainer/savelist").get_children():
		if i != get_node("TextureFrame/SavePanel/ScrollContainer/savelist/Button"):
			i.queue_free()
			i.visible = false
	get_node("TextureFrame/SavePanel/saveline").set_text(filesname.replacen("user://saves/",''))
	pressedsave = get_node("TextureFrame/SavePanel/saveline").text
	var dir = Directory.new()
	if dir.dir_exists("user://saves") == false:
		dir.make_dir("user://saves")
	for i in globals.dir_contents():
		node = get_node("TextureFrame/SavePanel/ScrollContainer/savelist/Button").duplicate()
		node.visible = true
		if globals.savelist.has(i):
			node.get_node("date").set_text(globals.savelist[i].date)
			node.get_node("name").set_text(i.replacen("user://saves/",''))
			moddedtext = globals.savelist[i].name
		else:
			moddedtext = "This save has no info stored."
			node.get_node("name").set_text(i.replacen("user://saves/",''))
		get_node("TextureFrame/SavePanel/ScrollContainer/savelist").add_child(node)
		node.set_meta('text', i)
		node.connect('pressed', self, 'loadchosen', [node])



func loadchosen(node):
	filesname = node.get_meta('text')
	get_node("TextureFrame/SavePanel/saveline").set_text(filesname.replacen("user://saves/",''))
	var text
	for i in $TextureFrame/SavePanel/ScrollContainer/savelist.get_children():
		i.pressed = (i== node)
	get_node("TextureFrame/SavePanel/ScrollContainer/savelist/Button/name").set_text(filesname.replacen("user://saves/",''))
	if globals.savelist.has(filesname):
		if globals.savelist[filesname].has('portrait') && globals.loadimage(globals.savelist[filesname].portrait):
			$TextureFrame/SavePanel/loadimage.set_texture(globals.loadimage(globals.savelist[filesname].portrait))
		else:
			$TextureFrame/SavePanel/loadimage.set_texture(null)
		text = globals.savelist[filesname].name
	else:
		text = "This save has no info stored."
		$TextureFrame/SavePanel/loadimage.set_texture(null)
	$TextureFrame/SavePanel/RichTextLabel.bbcode_text = text
	
	#_on_SavePanel_visibility_changed()

func _on_deletebuttonssave_pressed():
	var dir = Directory.new()
	if dir.file_exists(filesname):
		yesnopopup('Delete this file?', 'deletefile', 'cancel')
	else:
		popup('No file with such name') 

func deletefile():
	var dir = Directory.new()
	if dir.dir_exists("user://saves") == false:
		dir.make_dir("user://saves")
	dir.remove(filesname)
	cancel()
	_on_SavePanel_visibility_changed()

func _on_loadbutton_pressed():
	var dir = Directory.new()
	if dir.file_exists(filesname):
		loadfile()

func loadfile():
	globals.load_game(filesname)
	_on_SavePanel_visibility_changed()

func _on_load_pressed():
	_on_SavePanel_visibility_changed()

func _on_credits_pressed():
	get_node("TextureFrame/creditpanel").visible = true

func _on_back_pressed():
	get_node("TextureFrame/NewGamePanel").visible = false

func _on_Button_pressed():
	get_node("TextureFrame/NewGamePanel").visible = true

func _on_Options_pressed():
	get_node("options").visible = true

func _on_Version_pressed():
	get_node("TextureFrame/changelog").popup()


#func _on_startrandom_pressed():
#	var newslave = globals.newslave(globals.starting_pc_races[rand_range(0,globals.starting_pc_races.size())],'random','female','commoner')
#	newslave.obed = 100
#	newslave.loyal = 20
#	newslave.beautybase = 40
#	newslave.cleartraits()
#	newslave.work = 'forage'
#	globals.slaves = newslave
#	globals.player = globals.newslave(globals.starting_pc_races[rand_range(0,globals.starting_pc_races.size())],'random','male','commoner')
#	globals.player.relatives.father = 0
#	globals.player.relatives.mother = 0
#	globals.player.ability.append('escape')
#	globals.player.abilityactive.append('escape')
#	globals.player.ability.append("protect")
#	globals.player.abilityactive.append("protect")
#	globals.player.cleartraits()
#	globals.resources.energy = 3
#	globals.resources.day = 1
#	get_tree().change_scene("res://files/Mansion.scn")
#	selectedportrait = portraitarray[randi()%portraitarray.size()]
#	if globals.state.sandbox == false:
#		globals.resources.upgradepoints = 20
#		globals.resources.gold = 500
#		globals.resources.food = 200
#		globals.resources.mana = 10
#	else:
#		globals.resources.upgradepoints = 5
#		for i in globals.state.portals.values():
#			if i.code != currentloc:
#				i.enabled = true
#		globals.resources.gold = 2500
#		globals.resources.food = 500
#		globals.resources.mana = 100
#		globals.state.mainquest = 26
#		globals.state.rank = 4
#		globals.state.sidequests.brothel = 2
#		globals.state.farm = 3
#		globals.state.branding = 2
#		globals.state.portals.amberguard.enabled = true
#		globals.itemdict.youthingpot.unlocked = true
#		globals.itemdict.maturingpot.unlocked = true
#		globals.state.sidequests.sebastianumbra = 2
#		globals.state.portals.umbra.enabled = true


func _on_cancelsaveload_pressed():
	get_node("TextureFrame/SavePanel").visible = false

func _on_patreonbutton_pressed():
	OS.shell_open('https://www.patreon.com/maverik')

func _on_blogbutton_pressed():
	OS.shell_open('https://strivefopower.blogspot.com')

func _on_itchbutton_pressed():
	OS.shell_open('https://strive4power.itch.io/strive-for-power')

func _on_wikibutton_pressed():
	OS.shell_open('http://strive4power.wikia.com/wiki/Strive4power_Wiki')

func _on_creditsclose_pressed():
	get_node("TextureFrame/creditpanel").visible = false


func _on_sandbox_pressed():
	globals.state.sandbox = get_node("TextureFrame/newgame2/sandbox").is_pressed()

###NEWGAME START

var stage = 0 setget stage_set
var sandbox = false
var currentloc = 'wimborn'
var currentrace = 'Human'
var racebonus = "Human"
var currentage = 'adult'
var currentsex = 'male'
var background = 'noble'
var player

func charcreateinitiate():
	for i in get_node("TextureFrame/newgame/stagespanel/VBoxContainer").get_children():
		if i.get_name() != 'cancel':
			i.connect("pressed", self, 'stageselect', [i])
	for i in get_tree().get_nodes_in_group("lookline"):
		i.connect("text_changed", self, 'looklinetext', [i])
	for i in get_tree().get_nodes_in_group("lookoption"):
		i.connect("item_selected", self, 'optionselect', [i])
	for i in get_tree().get_nodes_in_group("statup"):
		i.connect("pressed",self,'statup',[i])
	for i in get_tree().get_nodes_in_group("statdown"):
		i.connect("pressed",self,'statdown',[i])
	for i in get_tree().get_nodes_in_group("slaveoption"):
		i.connect("item_selected",self,'slaveoption', [i])
	for i in get_tree().get_nodes_in_group("startoption"):
		i.connect("pressed",self,'optiontoggle',[i])
	globals.player = globals.newslave('Human', 'teen', 'male')
	get_node("TextureFrame/newgame/stage6/virgin").connect("pressed", self, 'virginpress')

func stageselect(button):
	for i in get_node("TextureFrame/newgame/stagespanel/VBoxContainer").get_children():
		i.set_pressed(false)
	button.set_pressed(true)
	stage = button.get_position_in_parent()
	advancestage()

func advancestage(confirm = false):
	if player != null && confirm == false:
		get_node("TextureFrame/newgame/warn").popup()
		return
	for i in get_tree().get_nodes_in_group('startstage'):
		i.visible = false
	for i in get_node("TextureFrame/newgame/stagespanel/VBoxContainer").get_children():
		if i.get_position_in_parent() > stage && i.get_name() != 'cancel':
			i.set_disabled(true)
			i.set_text(i.get_tooltip())
		else:
			i.set_disabled(false)
			i.set_pressed(false)
	get_node("TextureFrame/newgame/stagespanel/VBoxContainer").get_child(stage).set_pressed(true)
	if stage == 0:
		for i in get_tree().get_nodes_in_group("startoption"):
			i.set_pressed(globals.rules[i.get_name()])
		get_node("TextureFrame/newgame/stage1").visible = true
	elif stage == 1:
		if sandbox == false:
			get_node("TextureFrame/introduction").visible = true
			get_node("TextureFrame/introduction/RichTextLabel").set_bbcode(introtext)
		get_node("TextureFrame/newgame/stage2").visible = true
	elif stage == 2:
		get_node("TextureFrame/newgame/stage3").visible = true
		stage3()
	elif stage == 3:
		get_node("TextureFrame/newgame/stage4").visible = true
		if sandbox == false:
			get_node("TextureFrame/introduction").visible = true
			get_node("TextureFrame/introduction/RichTextLabel").set_bbcode(introtext2)
		stage4()
	elif stage == 4:
		get_node("TextureFrame/newgame/stage5").visible = true
		stage5()
	elif stage == 5:
		globals.player = globals.newslave(currentrace, currentage, currentsex, 'slave')
		player = globals.player
		player.hairstyle = 'straight'
		player.cleartraits()
		player.beautybase = 40
		stage6()
		get_node("TextureFrame/newgame/stage6").visible = true
	elif stage == 6:
		stage7()
		get_node("TextureFrame/newgame/stage7").visible = true
	elif stage == 7:
		startslave = globals.newslave(slavetemplate.race, slavetemplate.age, slavetemplate.sex, 'poor')
		startslave.cleartraits()
		startslave.beautybase = 40
		stage8()
		get_node("TextureFrame/newgame/stage8").visible = true

func optiontoggle(button):
	globals.rules[button.get_name()] = button.is_pressed()

func _on_warnconf_pressed():
	player = null
	advancestage(true)
	get_node("TextureFrame/newgame/warn").visible = false


func _on_warncanc_pressed():
	get_node("TextureFrame/newgame/warn").visible = false

func stage_set(value):
	stage = value
	if stage < 6:
		advancestage()
	else:
		advancestage(true)

func _on_cancel_pressed():
	get_node("TextureFrame/newgame").visible = false
	self.stage = 0
	sandbox = false

func _on_storymode_pressed():
	self.stage = 1
	get_node("TextureFrame/newgame/stagespanel/VBoxContainer/start").set_text("Normal")
	globals.overwritesettings()
	sandbox = false

func _on_sandboxmode_pressed():
	self.stage = 1
	get_node("TextureFrame/newgame/stagespanel/VBoxContainer/start").set_text("Sandbox")
	globals.overwritesettings()
	sandbox = true

func _on_quickstart_pressed():
	currentloc = 'wimborn'
	currentrace = globals.allracesarray[rand_range(0, globals.allracesarray.size())]
	var agearray = ['adult','teen']
	currentage = agearray[rand_range(0,agearray.size())]
	var sexarray = ['male','futanari']
	if globals.rules.futa == false:
		sexarray.erase('futanari')
	currentsex = sexarray[rand_range(0,sexarray.size())]
	var tempbackground = ['mercenary','farmer','noble','mage']
	background = tempbackground[rand_range(0,tempbackground.size())]
	slavetemplate.race = globals.allracesarray[rand_range(0, globals.allracesarray.size())]
	slavetemplate.age = agearray[rand_range(0,agearray.size())]
	slavetemplate.sex = 'random'
	startslave = globals.newslave(slavetemplate.race, slavetemplate.age, slavetemplate.sex, 'poor')
	selectedportrait = portraitarray[randi()%portraitarray.size()]
	startslave.cleartraits()
	_on_slaveconfirm_pressed()
	

func _on_customize_pressed():
	self.stage = 2


func _on_closeintro_pressed():
	get_node("TextureFrame/introduction").visible = false

var locationdict = {
wimborn = {code = 'wimborn', name = 'Wimborn', descript = "Wimborn is the biggest local human city, its rich infrastructure and dense population allows even beginners to make out their living, as long as they are diligent.\n\n[color=aqua][center]Default Start — Recommended.[/center][/color]"},
gorn = {code = 'gorn', name = 'Gorn', descript = "Gorn is the central Orcish city with hot climate and strict ruleship. There's no Mage's Order, but local slave market is never empty."},
frostford = {code = 'frostford', name = 'Frostford', descript = "Frostford, located in cold, northern regions, mostly populated by Beastkin. Despite serene attitude of locals, it's covered in snow most of the time and limiting food sources makes it difficult to survive without reasonable preparations and trustworthy people."},
}
var locationarray = ['wimborn', 'gorn', 'frostford']


func _on_next_pressed():
	var counter = locationarray.find(currentloc)
	if counter + 1 > locationarray.size()-1:
		counter = 0 
	else:
		counter += 1
	var location = locationdict[locationarray[counter]]
	currentloc = location.code
	stage3()

func stage3():
	var location = locationdict[currentloc]
	get_node("TextureFrame/newgame/stage3/cityname").set_text(location.name)
	get_node("TextureFrame/newgame/stage3/locationtext").set_bbcode(location.descript)
	get_node("TextureFrame/newgame/stage3/locimage").set_texture(globals.backgrounds[location.code])


func _on_locconfirm_pressed():
	self.stage = 3
	globals.state.location = currentloc
	get_node("TextureFrame/newgame/stagespanel/VBoxContainer/location").set_text(currentloc.capitalize())

func _on_raceconfirm_pressed():
	get_node("TextureFrame/newgame/stagespanel/VBoxContainer/race").set_text(currentrace)
	self.stage = 4

var playerstr = 4
var playeragi = 4
var playermaf = 4
var playerend = 4
var pointsleft = 2
var playersex = 'male'
var playerage = 'teen'

func stage5():
	get_node("TextureFrame/newgame/stage5/age").clear()
	get_node("TextureFrame/newgame/stage5/sex").clear()
	for i in ['male','female','futanari']:
		if i == 'futanari' && globals.rules.futa == false:
			continue
		get_node("TextureFrame/newgame/stage5/sex").add_item(i)
		if playersex == i:
			get_node("TextureFrame/newgame/stage5/sex").select(get_node("TextureFrame/newgame/stage5/sex").get_item_count()-1)
	for i in ['adult','teen']:
		get_node("TextureFrame/newgame/stage5/age").add_item(i)
		if playerage == i:
			get_node("TextureFrame/newgame/stage5/age").select(get_node("TextureFrame/newgame/stage5/age").get_item_count()-1)
	var text = "[center]Strength: [color=yellow]" + str(playerstr) + "[/color]\nAgility: [color=yellow]" + str(playeragi) + "[/color]\nMagic: [color=yellow]" + str(playermaf) + "[/color]\nEndurance: [color=yellow]"+ str(playerend) + "[/color] \nPoints Left: [color=green]"+str(pointsleft) + "[/color][/center]"
	get_node("TextureFrame/newgame/stage5/stattext").set_bbcode(text)


func _on_sex_item_selected( ID ):
	playersex = get_node("TextureFrame/newgame/stage5/sex").get_item_text(ID)


func _on_age_item_selected( ID ):
	playerage = get_node("TextureFrame/newgame/stage5/age").get_item_text(ID)


func statup(button):
	if pointsleft >= 1:
		if button.get_name() == 'strup' && playerstr < 7:
			playerstr += 1
			pointsleft -= 1
			stage5()
		elif button.get_name() == 'agiup' && playeragi < 7:
			playeragi += 1
			pointsleft -= 1
			stage5()
		elif button.get_name() == 'mafup' && playermaf < 7:
			playermaf += 1
			pointsleft -= 1
			stage5()
		elif button.get_name() == 'endup' && playerend < 7:
			playerend += 1
			pointsleft -= 1
			stage5()

func statdown(button):
	if button.get_name() == 'strdown' && playerstr > 2:
		playerstr -= 1
		pointsleft += 1
		stage5()
	elif button.get_name() == 'agidown' && playeragi > 2:
		playeragi -= 1
		pointsleft += 1
		stage5()
	elif button.get_name() == 'mafdown' && playermaf > 2:
		playermaf -= 1
		pointsleft += 1
		stage5()
	elif button.get_name() == 'enddown' && playerend > 2:
		playerend -= 1
		pointsleft += 1
		stage5()

func _on_sexconfirm_pressed():
	currentage = get_node("TextureFrame/newgame/stage5/age").get_item_text((get_node("TextureFrame/newgame/stage5/age").get_selected())).to_lower()
	currentsex = get_node("TextureFrame/newgame/stage5/sex").get_item_text((get_node("TextureFrame/newgame/stage5/sex").get_selected())).to_lower()
	get_node("TextureFrame/newgame/stagespanel/VBoxContainer/sexage").set_text(currentsex.capitalize() + " " + currentage.capitalize())
	self.stage = 5

var racebonusdict = {
human = {descript = 'Reputation with Wimborn increased'},
elf = {descript = 'Start with +1 Magic Affinity'},
"dark elf" : {descript = 'Start with +1 Agility'},
orc = {descript = 'Reputation with Gorn increased'},
demon = {descript = 'Start with +1 unassigned Skillpoint, all starting reputation lowered slightly'},
beastkin = {descript = 'Reputation with Frostford increased'},
halfkin = {descript = 'All starting reputation increased slightly'},
taurus = {descript = 'Start with +1 Endurance'},
}

func stage4():
	var button = get_node("TextureFrame/newgame/stage4/racecontainer/VBoxContainer/Button")
	var newbutton
	var array
	for i in get_node("TextureFrame/newgame/stage4/racecontainer/VBoxContainer").get_children():
		if i != button:
			i.visible = false
			i.queue_free()
	if sandbox == true:
		array = globals.allracesarray
	else:
		array = globals.starting_pc_races
	for i in array:
		if i.find('Beastkin') >= 0 && globals.rules.furry == false:
			continue
		newbutton = button.duplicate()
		newbutton.visible = true
		get_node("TextureFrame/newgame/stage4/racecontainer/VBoxContainer").add_child(newbutton)
		newbutton.set_text(i.capitalize())
		newbutton.connect("pressed",self,'selectrace',[i, newbutton])



func selectrace(racename, button):
	for i in get_tree().get_nodes_in_group("racebutton"):
		if i != button && i.is_pressed():
			i.set_pressed(false)
	var text = globals.dictionary.getRaceDescription(racename, false)
	if racename.find('Beastkin')>=0:
		racebonus = 'Beastkin'
	elif racename.find('Halfkin')>=0:
		racebonus = 'Halfkin'
	else:
		racebonus = racename
	if racebonusdict.has(racebonus.to_lower()):
		text = "[color=aqua]" + racebonusdict[racebonus.to_lower()].descript + "[/color]\n\n" + text
	get_node("TextureFrame/newgame/stage4/racetext").set_bbcode(text)
	currentrace = racename

var malesizes = ['masculine', 'flat']
var femalesizes = ['flat','small','average','big','huge']

func stage6():
#----------------------------------------------------
	if scalessdict.has(player.race):
		get_node("TextureFrame/newgame/stage6/scalescolor").visible = true
		get_node("TextureFrame/newgame/stage6/furcolor").visible = false
		get_node("TextureFrame/newgame/stage6/featherscolor").visible = false
	elif feathersdict.has(player.race):
		get_node("TextureFrame/newgame/stage6/featherscolor").visible = true
		get_node("TextureFrame/newgame/stage6/scalescolor").visible = false
		get_node("TextureFrame/newgame/stage6/furcolor").visible = false
	else:
		get_node("TextureFrame/newgame/stage6/scalescolor").visible = false
		get_node("TextureFrame/newgame/stage6/furcolor").visible = true
		get_node("TextureFrame/newgame/stage6/featherscolor").visible = false
#--------------------------------------------------------------
	for i in get_tree().get_nodes_in_group("lookline"):
		i.set_text(player[i.get_name()])
	get_node("TextureFrame/newgame/stage6/virgin").set_pressed(player.vagvirgin)
	var text = player.description()
	get_node("TextureFrame/newgame/stage6/chardescript").set_bbcode(text)
	get_node("TextureFrame/newgame/stage6/virgin").set_disabled(!player.vagina)
	for i in get_tree().get_nodes_in_group('lookoption'):
		i.clear()
	var array = []
	if player.sex == 'male':
		array = malesizes
	else:
		array = femalesizes
	for i in array:
		get_node("TextureFrame/newgame/stage6/asssize").add_item(i)
		if player.asssize == i:
			get_node("TextureFrame/newgame/stage6/asssize").select(get_node("TextureFrame/newgame/stage6/asssize").get_item_count()-1)
		get_node("TextureFrame/newgame/stage6/titssize").add_item(i)
		if player.titssize == i:
			get_node("TextureFrame/newgame/stage6/titssize").select(get_node("TextureFrame/newgame/stage6/titssize").get_item_count()-1)
	if player.sex != 'female':
		get_node("TextureFrame/newgame/stage6/penis").set_disabled(false)
		get_node("TextureFrame/newgame/stage6/balls").set_disabled(false)
		for i in ['none','small', 'average', 'big']:
			get_node("TextureFrame/newgame/stage6/penis").add_item(i)
			if player.penis == i:
				get_node("TextureFrame/newgame/stage6/penis").select(get_node("TextureFrame/newgame/stage6/penis").get_item_count()-1)
			get_node("TextureFrame/newgame/stage6/balls").add_item(i)
			if player.balls == i:
				get_node("TextureFrame/newgame/stage6/balls").select(get_node("TextureFrame/newgame/stage6/balls").get_item_count()-1)
	else:
		get_node("TextureFrame/newgame/stage6/penis").set_disabled(true)
		get_node("TextureFrame/newgame/stage6/penis").add_item('none')
		get_node("TextureFrame/newgame/stage6/balls").set_disabled(true)
		get_node("TextureFrame/newgame/stage6/balls").add_item('none')
	for i in globals.heightarray:
		get_node("TextureFrame/newgame/stage6/height").add_item(i)
		if player.height == i:
			get_node("TextureFrame/newgame/stage6/height").select(get_node("TextureFrame/newgame/stage6/height").get_item_count()-1)
	for i in globals.hairlengtharray:
		get_node("TextureFrame/newgame/stage6/hairlength").add_item(i)
		if player.hairlength == i:
			get_node("TextureFrame/newgame/stage6/hairlength").select(get_node("TextureFrame/newgame/stage6/hairlength").get_item_count()-1)
	#SKIN
	if skindict.has(player.race):
		array = skindict[player.race]
	else:
		array = skindict.human
	for i in array:
		get_node("TextureFrame/newgame/stage6/skin").add_item(i)
		if player.skin == i:
			get_node("TextureFrame/newgame/stage6/skin").select(get_node("TextureFrame/newgame/stage6/skin").get_item_count()-1)
	
	#HORNS
	if horndict.has(player.race):
		array = horndict[player.race]
	else:
		array = horndict.human
	for i in array:
		get_node("TextureFrame/newgame/stage6/horns").add_item(i.replace("_", " "))
		if player.horns == i:
			get_node("TextureFrame/newgame/stage6/horns").select(get_node("TextureFrame/newgame/stage6/horns").get_item_count()-1)
	#WINGS
	if wingsdict.has(player.race):
		array = wingsdict[player.race]
	else:
		array = wingsdict.human
	for i in array:
		get_node("TextureFrame/newgame/stage6/wings").add_item(i.replace("_", " "))
#-------------------------------
	#SCALES
	if scalessdict.has(player.race):
		array = scalessdict[player.race]
	else:
		array = []
	for i in array:
		get_node("TextureFrame/newgame/stage6/scalescolor").add_item(i)
		if player.scalescolor == i:
			get_node("TextureFrame/newgame/stage6/scalescolor").select(get_node("TextureFrame/newgame/stage6/scalescolor").get_item_count()-1)

	#FEATHERS
	if feathersdict.has(player.race):
		array = feathersdict[player.race]
	else:
		array = []
	for i in array:
		get_node("TextureFrame/newgame/stage6/featherscolor").add_item(i)
		if player.featherscolor == i:
			get_node("TextureFrame/newgame/stage6/featherscolor").select(get_node("TextureFrame/newgame/stage6/featherscolor").get_item_count()-1)
			if get_node("TextureFrame/newgame/stage6/featherscolor").text != 'none':
				get_node("TextureFrame/newgame/stage6/haircolor").text = i.replace("_", "/")
	#FUR
	if furcolordict.has(player.race.replace('Halfkin', 'Beastkin')):
		array = furcolordict[player.race.replace('Halfkin', 'Beastkin')]
#-------------------------------
	else:
		array = furcolordict.human
	for i in array:
		get_node("TextureFrame/newgame/stage6/furcolor").add_item(i.replace("_", " "))
		if player.furcolor == i:
			get_node("TextureFrame/newgame/stage6/furcolor").select(get_node("TextureFrame/newgame/stage6/furcolor").get_item_count()-1)
#------------------------------
			if get_node("TextureFrame/newgame/stage6/furcolor").text != 'none':
				get_node("TextureFrame/newgame/stage6/haircolor").text = i.replace("_", "/")
#------------------------------	
	get_node("TextureFrame/newgame/stage6/bodyshape").set_disabled(true)
	get_node("TextureFrame/newgame/stage6/bodyshape").add_item(player.bodyshape)
	get_node("TextureFrame/newgame/stage6/ears").set_disabled(true)
	get_node("TextureFrame/newgame/stage6/ears").add_item(player.ears.replace("_", " "))
	get_node("TextureFrame/newgame/stage6/tail").set_disabled(true)
	get_node("TextureFrame/newgame/stage6/tail").add_item(player.tail)
	get_node("TextureFrame/newgame/stage6/penistype").add_item(player.penistype)
	get_node("TextureFrame/newgame/stage6/penistype").set_disabled(true)
	


func optionselect(item,button):
	if !button.get_name() in ['penis','tits']:
		player[button.get_name()] = button.get_item_text(item).replace(" ", "_")
	elif button.get_name() == 'tits':
		player.titssize = button.get_item_text(item)
	elif button.get_name() == 'penis':
		player.penis = button.get_item_text(item)
	stage5change()

var skindict = {
human = [ 'pale', 'fair', 'olive', 'tan', 'brown', 'dark' ],
"Drow" : ['blue', 'purple', 'pale blue'],
"Orc" : ['green'],
"Goblin" : ['green'],
"Dryad" : ['green'],
"Slime" : ['jelly'],
"Nereid" : ['teal', 'blue', 'pale blue']
}
var horndict = {
human = ['none'],
"Demon" : ['short', 'long_straight', 'curved'],
"Dragonkin" : ['short', 'long_straight', 'curved'],
"Taurus" : ['long_straight'],
}
var wingsdict = {
human = ['none'],
"Fairy" : ['insect'],
"Demon" : ['leather_black', 'leather_red'],
"Dragonkin" : ['leather_black', 'leather_red'],
"Seraph" : ['feathered_black', 'feathered_white', 'feathered_brown'],
}
var furcolordict = {
human = ['none'],
"Beastkin Cat" : ['white', 'gray', 'orange_white','black_white','black_gray','black'],
"Beastkin Fox" : ['black_white', 'orange'],
"Beastkin Wolf" : ['gray', 'black_gray', 'brown'],
"Beastkin Bunny" : ['white', 'gray'],
"Beastkin Tanuki" : ['black_gray'],
#-------------------------------------------
"Taurus" : ['white', 'gray', 'orange_white','black_white','black_gray','black'],
"Centaur" : ['white', 'gray', 'orange_white','black_white','black_gray','black'],
}
var feathersdict = {
#human = ['none'],
"Harpy" : ['white', 'green', 'purple', 'blue', 'yellow', 'red', 'brown'],
}
var scalessdict = {
#human = ['none'],
"Dragonkin" : ['blue','red','gold','green','silver','black'],
"Nereid" : ['blue','red','gold','green','silver','black'],
"Arachna" : ['blue','red','gold','green','silver','black'],
"Lamia" : ['blue','red','gold','green','silver','black'],
}
#-------------------------------------------
func stage5change():
	var text = player.description()
	get_node("TextureFrame/newgame/stage6/chardescript").set_bbcode(text)


func _on_lookconfirm_pressed():
	if stage != 7:
		self.stage += 1
	else:
		get_node("TextureFrame/newgame/stage6").visible = false



func looklinetext(text, node):
	player[node.get_name()] = node.get_text()
	stage5change()

func virginpress():
	if player.vagina == 'normal':player.vagvirgin = get_node("TextureFrame/newgame/stage6/virgin").is_pressed()
	stage5change()

func stage7():
	for i in get_node("TextureFrame/newgame/stage7/backgroundcontainer/VBoxContainer").get_children():
		if i != get_node("TextureFrame/newgame/stage7/backgroundcontainer/VBoxContainer/Button"):
			i.visible = false
			i.queue_free()
	for i in backgrounddict.values():
		var newbutton = get_node("TextureFrame/newgame/stage7/backgroundcontainer/VBoxContainer/Button").duplicate()
		get_node("TextureFrame/newgame/stage7/backgroundcontainer/VBoxContainer").add_child(newbutton)
		newbutton.visible = true
		newbutton.set_text(i.name)
		newbutton.set_meta('bg', i)
		newbutton.connect("pressed",self,'selectbackground', [newbutton])

func selectbackground(button):
	for i in get_tree().get_nodes_in_group('bgbutton'):
		if i != button:
			i.set_pressed(false)
	var tempbackground = button.get_meta('bg')
	background = tempbackground.code
	get_node("TextureFrame/newgame/stage7/backgroundtext").set_bbcode(tempbackground.descript)

func _on_backgroundconfirm_pressed():
	if player == null:
		globals.player = globals.newslave(currentrace, currentage, currentsex, 'slave')
		player = globals.player
		player.beautybase = 40
		player.cleartraits()
	player.stats.str_max = playerstr
	player.stats.agi_max = playeragi
	player.stats.maf_max = playermaf
	player.stats.end_max = playerend
	#globals.player = dict2inst(str2var(var2str(inst2dict(player))))
	self.stage += 1



var startslave
var startslavebackground = 'Stranger'
var startslavehobby = 'Physical'
var slavetemplate = {race = 'Human', age = 'adult', sex = 'female'}

func stage8():
	get_node("TextureFrame/newgame/stage8/slaveage").clear()
	get_node("TextureFrame/newgame/stage8/slavesex").clear()
	get_node("TextureFrame/newgame/stage8/slaverace").clear()
	for i in ['female','futanari','male']:
		if i == 'futanari' && globals.rules.futa == false:
			continue
		get_node("TextureFrame/newgame/stage8/slavesex").add_item(i)
		if slavetemplate.sex == i:
			get_node("TextureFrame/newgame/stage8/slavesex").select(get_node("TextureFrame/newgame/stage8/slavesex").get_item_count()-1)
	if sandbox == false:
		for i in globals.starting_pc_races:
			get_node("TextureFrame/newgame/stage8/slaverace").add_item(i)
			if slavetemplate.race == i:
				get_node("TextureFrame/newgame/stage8/slaverace").select(get_node("TextureFrame/newgame/stage8/slaverace").get_item_count()-1)
	else:
		for i in globals.allracesarray:
			get_node("TextureFrame/newgame/stage8/slaverace").add_item(i)
			if slavetemplate.race == i:
				get_node("TextureFrame/newgame/stage8/slaverace").select(get_node("TextureFrame/newgame/stage8/slaverace").get_item_count()-1)
	for i in ['adult','teen','child']:
		if globals.rules.children == false && i == 'child':
			continue
		get_node("TextureFrame/newgame/stage8/slaveage").add_item(i)
		if slavetemplate.age == i:
			get_node("TextureFrame/newgame/stage8/slaveage").select(get_node("TextureFrame/newgame/stage8/slaveage").get_item_count()-1)
	for i in get_node("TextureFrame/newgame/stage8/backgroundcontainer/VBoxContainer").get_children():
		if i != get_node("TextureFrame/newgame/stage8/backgroundcontainer/VBoxContainer/Button"):
			i.visible = false
			i.queue_free()
	for i in get_node("TextureFrame/newgame/stage8/hobbycontainer/VBoxContainer").get_children():
		if i != get_node("TextureFrame/newgame/stage8/hobbycontainer/VBoxContainer/Button"):
			i.visible = false
			i.queue_free()
	for i in ['$sibling', 'Servant','Childhood Friend','Stranger']:
		if !background in ['noble', 'mage'] && i == 'Servant':
			continue
		var newbutton = get_node("TextureFrame/newgame/stage8/backgroundcontainer/VBoxContainer/Button").duplicate()
		newbutton.visible = true
		newbutton.set_meta('bg', i)
		if startslavebackground == i:
			newbutton.set_pressed(true)
		get_node("TextureFrame/newgame/stage8/backgroundcontainer/VBoxContainer").add_child(newbutton)
		if globals.player.race != startslave.race && i == '$sibling':
			newbutton.set_text(startslave.dictionary("Foster "+i).capitalize())
		else:
			newbutton.set_text(startslave.dictionary(i).capitalize())
		newbutton.connect("pressed",self,'slavebackground', [newbutton])
	for i in ['Physical','Etiquete','Magic','Servitude']:
		var newbutton = get_node("TextureFrame/newgame/stage8/hobbycontainer/VBoxContainer/Button").duplicate()
		newbutton.visible = true
		newbutton.set_meta('hobby', i)
		if startslavehobby == i:
			newbutton.set_pressed(true)
		get_node("TextureFrame/newgame/stage8/hobbycontainer/VBoxContainer").add_child(newbutton)
		newbutton.set_text(i)
		newbutton.connect("pressed",self,'slavehobby', [newbutton])
	get_node("TextureFrame/newgame/stage8/slavename").set_text(startslave.name)
	get_node("TextureFrame/newgame/stage8/slavesurname").set_text(startslave.surname)

func slavebackground(button):
	for i in get_tree().get_nodes_in_group("slavebg"):
		if i != button:
			i.set_pressed(false)
		else:
			i.set_pressed(true)
	startslavebackground = button.get_meta('bg')
	get_node("TextureFrame/newgame/stage8/backgroundtext").set_bbcode(startslave.dictionary(backstorydescription[startslavebackground]))
	if startslavebackground == '$sibling':
		startslave.surname = globals.player.surname
		get_node("TextureFrame/newgame/stage8/slavesurname").set_text(startslave.surname)

func slavehobby(button):
	for i in get_tree().get_nodes_in_group("slavehobby"):
		if i != button:
			i.set_pressed(false)
		else:
			i.set_pressed(true)
	startslavehobby = button.get_meta('hobby')
	get_node("TextureFrame/newgame/stage8/backgroundtext").set_bbcode(startslave.dictionary(hobbydescription[startslavehobby]))

func slaveoption(id, button):
	if button.get_name() == 'slaverace':
		slavetemplate.race = button.get_item_text(id)
		get_node("TextureFrame/newgame/stage8/backgroundtext").set_bbcode(globals.dictionary.getRaceDescription(slavetemplate.race, true, true))
	elif button.get_name() == 'slaveage':
		slavetemplate.age = button.get_item_text(id)
	elif button.get_name() == 'slavesex':
		slavetemplate.sex = button.get_item_text(id)
	startslave = globals.newslave(slavetemplate.race, slavetemplate.age, slavetemplate.sex, 'poor')
	startslave.beautybase = 40
	startslave.cleartraits()
	stage8()


func _on_slavefinetune_pressed():
	player = startslave
	get_node("TextureFrame/newgame/stage6").visible = true
	get_node("TextureFrame/newgame/stage6").set_as_toplevel(true)
	stage6()
	stage5change()

func _on_slaveconfirm_pressed():
	#Racebonus
	get_tree().change_scene("res://files/Mansion.scn")
	globals.player.relatives.father = 0
	globals.player.relatives.mother = 0
	globals.player.ability.append('escape')
	globals.player.abilityactive.append('escape')
	globals.player.ability.append("protect")
	globals.player.abilityactive.append("protect")
	globals.player.beautybase = 40
	globals.player.imageportait = selectedportrait
	globals.resources.energy = 100
	globals.resources.day = 1
	globals.guildslaves.wimborn = []
	globals.guildslaves.gorn = []
	globals.guildslaves.frostford = []
	if globals.player.race == 'Elf':
		globals.player.stats.maf_cur += 1
	elif globals.player.race == "Dark Elf":
		globals.player.stats.agi_cur += 1
	elif globals.player.race == 'Orc':
		globals.state.reputation.gorn += 30
	elif globals.player.race == 'Demon':
		for i in globals.state.reputation.values():
			i -= 10
		globals.player.skillpoints += 1
	elif globals.player.race == 'Taurus':
		globals.player.stats.end_cur += 1
	elif globals.player.race.find("Beastkin") >= 0:
		globals.state.reputation.frostford += 30
	elif globals.player.race.find("Halfkin"):
		for i in globals.state.reputation.values():
			i += 15
	else:
		globals.state.reputation.wimborn += 30
	if background == 'mercenary':
		for i in ['armorleather','armorleather','weaponsword','weaponsword']:
			var tempitem = globals.items.createunstackable(i)
			globals.state.unstackables[str(tempitem.id)] = tempitem
	elif background == 'farmer':
		globals.resources.gold += 250
		globals.resources.food += 250
	elif background == 'noble':
		globals.resources.gold += 300
		for i in ['clothmaid','clothmaid']:
			var tempitem = globals.items.createunstackable(i)
			globals.state.unstackables[str(tempitem.id)] = tempitem
	elif background == 'mage':
		globals.spelldict.heal.learned = true
		globals.player.ability.append('heal')
		globals.player.abilityactive.append('heal')
		globals.state.mansionupgrades.mansionalchemy += 1
		var array = ['aphrodisiac','hairgrowthpot','amnesiapot','lactationpot','miscariagepot','stimulantpot','deterrentpot']
		for i in array:
			globals.itemdict[i].unlocked = true
	
	
	for i in ['conf','cour','wit','charm']:
		startslave[i] = rand_range(30,35)
	startslave.memory = startslavebackground
	startslave.obed = 90
	startslave.beautybase = 40
	if startslave.memory.find('$sibling') >= 0:
		startslave.relatives.mother = 0
		startslave.relatives.father = 0
	
	if startslavehobby == 'Physical':
		startslave.cour += 25
		startslave.sstr += 1
	elif startslavehobby == 'Etiquete':
		startslave.conf += 20
		startslave.charm += 15
	elif startslavehobby == 'Magic':
		startslave.wit += 25
		startslave.smaf += 2
	elif startslavehobby == 'Servitude':
		startslave.send += 1
		startslave.loyal += 20
		startslave.stats.obed_min += 35
	
	globals.slaves = startslave
	
	
	if sandbox == false:
		globals.resources.upgradepoints = 5
		globals.resources.gold += 250
		globals.resources.food += 200
		globals.resources.mana += 10
	else:
		for i in globals.state.portals.values():
			if i.code != currentloc:
				i.enabled = true
		globals.resources.upgradepoints = 30
		globals.resources.gold += 5000
		globals.resources.food += 500
		globals.resources.mana += 100
		globals.state.mainquest = 17
		globals.state.rank = 4
		globals.state.sidequests.brothel = 2
		globals.state.branding = 2
		globals.state.farm = 4
		globals.state.portals.amberguard.enabled = true
		globals.itemdict.youthingpot.unlocked = true
		globals.itemdict.maturingpot.unlocked = true
		globals.state.sidequests.sebastianumbra = 2
		globals.state.portals.umbra.enabled = true
	

var backstorydescription = {
'$sibling' : 'After the news about your fortune, your $sibling asked to go with you offering $his help. You never quite could refuse $name and so you went with $him. ',
"Childhood Friend" : "It wasn't easy to keep your good old friend, $name calm when $he heard you are leaving your home town. In the end you found no better solution, than to take $him with you. ",
"Servant" : "As traveling on your own might be dangerous, you decided to take your trusted servant, $name, who's been around for all your childhood and proven to be very dependable. ",
"Stranger" : "On your way to the mansion, you've encountered a lone person, who somehow tagged along with you. "
}

var hobbydescription = {
'Physical' : '[color=aqua]Strength: +1; +Courage[/color]\n\n$name is no stranger to fighting and tends to act boldly in many situations. ',
'Etiquete' : "[color=aqua]+Confidence, +Charm[/color]\n\n$name has spent $his youth among elder people and high society, learning how to be liked and present $himself while also feeling superior to commonfolk. ",
'Magic' : "[color=aqua]Magic: +2; +Wit[/color]\n\n$name was a very curious child and spent a lot of $his time reading and studying various things, including magic.",
'Servitude' : "[color=aqua]Endurance: +1; +Obedience[/color]\n\n$name has spent $his youth in harsh training which lead to $him being more physically fit and respecting to $his superiors."
}


var backgrounddict = {
mercenary = {code = 'mercenary', name = "Mercenary", descript = "After spending your early days as a recruit and soldier for the local governor, you eventually left for better opportunities and new experience. After spending few years being a sellsword with limited opportunities, given lack of local conflicts, the news about your inheritance reached your ears and you decided, that at the very least new career option should be less of a hassle. \n\n[color=aqua]Start with 2 Leather Armors and 2 Swords[/color]"},
farmer = {code = 'farmer', name = "Farmer", descript = "Your childhood has been spent on the family farm. After your father died, there was little option but to take his place and start taking care of it. Upon hearing news of your newfound inheritance, you being fed up with the rural routine and sold your possessions, and moved onto your new life. \n\n[color=aqua]Start with extra 250 gold and 250 food. [/color]"},
noble = {code = 'noble', name = "Aristocrat", descript = "You were born a member of small and fairly poor aristocrat family. Despite having a relatively reasonable life, your home estate was constantly in danger from your overly ambitious relatives and strong neighbours. After you have found out about your inheritance, you decided to leave everything to your older brother and, with what small possessions you've kept, moved to find out if you can pick up a new opportunity entirely on your own. \n\n[color=aqua]Start with extra 300 gold and 2 Maid Uniforms.[/color] "},
mage = {code = 'mage', name = "Researcher", descript = "Despite being born in a poor family, you've always shown a profound interest in complex subjects such as alchemy and magic. Thankfully, you've managed to enroll into small local school which gave you a significant opportunities by sharing their resources. After news about your inheritance reached you, it was a chance you couldn't let slip: you quickly packed your most valuable tools and moved out. \n\n[color=aqua]Start with an Alchemy Room and a Heal spell. [/color]"},
}






var portraitarray = []
var selectedportrait = ''

func buildportraitarray():
	var files = globals.dir_contents("res://files/buttons/portraits")
	for i in files:
		if i.find('import') >= 0:
			portraitarray.append(i.replace('.import',''))
	selectedportrait = portraitarray[0]

func _on_nextport_pressed():
	var foundtexture
	var currtexture = portraitarray.find($TextureFrame/newgame/stage4/portrait.texture.get_path())
	if portraitarray.size() > currtexture+1:
		foundtexture = load(portraitarray[currtexture + 1])
	else:
		foundtexture = load(portraitarray[0])
	$TextureFrame/newgame/stage4/portrait.texture = foundtexture
	selectedportrait = foundtexture.get_path()


func _on_prevport_pressed():
	var foundtexture
	var currtexture = portraitarray.find($TextureFrame/newgame/stage4/portrait.texture.get_path())
	if currtexture != 0:
		foundtexture = load(portraitarray[currtexture - 1])
	else:
		foundtexture = load(portraitarray.back())
	$TextureFrame/newgame/stage4/portrait.texture = foundtexture
	selectedportrait = foundtexture.get_path()

var tempvariables

func _on_constants_pressed():
	$TextureFrame/constants.visible = true
	for i in $TextureFrame/constants/ScrollContainer/VBoxContainer.get_children():
		if i.name != 'Label':
			i.visible = false
			i.queue_free()
	for i in variables.list:
		var newnode = $TextureFrame/constants/ScrollContainer/VBoxContainer/Label.duplicate()
		$TextureFrame/constants/ScrollContainer/VBoxContainer.add_child(newnode)
		newnode.visible = true
		newnode.set_meta('var', i)
		newnode.set_text(i)
		newnode.hint_tooltip = variables.list[i].descript
		newnode.get_node("LineEdit").text = str(variables[i])
		newnode.get_node("LineEdit").hint_tooltip = "default: " + str(variables.list[i].default) + ", min: " + str(variables.list[i].min) + ", max: " + str(variables.list[i].max) 
	


func _on_closeconstants_pressed():
	$TextureFrame/constants.visible = false


func _on_resetconstants_pressed():
	for i in variables.list:
		variables[i] = variables.list[i].default
	globals.savevars()
	_on_constants_pressed()


func _on_confirmconstants_pressed():
	for i in $TextureFrame/constants/ScrollContainer/VBoxContainer.get_children():
		if i.has_meta('var'):
			var vari = i.get_meta('var')
			variables[vari] = clamp(float(i.get_node("LineEdit").text), variables.list[vari].min, variables.list[vari].max)
	globals.savevars()
	_on_constants_pressed()


#--------------------------------------------------------
func _on_chardescript_meta_clicked(meta):
	if globals.state.descriptsettings.has(meta):
		globals.state.descriptsettings[meta] = !globals.state.descriptsettings[meta]
		stage6()
		
func _on_furcolor_item_selected(id):
	if get_node("TextureFrame/newgame/stage6/furcolor").text != 'none':
		get_node("TextureFrame/newgame/stage6/haircolor").text = get_node("TextureFrame/newgame/stage6/furcolor").text.replace(" ", "/")
	
func _on_featherscolor_item_selected(id):
	if get_node("TextureFrame/newgame/stage6/featherscolor").text != 'none':
		get_node("TextureFrame/newgame/stage6/haircolor").text = get_node("TextureFrame/newgame/stage6/featherscolor").text.replace(" ", "/")
	
#--------------------------------------------------------