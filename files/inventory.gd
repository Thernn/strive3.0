extends Node

var state
var location = 'mansion'
var selectedslave

var categories = {everything = true, potion = false, ingredient = false, gear = false, supply = false}
onready var itemgrid = get_node("ScrollContainer/GridContainer")

var shades = {
arachna = {male = load("res://files/buttons/inventory/shades/Arachna_M.png"), female = load("res://files/buttons/inventory/shades/Arachna_F.png")},
bunny = {male = load("res://files/buttons/inventory/shades/Beastkin-Bunny_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Bunny_F.png")},
cat = {male = load("res://files/buttons/inventory/shades/Beastkin-Cat_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Cat_F.png")},
fox = {male = load("res://files/buttons/inventory/shades/Beastkin-Fox_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Fox_F.png")},
tanuki = {male = load("res://files/buttons/inventory/shades/Beastkin-Tanuki_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Tanuki_F.png")},
wolf = {male = load("res://files/buttons/inventory/shades/Beastkin-Wolf_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Wolf_F.png")},
centaur = {male = load("res://files/buttons/inventory/shades/Centaur_M.png"), female = load("res://files/buttons/inventory/shades/Centaur_F.png")},
demon = {male = load("res://files/buttons/inventory/shades/Demon_M.png"), female = load("res://files/buttons/inventory/shades/Demon_F.png")},
dragonkin = {male = load("res://files/buttons/inventory/shades/Dragonkin_M.png"), female = load("res://files/buttons/inventory/shades/Dragonkin_F.png")},
dryad = {male = load("res://files/buttons/inventory/shades/Dryad_M.png"), female = load("res://files/buttons/inventory/shades/Dryad_F.png")},
elf = {male = load("res://files/buttons/inventory/shades/Elf_M.png"), female = load("res://files/buttons/inventory/shades/Elf_F.png")},
fairy = {male = load("res://files/buttons/inventory/shades/Fairy_M.png"), female = load("res://files/buttons/inventory/shades/Fairy_F.png")},
gnome = {male = load("res://files/buttons/inventory/shades/Gnome_M.png"), female = load("res://files/buttons/inventory/shades/Gnome_F.png")},
goblin = {male = load("res://files/buttons/inventory/shades/Goblin_M.png"), female = load("res://files/buttons/inventory/shades/Goblin_F.png")},
harpy = {male = load("res://files/buttons/inventory/shades/Harpy_M.png"), female = load("res://files/buttons/inventory/shades/Harpy_F.png")},
human = {male = load("res://files/buttons/inventory/shades/Human_M.png"), female = load("res://files/buttons/inventory/shades/Human_F.png")},
lamia = {male = load("res://files/buttons/inventory/shades/Lamia_M.png"), female = load("res://files/buttons/inventory/shades/Lamia_F.png")},
nereid = {male = load("res://files/buttons/inventory/shades/Nereid_M.png"), female = load("res://files/buttons/inventory/shades/Nereid_F.png")},
scylla = {male = load("res://files/buttons/inventory/shades/Scylla_M.png"), female = load("res://files/buttons/inventory/shades/Scylla_F.png")},
seraph = {male = load("res://files/buttons/inventory/shades/Seraph_M.png"), female = load("res://files/buttons/inventory/shades/Seraph_F.png")},
slime = {male = load("res://files/buttons/inventory/shades/Slime_M.png"), female = load("res://files/buttons/inventory/shades/Slime_F.png")},
taurus = {male = load("res://files/buttons/inventory/shades/Taurus_M.png"), female = load("res://files/buttons/inventory/shades/Taurus_F.png")},
orc = {male = load("res://files/buttons/inventory/shades/Orc_-M.png"), female = load("res://files/buttons/inventory/shades/Orc_F.png")},

}


