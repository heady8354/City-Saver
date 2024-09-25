extends Node2D
var text1 = "Alrighty, welcome to New Medival Chickonville."
var text2 = "This city was one of the last to develop into modern society and they just got carried away with industrialization."
var text3 = "They get all of their resources impoorted from neighboring cities, so there are no local factories here."
var text4 = "However, like I said, they got carried away."
var text5 = "So much so that they dont have reliable transportation for less fortunate individuals."
var text6 = "That is ONE of their many issues."
var text7 = "Im not sure if you can tell from up there but, their grass and crap are all fake."
var text8 =  "Anyways I am getting carried away."
var text9 = "Your objective for this city is to provide reliable transportation to the citiens, and if youre a real sweetheart you can give them some real grass."
var text10 = "Also, your economy is very poor. I would reccommend building shops first to build your economy."
var text11 = "I have asked my higher ranks to lend you 10,000 dollars to get you started."
var text12 = "If you waste that money..."
var text13 = "I WILL WASTE YOU!!"
var text14 = "goodluck!!"
var pause_at = 9
var label_node = null 
var pause_duration = 0.4
var display_speed = 0.001
var commanderugh = load('res://CommanderUgh.png')
var commanderhappy = load("res://CommanderHappy.png")
var commandersad = load("res://CommanderSad.png")
var commanderangry = load("res://CommanderAngry.png")
var commanderread = load('res://commanderRead.png')
var commanderyell = load('res://CommanderYell.png')
var commanderlook = load('res://CommanderLook.png')
var commanderpalm = load('res://CommanderPalm.png')
var commandermeow = load('res://commandermeow.png')
var commander = null
#stats & ui
var fund = 10001
var happiness = 23
var impeach = 10
var busCost = 3000
var busStopCost = 750
var storeCost = 2500
var storeLvlUpCost = 1500
var incomeRateCost = 1000
var incomeRate = 30
var happinessLowerRate = 45
var income = 200
var busCount = 0
var PTincome = 0
var parkCost = 10000
var gotStore1 = false
var gotStore2 = false
var parkFix = false
var popup1 = null
var popup2 = null
var incomePopup = null
var store1Lvl = 0
var store2lvl = 0
var upgradeStore1Available = false
var upgradeStore2Available = false
var skipped = false
#civ texts

