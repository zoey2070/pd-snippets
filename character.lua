--combines a face image and body image into one sprite
-- to add character:
--[[   narrator = Character()
      narrator:moveTo(100,100)
      narrator:add()
      ]]
class('Character').extends()
function Character:init()
    Character.super.init(self)
    self.body = CharacterBody()
    self.face = CharacterFace()
end

function Character:add()
self.body:add()
self.face:add()

end

function Character:moveTo(x,y)
self.body:moveTo(x,y)
--THIS is the face offset, change the 5s as necessary
self.face:moveTo(x+5,y+5)
end

--declares the face/body images. have these swapped out as needed
local bodyImg = playdate.graphics.image.new("assets/defaultbody")
local exprImg = playdate.graphics.image.new("assets/defaultface")

class('CharacterFace').extends(playdate.graphics.sprite)
function CharacterFace:init()
    CharacterFace.super.init(self)
    self:setImage(exprImg)
end


class('CharacterBody').extends(playdate.graphics.sprite)
function CharacterBody:init()
    CharacterBody.super.init(self)
    self:setImage(bodyImg)
end