#,'weaponclaymore','clothpet','clothkimono','underwearlacy','weaponaynerisrapier'
func _ready():
#	var i = 3
#	if globals.player.name == '':
#		globals.player = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'random', 'random')
#		while i > 0:
#			i -= 1
#			var person = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'random', 'random')
#			globals.slaves = person
	
	
#	for i in globals.itemdict.values():
#		i.unlocked = true
#		if !i.type in ['gear','dummy']:
#			i.amount += 10
#	for i in ['armorchain','armorchain','armorchain','armorchain','armorchain']:
#		var tmpitem = globals.items.createunstackable(i)
#		globals.items.enchantrand(tmpitem)
#		globals.state.unstackables[str(tmpitem.id)] = tmpitem
	
	
	
	for i in ['costume','weapon','armor','accessory','underwear']:
		get_node("gearpanel/" + i).connect("pressed", self, 'gearinfo', [i])
		get_node("gearpanel/" + i + "/unequip").connect("pressed", self, 'unequip', [i])
	
	for i in get_tree().get_nodes_in_group("invcategory"):
		i.connect("pressed",self,'selectcategory',[i])
	
#	open()



func selectcategory(button):
	if button.get_name() == 'everything':
		for i in get_tree().get_nodes_in_group('invcategory'):
			i.set_pressed(i == button)
	else:
		categories.everything = false
		get_node("everything").set_pressed(false)
	for i in categories:
		categories[i] = get_node(i).is_pressed()
	categoryitems()

func categoryitems():
	for i in get_node("ScrollContainer/GridContainer/").get_children():
		if (categories.everything == true && i.get_name() != 'Button' )|| (i.has_meta('category') && categories[i.get_meta('category')] == true):
			i.visible = true
		else:
			i.visible = false

func gearinfo(gear):
	if selectedslave != null && selectedslave.gear[gear] != null:
		var item = globals.state.unstackables[selectedslave.gear[gear]]
		get_node("iteminfo/RichTextLabel").set_bbcode(globals.itemdescription(item))
		get_node("iteminfo/TextureFrame").set_texture(load(item.icon))
		get_node("iteminfo").popup()

func unequip(gear):
	var item = globals.state.unstackables[selectedslave.gear[gear]]
	if selectedslave != null && selectedslave.gear[gear] != null:
		globals.items.person = selectedslave
		if location == 'mansion':
			item.owner = null
		else:
			item.owner = 'backpack'
		for i in item.effects:
			if i.type == 'onequip':
				globals.items.call(i.effect, -i.effectvalue)
		selectedslave.gear[gear] = null
		slavegear(selectedslave)
		updateitems()

func open(place = 'mansion', part = 'inventory', keepslave = false):
	
	location = place
	state = part
	if keepslave == false:
		selectedslave = null
	if selectedslave == null:
		get_node("gearpanel").visible = false
	updateitems()
	calculateweight()
	slavelist()
	
	self.visible = true

func updateitems():
	clearitems()
	if state == 'inventory':
		itemsinventory()
	elif state == 'backpack':
		itemsbackpack()
	categoryitems()

var modetextures = {inventory = load("res://files/buttons/inventory/12_chest.png"), backpack = load("res://files/buttons/inventory/13_bag.png")}

func _on_mode_pressed():
	if state == 'inventory':
		open('mansion','backpack',true)
	else:
		open('mansion','inventory',true)
	get_node("mode").set_normal_texture(modetextures[state])

func clearitems():
	for i in itemgrid.get_children():
		if i.get_name() != "Button":
			i.visible = false
			i.queue_free()
	itemgrid.rect_size = itemgrid.rect_min_size


