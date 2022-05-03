--simple menu and scene switcher--
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer" --probably needed for grid view
import 'CoreLibs/nineslice' --needed for grid view
import 'CoreLibs/ui' -- needed for grid view



scene = {}

-- importing my other lua files...
import 'sceneSelect' -- the scene switcher
import 'menu' -- my menu
import 'character' -- & the character!!

gfx = playdate.graphics


local function startup() --tells what the first scene is...
    current_scene = "start" -- this says to make the scene something called "start"


    scene[current_scene]["start"]() -- and this says to RUN the start function
                                    --of w/e current_scene is
end

startup() -- and sets it to it...

function playdate.update()
    scene[current_scene]["tick"]() --so EVERY time the playdate updates
    --it does what is in the "tick" section of the current scene

    gfx.sprite.update() --required to update images
    playdate.timer.updateTimers() --required for gridviews (which is what the menu is made of)

end