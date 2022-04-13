local menuItems = {"One", "Two", "Three", "Four"}
local selectedMenu = 1
local listview = playdate.ui.gridview.new(0, 15)
local menuMax = #menuItems
local menuBG = "assets/nineslice" -- sets the nineslice BG to this

playdate.sound.sample.new(2)
beep = playdate.sound.sampleplayer.new("assets/sound")
blip = playdate.sound.sampleplayer.new("assets/blip2")

function menuDraw()
local menuInputHandler = {
    downButtonUp = function()
		listview:selectNextRow(true)
		selectedMenu +=1 --it'll say there's an error here but playdate's SDK adds this functionality
		if selectedMenu > menuMax then
			selectedMenu = 1
		end
		drawMenu()
		beep:play(1)
    end,

	upButtonUp = function()
		listview:selectPreviousRow(true)
		selectedMenu -=1
		if selectedMenu < 1 then
			selectedMenu = menuMax
		end
		--debugging:
		print(selectedMenu)
		--end debug
		drawMenu()
		beep:play(1)

	end,
}

listview.backgroundImage = playdate.graphics.nineSlice.new(menuBG, 5, 6, 44, 40)
listview:setNumberOfRows(menuMax)
listview:setCellPadding(0, 0, 5, 5)
listview:setContentInset(24, 24, 13, 13)

function listview:drawCell(section, row, column, selected, x, y, width, height)

	if selected then
		gfx.setColor(gfx.kColorBlack)
		--change 25 when u change the font!!!
		gfx.drawRoundRect(x, y, width, 25, 10)
		--gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
	else
		gfx.setImageDrawMode(gfx.kDrawModeCopy)
	end


	gfx.drawTextInRect(menuItems[row], x, y+5, width, height+5, nil, "...", kTextAlignment.center)
end

function drawMenu()
	playdate.inputHandlers.push(menuInputHandler)

    listview:drawInRect(50, 50, 200, 150)
	
    playdate.timer:updateTimers()
end

function playdate.AButtonUp()
	--plays SFX when you press A
	blip:play(1)

	-- THIS IS WHAT HAPPENS WHEN YOU PRESS EACH BUTTON:

	if selectedMenu == 1 then
		scene = "one" --so this changes the SCENE to one, which is grabbed
		--by the scene select and switches to another scene

		-- and this tells it to get rid of our menu input handler!!
		playdate.inputHandlers.pop(menuInputHandler)

		-- seems to have a delay idk why


	elseif selectedMenu == 2 then
		scene = "two"
	elseif selectedMenu == 3 then
		print("Menu 3 selected")
	elseif selectedMenu == 4 then
		--credits
		print("M4")
	else
		--shouldn't ever get here in this menu...
		playdate.simulator.exit()
	end --ends the ifelse
end --ends the input


end
