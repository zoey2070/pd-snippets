--[[SCENE TEMPLATE
scene["name"] = {
    start = function ()
     --on start of the scene.
end,
     tick = function()
    --this runs every frame!!!
end,
    close = function()
    --when you close the scene.
end
}
--]]

scene["start"] = {
    start = function ()

        local listOptions = {"one","two","three"} -- the options you're putting in
        Menu1 = Menu(listOptions)
        Menu1:draw() --so here we draw our menu...

end,
     tick = function()
    -- & see what's selected. again, this runs every time playdate.update happens.
    -- which is a LOT
          if optionSelected == 1 then -- this should be index # of menu
                scene_transition("one") -- so now we go to the SECOND SCENE!!!!!
          end
    end,
    close = function()
        print("closing scene")
end
}


scene["one"] = {
    start = function ()
     local listOptions = {"character","or naw","quit3","quit4","quit5"}
     Menu2 = Menu(listOptions)
     Menu2:draw()
end,
     tick = function()
        if optionSelected == 1 then
            
            narrator = Character()
            narrator:moveTo(150,150)
            narrator:add()
            narrator.face:setEmote(exprEmote["Happy"])
   
        elseif optionSelected == 2 then
        print("hurray, you hit the right option!")
        --this will print forever without an 
        optionSelected = nil
        --but i THINK if we just put it in the
        -- transition file it'll be good. just switch scene after this i guess?
    else
    end
    
    
    end,
    close = function()
    --when you close the scene.
end
}





if scene[current_scene] == nil then print("NO SCENE") end
--this is what happens when there's no scene selected.

--this is REALLY COOL
function scene_transition(new_scene)
optionSelected = nil -- resets what's selected.
scene[current_scene]["close"]() --closes the current scene
current_scene = new_scene --sets whatever you put in the function to the current scene
scene[current_scene]["start"]() -- starts the new scene
end
