--simple menu and scene switcher--
--NOTE: I'm sure you can make your menus a class or something
-- but we'll see :)
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer" --probably needed for grid view
import 'CoreLibs/nineslice' --needed for grid view
import 'CoreLibs/ui' -- needed for grid view


-- importing my other lua files...
import 'sceneSelect' -- the scene switcher
import 'menu' -- my "main" menu...
import 'secondmenu' -- the second menu

gfx = playdate.graphics

-- this is global because we're going in and out of a few different scripts
scene = nil




--these r global bc they play in multiple menus...

playdate.sound.sample.new(2)
beep = playdate.sound.sampleplayer.new("assets/sound")
blip = playdate.sound.sampleplayer.new("assets/blip2")

--made by ChipTone: https://sfbgames.itch.io/chiptone


function startup() --tells what the first scene is...
    scene = "start"
end

startup() -- and sets it to it...

function playdate.update()
    sceneSelect() --runs from sceneSelect.lua
    gfx.sprite.update() --required to update images
    playdate.timer.updateTimers() --required for gridviews (which is what the menu is made of)

end