--The Meat And Potatoes of scene switching:
-- When the scene switches, this is what'll run.

--maybe add some neat transitions idk...

function sceneSelect()
    if scene == "start" then
        --ok now in menu.lua we have my spaghetti.
     menuDraw() --the basic stuff
     drawMenu() -- draws the menu the first time
    elseif scene == "one" then 
        --for whatever reason when it was just "1" it didn't wanna work.
        
        --everything here will continue to loop while the scene is active
        -- so put bg music here i think since it'll loop...

        --for now i'm just gonna stick in the second menu:
        gfx.clear()
        twomenuDraw()
        twodrawMenu()
    elseif scene == "two" then
        gfx.clear()
        gfx.drawText("two", 5, 5 )
    else
    print("idk what scene this is!")
    end
end