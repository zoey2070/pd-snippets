--combines a face image and body image into one sprite
-- to add character:
--[[  
      narrator = Character()
      narrator:moveTo(150,150)
      narrator:add()

      then to change face...

      narrator.face:setEmote(exprEmote["Happy"])
    
      see "exprEmote" for valid strings.
--]]

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

--THIS is the face offset... adjust the +5 as necessary
self.face:moveTo(x+5,y+5)
end


exprEmote = {Neutral = 1, Happy = 2}
-- you can add as many as you want, just follow the format.


local bodyImg = playdate.graphics.image.new("assets/defaultbody")
--local exprImg = playdate.graphics.image.new("assets/defaultface")

class('CharacterBody').extends(playdate.graphics.sprite)
function CharacterBody:init()
    CharacterBody.super.init(self)
    self:setImage(bodyImg)
end

class('CharacterFace').extends(playdate.graphics.sprite)
function CharacterFace:init()
    CharacterFace.super.init(self)
  self:setEmote(exprEmote.Neutral) --if there's no face set, it'll default to neutral
end

exprImgTbl = playdate.graphics.imagetable.new("assets/defaultface-table-154-182")
--basically, all the emotes are in one imagetable so you just swap it out at will.

function CharacterFace:setEmote(exprEmote)
  self:setImage(exprImgTbl[exprEmote])
end