func itemsinventory():
	
	var button
	var array = []
	var tempitem
	
	for i in globals.itemdict.values():
		if i.amount < 1 || i.type in ['gear','dummy']:
			continue
		array.append(i)
	array.sort_custom(globals.items,'sortitems')
	
	for i in array:
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		button.visible = true
		button.get_node('number').set_text(str(i.amount))
		button.get_node("Label").set_text(i.name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movetobackpack',[button])
		if i.type != 'potion':
			button.get_node("use").visible = false
		else:
			button.get_node("use").connect("pressed",self,'use',[button])
		button.set_meta('item', i)
		button.set_meta("number", i.amount)
		button.set_meta("category", i.type)
		if i.icon != null:
			button.get_node("icon").set_texture(i.icon)
		itemgrid.add_child(button)
	array.clear()
		
	for i in globals.state.unstackables.values():
		if (i.owner != null && str(i.owner) != 'backpack') && globals.state.findslave(i.owner) == null && str(i.owner) != globals.player.id:
			i.owner = null
		if i.owner != null:
			continue
		var entryexists = false
		for k in array:
			if k.size() > 0 && k[0].code == i.code && str(k[0].effects) == str(i.effects) :
				k.append(i)
				entryexists = true
				break
		if entryexists == false:
			array.append([])
			array[array.size()-1].append(i)
		
	for i in array:
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		button.visible = true
		button.get_node('number').set_text(str(i.size()))
		button.get_node("Label").set_text(i[0].name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movetobackpack',[button])
		button.get_node("use").connect("pressed",self,'use',[button])
		button.get_node("use").set_tooltip("Equip")
		button.set_meta('item', i[0])
		button.set_meta("itemarray", i)
		button.set_meta("number", i.size())
		button.set_meta("category", 'gear')
		if i[0].enchant == 'basic':
			button.get_node("Label").set('custom_colors/font_color', Color(0,0.5,0))
		elif i[0].enchant == 'unique':
			button.get_node("Label").set('custom_colors/font_color', Color(0.6,0.4,0))
		if i[0].icon != null:
			button.get_node("icon").set_texture(load(i[0].icon))
		itemgrid.add_child(button)

func itemsbackpack():
	var itemgrid = get_node("ScrollContainer/GridContainer")
	var button
	var array = []
	var items = false
	var tempitem
	for i in globals.state.backpack.stackables:
		tempitem = globals.itemdict[i]
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		get_node("ScrollContainer/GridContainer").add_child(button)
		button.visible = true
		button.get_node("Label").set_text(tempitem.name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movefrombackpack',[button])
		button.get_node("number").set_text(str(globals.state.backpack.stackables[i]))
		if tempitem.type != 'potion':
			button.get_node("use").visible = false
		else:
			button.get_node("use").connect("pressed",self,'use',[button])
		if tempitem.icon != null:
			button.get_node("icon").set_texture(tempitem.icon)
		button.set_meta("item", tempitem)
		button.set_meta("category", tempitem.type)
	array.clear()
	for i in globals.state.unstackables.values():
		if (i.owner != null && str(i.owner) != 'backpack') && globals.state.findslave(i.owner) == null && str(i.owner) != globals.player.id:
			i.owner = null
		if str(i.owner) != 'backpack':
			continue
		var entryexists = false
		for k in array:
			if k.size() > 0 && k[0].code == i.code && str(k[0].effects) == str(i.effects) :
				k.append(i)
				entryexists = true
				break
		if entryexists == false:
			array.append([])
			array[array.size()-1].append(i)
	
	for i in array:
		
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		button.visible = true
		button.get_node('number').set_text(str(i.size()))
		button.get_node("Label").set_text(i[0].name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movefrombackpack',[button])
		button.get_node("use").connect("pressed",self,'use',[button])
		button.get_node("use").set_tooltip("Equip")
		button.set_meta('item', i[0])
		button.set_meta("itemarray", i)
		button.set_meta("number", i.size())
		button.set_meta("category", 'gear')
		if i[0].enchant != '':
			button.get_node("Label").set('custom_colors/font_color', Color(0,0.5,0))
		if i[0].icon != null:
			button.get_node("icon").set_texture(load(i[0].icon))
		get_node("ScrollContainer/GridContainer").add_child(button)


func slavelist():
	var button
	for i in get_node("slavelist/GridContainer").get_children():
		if i.get_name() != 'Button':
			i.visible = false
			i.queue_free()
	$slavelist/GridContainer.rect_size = $slavelist/GridContainer.rect_min_size
	for i in [globals.player] + globals.slaves:
		if i.away.duration != 0:
			continue
		button = get_node("slavelist/GridContainer/Button").duplicate()
		get_node("slavelist/GridContainer").add_child(button)
		button.visible = true
		var text = i.name_long() + " [color=yellow]" + i.race + "[/color]"
		if i == globals.player:
			text += " [color=aqua]Master[/color]"
		else:
			text += " " + i.origins.capitalize()
		button.get_node("name").set_bbcode(text)
		button.get_node("hpbar").set_value(float((i.stats.health_cur)/float(i.stats.health_max))*100)
		button.get_node("enbar").set_value(float((i.stats.energy_cur)/float(i.stats.energy_max))*100)
		if i.imageportait != null:
			button.get_node("portrait").set_texture(globals.loadimage(i.imageportait))
		for k in ['sstr','sagi','smaf','send']:
			button.get_node(k).set_text(str(i[k])+ "/" +str(min(i.stats[globals.maxstatdict[k]], i.originvalue[i.origins])))
		button.connect("pressed",self,'selectslave',[button])
		button.pressed = i==selectedslave
		button.set_meta('person', i)

func selectbuttonslave(person):
	for i in $slavelist/GridContainer.get_children():
		if i.has_meta('person') && i.get_meta('person') == person:
			selectslave(i)
			return

func selectslave(button):
	var person = button.get_meta('person')
	selectedslave = person
	for i in get_tree().get_nodes_in_group("inventoryslaves"):
		i.set_pressed(i == button)
	slavegear(person)

var sil = {costume = load("res://files/buttons/inventory/25.png"), underwear = load("res://files/buttons/inventory/26.png"), accessory = load("res://files/buttons/inventory/27.png"), weapon = load("res://files/buttons/inventory/29.png"), armor = load("res://files/buttons/inventory/28.png")}

func slavegear(person):
	var text = ''
	text += "Health: " + str(person.health) + "/" + str(person.stats.health_max) + '\nEnergy: ' + str(person.energy) + '/' + str(person.stats.energy_max) + '\n'
	for i in person.gear:
		if person.gear[i] == null:
			continue
		if globals.state.unstackables.has(person.gear[i]) == false:
			person.gear[i] = null
			continue
		var tempitem = globals.state.unstackables[person.gear[i]]
		for k in tempitem.effects:
			text += k.descript + "\n"
	get_node("gearpanel/RichTextLabel").set_bbcode(text)
	get_node("gearpanel").visible = true
	var sex
	var race
	sex = person.sex.replace('futanari','female')
	race = person.race.replace("Beastkin ",'').replace("Halfkin ", '').to_lower()
	if race in ['dark elf', 'drow']:
		race = 'elf'
	get_node("gearpanel/charframe").set_texture(shades[race][sex])
	
	
	for i in ['weapon','costume','underwear','armor','accessory']:
		if person.gear[i] == null:
			get_node("gearpanel/"+i+"/unequip").visible = false
			get_node("gearpanel/"+i+"/enchant").visible = false
			get_node("gearpanel/"+i).set_normal_texture(sil[i])
		else:
			get_node("gearpanel/"+i+"/unequip").visible = true
			get_node("gearpanel/"+i).set_normal_texture(load(globals.state.unstackables[person.gear[i]].icon))
			get_node("gearpanel/"+i+"/enchant").visible = globals.state.unstackables[person.gear[i]].enchant != ''

func use(button):
	if selectedslave == null:
		get_tree().get_current_scene().infotext("No person selected")
		return
	var item = button.get_meta('item')
	var tempitem
	var person = selectedslave
	globals.items.person = person
	if item.code in ['aphrodisiac', 'regressionpot', 'miscariagepot','amnesiapot','stimulantpot','deterrentpot'] && person == globals.player:
		get_parent().popup(person.dictionary(globals.items.call(item.effect)))
		return
	if item.type == 'potion':
		person.metrics.item += 1
		if !item.code in ['minoruspot', 'majoruspot', 'hairdye', 'amnesiapot']:
			get_tree().get_current_scene().popup(person.dictionary(globals.items.call(item.effect)))
			person.toxicity += item.toxicity
			if state == 'backpack':
				globals.state.backpack.stackables[item.code] -= 1
			else:
				item.amount -= 1
		else:
			call(item.effect)
		if state == 'backpack':
			button.get_node('number').set_text(str(globals.state.backpack.stackables[item.code]))
			if globals.state.backpack.stackables[item.code] <= 0:
				globals.state.backpack.stackables.erase(item.code)
				button.visible = false
				button.queue_free()
		else:
			button.get_node('number').set_text(str(item.amount))
			if item.amount <= 0:
				button.visible = false
				button.queue_free()
	else:
		if item.reqs != null:
			if globals.items.checkreqs(item) == false:
				get_parent().infotext(person.dictionary("$name does not pass the requirements for ") + item.name, 'red')
				return
		if person.gear[item.type] != null:
			tempitem = globals.state.unstackables[person.gear[item.type]]
			for i in tempitem.effects:
				if i.type == 'onequip':
					globals.items.call(i.effect, -i.effectvalue)
			tempitem.owner = null
		person.gear[item.type] = item.id
		item.owner = person.id
		for i in item.effects:
			if i.type == 'onequip':
				globals.items.call(i.effect, i.effectvalue)
		var itemarray = button.get_meta('itemarray')
		itemarray.erase(item)
		button.get_node('number').set_text(str(itemarray.size()))
		if itemarray.size() <= 0:
			button.visible = false
			button.queue_free()
		updateitems()
		calculateweight()
		slavegear(person)

func info(button):
	get_node("iteminfo/RichTextLabel").set_bbcode(globals.itemdescription(button.get_meta('item')))
	get_node("iteminfo/TextureFrame").set_texture(button.get_node('icon').get_texture())
	get_node("iteminfo").popup()

func discard(button):
	var item = button.get_meta('item')
	if state == 'inventory' or (item.has('owner') && item.owner != null):
		if item.has('id'):
			var itemarray = button.get_meta('itemarray')
			var tempitem = itemarray[itemarray.size()-1]
			globals.state.unstackables.erase(tempitem.id)
			itemarray.erase(tempitem)
			button.get_node('number').set_text(str(itemarray.size()))
			if itemarray.size() <= 0:
				button.visible = false
				button.queue_free()
			calculateweight()
		else:
			item.amount -= 1
			button.get_node('number').set_text(str(item.amount))
			if item.amount <= 0:
				button.visible = false
				button.queue_free()
	elif state == 'backpack':
		globals.state.backpack.stackables[item.code] -= 1
		button.get_node('number').set_text(str(globals.state.backpack.stackables[item.code]))
		if globals.state.backpack.stackables[item.code] <= 0:
			globals.state.backpack.stackables.erase(item.code)
			button.visible = false
		calculateweight()

func movetobackpack(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		item.amount -= 1
		if globals.state.backpack.stackables.has(item.code):
			globals.state.backpack.stackables[item.code] += 1
		else:
			globals.state.backpack.stackables[item.code] = 1
		button.get_node('number').set_text(str(item.amount))
		if item.amount <= 0:
			button.visible = false
			button.queue_free()
	else:
		var itemarray = button.get_meta('itemarray')
		var tempitem = itemarray[itemarray.size()-1]
		itemarray.erase(tempitem)
		button.get_node('number').set_text(str(itemarray.size()))
		tempitem.owner = 'backpack'
		if itemarray.size() <= 0:
			button.visible = false
			button.queue_free()
		#globals.state.backpack.unstackables.append(tempitem)
		#globals.state.unstackables.erase(tempitem.id)
	calculateweight()

func movefrombackpack(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		item.amount += 1
		globals.state.backpack.stackables[item.code] -= 1
		button.get_node('number').set_text(str(globals.state.backpack.stackables[item.code]))
		if globals.state.backpack.stackables[item.code] <= 0:
			globals.state.backpack.stackables.erase(item.code)
			button.visible = false
			button.queue_free()
	else:
		var itemarray = button.get_meta('itemarray')
		var tempitem = itemarray[itemarray.size()-1]
		itemarray.erase(tempitem)
		button.get_node('number').set_text(str(itemarray.size()))
		tempitem.owner = null
		if itemarray.size() <= 0:
			button.visible = false
			button.queue_free()
		
		
#		globals.state.unstackables[str(item.id)].owner = null
#		button.visible = false
#		globals.state.backpack.unstackables.erase(item)
	calculateweight()



func calculateweight():
	var weight = globals.state.calculateweight()
	get_node("weightmeter/Label").set_text("Weight: " + str(weight.currentweight) + '/' + str(weight.maxweight))
	get_node("weightmeter").set_value((weight.currentweight*10/max(weight.maxweight,1)*10))


func _on_iteminfo_input_event( ev ):
	if ev.is_action("LMB") && ev.is_pressed():
		get_node("iteminfo").visible = false


func hairdyeeffect():
	get_node("hairchange").popup()
	get_node("hairchange/TextEdit").clear()

func _on_inventoryclose_pressed():
	self.visible = false
	if get_parent().get_node("MainScreen/slave_tab").visible:
		get_parent().get_node("MainScreen/slave_tab").slavetabopen()


func _on_haircancel_pressed():
	get_node("hairchange").visible = false


func _on_hairconfirm_pressed():
	if get_node("hairchange/TextEdit").get_text() == '':
		get_tree().get_current_scene().infotext("Please enter desired hair color")
		return
	if state == 'inventory':
		globals.itemdict.hairdye.amount -= 1
	elif state == 'backpack':
		globals.state.backpack.hairdye -= 1
		if globals.state.backpack.hairdye <= 1:
			globals.state.backpack.erase('hairdye')
	selectedslave.haircolor = get_node("hairchange/TextEdit").get_text()
	updateitems()
	get_node("hairchange").visible = false

var currentpotion

func minoruseffect():
	var buttons = []
	var text = ''
	currentpotion = 'minoruspot'
	if selectedslave == globals.player:
		text = (selectedslave.dictionary('Choose where would you like to apply Minorus Potion on yourself?'))
	else:
		text = (selectedslave.dictionary('Choose where would you like to apply Minorus Potion on $name?'))
	if selectedslave.asssize != 'flat' && selectedslave.asssize != 'masculine':
		buttons.append(['Butt','applybutt'])
	if selectedslave.titssize != 'flat' && selectedslave.titssize != 'masculine':
		buttons.append(['Breasts','applytits'])
	if !selectedslave.penis in ['none','small']:
		buttons.append(['Penis','applypenis'])
	if selectedslave.balls != 'none' && selectedslave.balls != 'small':
		buttons.append(['Testicles','applytestic'])
	globals.main.dialogue(true, self, text, buttons)

func majoruseffect():
	var buttons = []
	var text = ''
	currentpotion = 'majoruspot'
	if selectedslave == globals.player:
		text = (selectedslave.dictionary('Choose where would you like to apply Majorus Potion on yourself?'))
	else:
		text = (selectedslave.dictionary('Choose where would you like to apply Majorus Potion on $name?'))
	if selectedslave.asssize != 'huge':
		buttons.append(['Butt','applybutt'])
	if selectedslave.titssize != 'huge':
		buttons.append(['Breasts','applytits'])
	if selectedslave.penis != 'big' && selectedslave.penis != 'none':
		buttons.append(['Penis','applypenis'])
	if selectedslave.balls != 'big' && selectedslave.balls != 'none':
		buttons.append(['Testicles','applytestic'])
	globals.main.dialogue(true, self, text, buttons)



func applybutt():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.asssize = globals.sizearray[globals.sizearray.find(selectedslave.asssize)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your butt. A little while later, you notice that it has shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's butt. A little while later, you notice that it has shrunken in size. ")
	elif currentpotion == 'majoruspot':
		if selectedslave.asssize == 'masculine':
			selectedslave.asssize = globals.sizearray[globals.sizearray.find(selectedslave.asssize)+2]
		else:
			selectedslave.asssize = globals.sizearray[globals.sizearray.find(selectedslave.asssize)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your butt. A little while later, you notice that it has grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's butt. A little while later, you notice that it has grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	globals.main.popup(text)
	updateitems()

func applytits():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.titssize = globals.sizearray[globals.sizearray.find(selectedslave.titssize)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your breasts. A little while later, you notice that they have shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's breasts. A little while later, you notice that they have shrunken in size. ")
	elif currentpotion == 'majoruspot':
		if selectedslave.titssize == 'masculine':
			selectedslave.titssize = globals.sizearray[globals.sizearray.find(selectedslave.titssize)+2]
		else:
			selectedslave.titssize = globals.sizearray[globals.sizearray.find(selectedslave.titssize)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your breasts. A little while later, you notice that they have grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's breasts. A little while later, you notice that they have grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	updateitems()
	globals.main.popup(text)

func applypenis():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.penis = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.penis)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your penis. A little while later, you notice that it has shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's penis. A little while later, you notice that it has shrunken in size. ")
	elif currentpotion == 'majoruspot':
		selectedslave.penis = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.penis)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your penis. A little while later, you notice that it has grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's penis. A little while later, you notice that it has grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	updateitems()
	globals.main.popup(text)

func applytestic():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.balls = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.balls)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your balls. A little while later, you notice that they have shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's balls. A little while later, you notice that they have shrunken in size. ")
	elif currentpotion == 'majoruspot':
		selectedslave.balls = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.balls)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your balls. A little while later, you notice that they have grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's balls. A little while later, you notice that they have grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	updateitems()
	globals.main.popup(text)

#
#func get_drag_data(pos):
#	# Use another colorpicker as drag preview
#	var cpb = ColorPickerButton.new()
#	cpb.color = color
#	cpb.rect_size = Vector2(50, 50)
#	set_drag_preview(cpb)
#	# Return color as drag data
#	return color
#
#
#func can_drop_data(pos, data):
#	return typeof(data) == TYPE_COLOR
#
#
#func drop_data(pos, data):
#	color=data


func amnesiapoteffect():
	var text = 'After chugging down the Amnesia Potion, $name looks lightheaded and confused. "W-what was that? I feel like I have forgotten something..." $He is lost, unable to recall the memories of the time before $his confinement as your servant. '
	if selectedslave.effects.has('captured'):
		selectedslave.add_effect(globals.effectdict.captured, true)
		text = text + 'Memories from before $his confinement no longer influence $him to resist you. '
	if selectedslave.loyal < 50 && selectedslave.memory != 'clear':
		text = text + "$He grows closer to you, having no one else $he can rely on. "
		selectedslave.loyal += rand_range(15,25) - selectedslave.conf/10
	text += "\n\nYou can choose new name for $name."
	currentpotion = 'amnesiapot'
	selectedslave.memory = 'clear'
	selectedslave.toxicity += 25
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	updateitems()
	$amnesia.visible = true
	$amnesia/name.text = selectedslave.name
	$amnesia/surname.text = selectedslave.surname
	$amnesia/RichTextLabel.bbcode_text = selectedslave.dictionary(text)

func _on_amnesiaconf_pressed():
	$amnesia.visible = false
	selectedslave.name = $amnesia/name.text
	selectedslave.surname = $amnesia/surname.text
	slavelist()