# Called when the node enters the scene tree for the first time.
func _ready():
	popup1 = $Store1.get_popup()
	popup2 = $Store2.get_popup()
	incomePopup = $Funds/Incomes.get_popup()
	label_node = $Camera2D/Commander/Textbox/Text
	commander = $Camera2D/Commander
	commander.texture = commanderhappy
	await get_tree().create_timer(1.5).timeout
	$Camera2D/Commander.visible = true
	await get_tree().create_timer(0.5).timeout
	await(display_text1())
	await get_tree().create_timer(1.5).timeout
	$skipDialogue.visible = true
	commander.texture = commanderlook
	label_node.text = ''
	pause_at = 68
	await(display_text2())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderugh
	label_node.text = ''
	pause_at = 68
	await(display_text3())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderangry
	label_node.text = ''
	pause_at = 8
	await(display_text4())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderpalm
	label_node.text = ''
	pause_at = 8
	await(display_text5())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderyell
	label_node.text = ''
	pause_at = 11
	await(display_text6())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderlook
	label_node.text = ''
	pause_at = 11
	await(display_text7())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderugh
	label_node.text = ''
	pause_at = 11
	await(display_text8())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderhappy
	label_node.text = ''
	pause_at = 11
	await(display_text9())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commandersad
	label_node.text = ''
	pause_at = 11
	await(display_text10())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderugh
	label_node.text = ''
	pause_at = 11
	await(display_text11())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderangry
	label_node.text = ''
	pause_at = 11
	await(display_text12())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commanderyell
	label_node.text = ''
	pause_at = 11
	await(display_text13())
	await get_tree().create_timer(1.5).timeout
	commander.texture = commandermeow
	label_node.text = ''
	pause_at = 11
	await(display_text14())
	await get_tree().create_timer(1.5).timeout
	if skipped == false:
		commander.visible = false
		$AnimationPlayer.play('UIintro')
		await get_tree().create_timer(1.5).timeout
		$Hint.visible = true
		$AnimationPlayer.play("hint")
		popup1.connect("id_pressed", Callable(self, "_on_item_pressed"))
		popup2.connect("id_pressed", Callable(self, "_on_item_pressed2"))
		incomePopup.add_item("Total income: $" + str(income) +  "/" + str(incomeRate) + "s \n Income from public transport: $" + str(PTincome) + "/10s", 0)
		var happinessTimer = $Timer
		var incomeTimer = $Timer2
		var PTincomeTimer = $PTincomeTimer
		PTincomeTimer.start()
		PTincomeTimer.wait_time = 10
		happinessTimer.start()
		incomeTimer.start()
		incomeTimer.wait_time = incomeRate
		happinessTimer.wait_time = happinessLowerRate
		incomeTimer.connect("timeout",Callable(self, "_on_incometimer_timeout"))
		happinessTimer.connect("timeout",Callable(self, "_on_happinesstimer_timeout"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if store1Lvl == 2:
		popup1.remove_item(0)
		popup1.remove_item(0)
		popup1.add_item('Store is max lvl! (I appreciate the ambition though.)' , 9)
		popup1.add_item('Close',8)
	$Happiness/Label.text = "Happiness: " + str(happiness) + '%'
	$Funds/Label.text = "$" + str(fund)
	if happiness < 26:
		$Happiness.color = Color(1,0,0)
	if happiness > 49 and not happiness < 26:
		$Happiness.color = Color(1,2,0)
	if happiness > 74 and not happiness < 51 and not happiness < 26:
		$Happiness.color = Color(0,1,0)


func _on_happinesstimer_timeout():
		happiness = happiness - 3
		#add animaion
func _on_incometimer_timeout():
		fund = fund + income
		$store3incomeAnim.play('store3IncomeMade')
		if gotStore1 == false:
			print('store 1 not detected')
		if gotStore1 == true:
			$store1incomeAnim.play('store1IncomeMade')
		if gotStore2 == false:
			print('store 2 not detected')
		if gotStore2 == true:
			$store2incomeAnim.play('store2IncomeMade')
func _on_item_pressed(id):
	match id:
		1:
			if gotStore1 == false and fund > 2500:
				$Hint.visible = false
				$Hint2.visible = true
				$AnimationPlayer2.play('hint2')
				gotStore1 = true
				income = income + 100
				happiness = happiness + 10
				$Store1IncomeTxt.text = "$100" 
				fund = fund - 2500
				popup1.remove_item(0) #0 double (or whatever-ple) zero to remove everything
				popup1.remove_item(0) 
				popup1.add_item("Upgrade Store ($1500)", 3)
				popup1.add_item("Close", 2) #one below
				store1Lvl = 1
				$AnimationPlayer.stop()
				$AnimationPlayer.seek(0, true)
				$AnimationPlayer.play('store1Build')
				$Store1Lvl1.visible = true
				upgradeStore1Available = true
				print('store1 bought!')
			if fund < 2500 and gotStore1 == false:
				print('cannot afford to buy store 1')
		3:
			if upgradeStore1Available == true and store1Lvl == 1 and fund > 1500:
				fund = fund - 1500
				income = income + 100
				happiness = happiness + 10
				$Store1IncomeTxt.text = "$200"
				$Store1Lvl1.visible = false
				$Store1Lvl2.visible = true
				$AnimationPlayer.stop()
				$AnimationPlayer.seek(0, true)
				$AnimationPlayer.play('store1Build')
				store1Lvl = 2
				print('store 1 upgraded')
			if upgradeStore1Available == true and store1Lvl == 1 and fund < 1500:
				print('cannot afford lvl 2 for stroe 1')
func _on_item_pressed2(id):
	match id:
		1:
			if gotStore2 == false and fund > 2500:
				$Hint.visible = false
				gotStore2 = true
				income = income + 100
				happiness = happiness + 10
				$Store2IncomeTxt.text = "$100" 
				fund = fund - 2500
				popup2.remove_item(0) #0 double (or whatever-ple) zero to remove everything
				popup2.remove_item(0) 
				popup2.add_item("Upgrade Store ($1500)", 3)
				popup2.add_item("Close", 2) #one below
				store2lvl = 1
				$AnimationPlayer.stop()
				$AnimationPlayer.seek(0, true)
				$AnimationPlayer.play('store2Build')
				$Store2Lvl1.visible = true
				upgradeStore2Available = true
				print('store2 bought!')
			if fund < 2500 and gotStore2 == false:
				print('cannot afford to buy store 2')
		3:
			if upgradeStore2Available == true and store2lvl == 1 and fund > 1500:
				fund = fund - 1500
				income = income + 100
				happiness = happiness + 10
				$Store2IncomeTxt.text = "$200"
				$Store2Lvl1.visible = false
				$Store2Lvl2.visible = true
				$AnimationPlayer.stop()
				$AnimationPlayer.seek(0, true)
				$AnimationPlayer.play('store2Build')
				store2lvl = 2
				print('store 2 upgraded')
			if upgradeStore2Available == true and store2lvl == 1 and fund < 1500:
				print('cannot afford lvl 2 for stroe 2')




#text funcs
func display_text1():
	for i in range(text1.length()):
		label_node.text += text1[i]
		if i == pause_at:
			await(get_tree().create_timer(pause_duration)).timeout
		await(get_tree().create_timer(display_speed)).timeout
func display_text2():
	for i in range(text2.length()):
		label_node.text += text2[i]
		await(get_tree().create_timer(display_speed)).timeout
func display_text3():
	for i in range(text3.length()):
		label_node.text += text3[i]
		if i == pause_at:
			await(get_tree().create_timer(pause_duration)).timeout
		await(get_tree().create_timer(display_speed)).timeout
func display_text4():
	for i in range(text4.length()):
		label_node.text += text4[i]
		if i == pause_at:
			await(get_tree().create_timer(pause_duration)).timeout
		await(get_tree().create_timer(display_speed)).timeout
func display_text5():
	for i in range(text5.length()):
		label_node.text += text5[i]
		await(get_tree().create_timer(display_speed)).timeout
func display_text6():
	for i in range(text6.length()):
		label_node.text += text6[i]
		if i == pause_at:
			await(get_tree().create_timer(pause_duration)).timeout
		await(get_tree().create_timer(display_speed)).timeout
func display_text7():
	for i in range(text7.length()):
		label_node.text += text7[i]
		await(get_tree().create_timer(display_speed)).timeout
func display_text8():
	for i in range(text8.length()):
		label_node.text += text8[i]
		await(get_tree().create_timer(display_speed)).timeout

func display_text9():
	for i in range(text9.length()):
		label_node.text += text9[i]
		await(get_tree().create_timer(display_speed)).timeout

func display_text10():
	for i in range(text10.length()):
		label_node.text += text10[i]
		await(get_tree().create_timer(display_speed)).timeout

func display_text11():
	for i in range(text11.length()):
		label_node.text += text11[i]
		await(get_tree().create_timer(display_speed)).timeout

func display_text12():
	for i in range(text12.length()):
		label_node.text += text12[i]
		await(get_tree().create_timer(display_speed)).timeout

func display_text13():
	for i in range(text13.length()):
		label_node.text += text13[i]
		await(get_tree().create_timer(display_speed)).timeout

func display_text14():
	for i in range(text14.length()):
		label_node.text += text14[i]
		await(get_tree().create_timer(display_speed)).timeout


func _on_skip_dialogue_pressed():
	skipped = true
	$skipDialogue.visible = false
	$Camera2D/Commander.visible = false
	$AnimationPlayer.play('UIintro')
	await get_tree().create_timer(1.5).timeout
	$Hint.visible = true
	$AnimationPlayer.play("hint")
	popup1.connect("id_pressed", Callable(self, "_on_item_pressed"))
	popup2.connect("id_pressed", Callable(self, "_on_item_pressed2"))
	incomePopup.add_item("Total income: $" + str(income) +  "/" + str(incomeRate) + "s \n Income from public transport: $" + str(PTincome) + "/10s", 0)
	var happinessTimer = $Timer
	var incomeTimer = $Timer2
	var PTincomeTimer = $PTincomeTimer
	PTincomeTimer.start()
	PTincomeTimer.wait_time = 10
	happinessTimer.start()
	incomeTimer.start()
	incomeTimer.wait_time = incomeRate
	happinessTimer.wait_time = happinessLowerRate
	incomeTimer.connect("timeout",Callable(self, "_on_incometimer_timeout"))
	happinessTimer.connect("timeout",Callable(self, "_on_happinesstimer_timeout"))





func _on_incomes_pressed():
	$Hint2.visible = false
