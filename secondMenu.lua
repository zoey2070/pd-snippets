
local menuItems = {"One", "Two"}
local selectedMenu = 1
local listview = playdate.ui.gridview.new(0, 15)
local menuMax = #menuItems
local menuBG = "assets/nineslice" -- sets the nineslice BG to this
--honestly i wonder if i could just make a menu class

function twomenuDraw()
local menuInputHandler = {
    downButtonUp = function()
		listview:selectNextRow(true)
		selectedMenu +=1
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
		gfx.drawRoundRect(x, y, width, 25, 10)
	else
		gfx.setImageDrawMode(gfx.kDrawModeCopy)
	end


	gfx.drawTextInRect(menuItems[row], x, y+5, width, height+5, nil, "...", kTextAlignment.center)
end

function twodrawMenu()
	playdate.inputHandlers.push(menuInputHandler)
-- this is what changes the size/location of the menu:
    listview:drawInRect(120, 30, 120, 85)
	
    playdate.timer:updateTimers()
end

function playdate.AButtonUp()
	--plays SFX when you press A
	blip:play(1)

	-- THIS IS WHAT HAPPENS WHEN YOU PRESS EACH BUTTON:

	if selectedMenu == 1 then

		--this is what happens if we hit option 1
		print("Option 1 in Second Menu")

	elseif selectedMenu == 2 then
	   
		-- this is what happens if we hit option 2
		print("Option 2 in Second Menu")

	else
		--shouldn't ever get here in this menu...
		playdate.simulator.exit()
		-- really this just closes the sim so you don't need this line.
		-- maybe some fringe case/error handling in case something wack happens
	end
end
end

