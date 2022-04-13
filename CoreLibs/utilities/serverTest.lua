
import "CoreLibs/string"

import 'CoreLibs/utilities/server/a1.png'
import 'CoreLibs/utilities/server/a2.png'
import 'CoreLibs/utilities/server/a3.png'
import 'CoreLibs/utilities/server/a4.png'
import 'CoreLibs/utilities/server/a5.png'
import 'CoreLibs/utilities/server/a6.png'
import 'CoreLibs/utilities/server/a7.png'
import 'CoreLibs/utilities/server/a8.png'
import 'CoreLibs/utilities/server/a9.png'
import 'CoreLibs/utilities/server/a10.png'

local gfx = playdate.graphics

if playdate.server == nil then
	playdate.server = {}
end

local server = playdate.server


local currentPlayerID = "cec81399-47a5-44c3-97eb-8441d96396a1"

local players = {}

-- names courtesy Fighting Baseball for Super Famicom

players["cec81399-47a5-44c3-97eb-8441d96396a1"] = {
	name = "Bobson Dugnutt",
	avatar = gfx.image.new("CoreLibs/utilities/server/a1")
}

players["df380f9c-451e-44ae-97c9-bd74fa30bebd"] = {
	name = "Mike Truk",
	avatar = gfx.image.new("CoreLibs/utilities/server/a2")
}

players["7db2079c-38ea-46ab-8bd8-fd168b097a40"] = {
	name = "Mario McRlwain",
	avatar = gfx.image.new("CoreLibs/utilities/server/a3")
}

players["77d1b6e0-f231-4496-89e4-1e2e33f20545"] = {
	name = "Todd Bonzalez",
	avatar = gfx.image.new("CoreLibs/utilities/server/a4")
}

players["6faabff7-c9b7-4d69-a59b-3b025ec410ff"] = {
	name = "Willie Dustice",
	avatar = gfx.image.new("CoreLibs/utilities/server/a5")
}

players["2892ffda-6e7d-430b-917b-e6b4da0effcc"] = {
	name = "Glenallen Mixon",
	avatar = gfx.image.new("CoreLibs/utilities/server/a6")
}

players["36aaa388-ecfa-4b37-a4f8-9f7c8d8a77a6"] = {
	name = "Raul Chamgerlain",
	avatar = gfx.image.new("CoreLibs/utilities/server/a7")
}

players["0e8d4250-7578-4ad5-85b3-6a1ca361a17f"] = {
	name = "Scott Dourque",
	avatar = gfx.image.new("CoreLibs/utilities/server/a8")
}

players["4d3a59a9-3ca6-40f3-8fe2-3f8b9772a90b"] = {
	name = "Karl Dandilton",
	avatar = gfx.image.new("CoreLibs/utilities/server/a9")
}

players["6d94841b-c7a4-4370-afa3-9b762b81a437"] = {
	name = "Dean Wesrey",
	avatar = gfx.image.new("CoreLibs/utilities/server/a10")
}


local scoreboards = {
	{boardID = "com.panic.test.highscores", name = "High Scores"},
}


local highScores = {

	{playerID = "6d94841b-c7a4-4370-afa3-9b762b81a437", value = 57200},
	{playerID = "77d1b6e0-f231-4496-89e4-1e2e33f20545", value = 46750},
	{playerID = "4d3a59a9-3ca6-40f3-8fe2-3f8b9772a90b", value = 41600},
	{playerID = "df380f9c-451e-44ae-97c9-bd74fa30bebd", value = 36950},
	{playerID = "6d94841b-c7a4-4370-afa3-9b762b81a437", value = 33850},
	{playerID = "77d1b6e0-f231-4496-89e4-1e2e33f20545", value = 30600},
	{playerID = "2892ffda-6e7d-430b-917b-e6b4da0effcc", value = 22950},
	{playerID = "6faabff7-c9b7-4d69-a59b-3b025ec410ff", value = 22350},
	{playerID = "cec81399-47a5-44c3-97eb-8441d96396a1", value = 21750},
	{playerID = "36aaa388-ecfa-4b37-a4f8-9f7c8d8a77a6", value = 21500}
}




-- playdate.server.getScoreboards(callbackFunction)
-- RETURNS: status, scoreboards (array of tables with keys: boardID, name)

function server.getScoreboards(callbackFunction)
	assert(type(callbackFunction) == "function", 'callbackFunction must be a function')

	local uuid = playdate.string.UUID(20)
	local status = { code = "OK", id = uuid }

	playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status, scoreboards)
end



-- playdate.server.getScores(boardID, [includePlayer, [maxResults]], callbackFunction)
-- includePlayer defaults to false
-- maxResults defaults to 10
-- RETURNS: status, scores (array of tables with keys: playerID, playerName, rank, value)

function server.getScores(boardID, includePlayer, maxResults, callbackFunction)

	assert(type(boardID) == "string", 'boardID must be a string (try "com.panic.test.highscores"')

	if callbackFunction == nil and type(maxResults) == "function" then
		callbackFunction = maxResults
		maxResults = 10
		assert(type(includePlayer) == "boolean", 'includePlayer must be a boolean')
	elseif ( callbackFunction == nil and type(includePlayer) == "function" ) then
		callbackFunction = 	includePlayer
		includePlayer = false
		maxResults = 10
	else
		assert(type(callbackFunction) == "function", 'callbackFunction must be a function')
	end


	if boardID == "com.panic.test.highscores" then

		local scores = {}

		if maxResults > #highScores then maxResults = #highScores end

		for i = 1, maxResults do

			local highScore = highScores[i]
			local name = players[highScore.playerID].name
			scores[i] = {playerID = highScore.playerID, playerName = name, rank = i, value = highScore.value}
		end

		if includePlayer == true then

			-- see if the player is already included
			local found = false

			for i = 1, #scores do
				if scores[i].playerID == currentPlayerID then
					found = true
					break
				end
			end

			-- if not, first see if the player has a high score, and if they do replace the last entry with it
			if found == false then

				local highestPlayerScore = nil
				local pos

				for i = 1, #highScores do
					if highScores[i].playerID == currentPlayerID then
						highestPlayerScore = highScores[i]
						pos = i
						break
					end
				end

				if highestPlayerScore ~= nil then
					local name = players[highestPlayerScore.playerID].name
					scores[#scores] = {playerID = highestPlayerScore.playerID, playerName = name, rank = pos, value = highestPlayerScore.value}
				end
			end

		end


		local uuid = playdate.string.UUID(20)
		local status = { code = "OK", id = uuid }

		playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status, scores)
	else
		local status = { code = "ERROR", message = "No scoreboard found with the ID ".. boardID }
		playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status, {})
	end

end



-- playdate.server.addScore(boardID, score, callbackFunction)
-- RETURNS: {newRank, value, playerID, boardID}

function server.addScore(boardID, score, callbackFunction)
	assert(type(boardID) == "string", 'boardID must be a string (try "com.panic.test.highscores"')
	assert(type(score) == "number", 'score must be a number')
	assert(type(callbackFunction) == "function", 'callbackFunction must be a function')


	-- insert the new score into the high score list

	if boardID == "com.panic.test.highscores" then

		local count = #highScores
		while count > 0 and score > highScores[count].value do
			count -= 1
		end

		if count == 0 then count = 1 else count += 1 end

		table.insert(highScores, count, {playerID = currentPlayerID, value = score})

		local ret = { newRank = count, value = score, playerID = currentPlayerID, boardID = boardID }

		local uuid = playdate.string.UUID(20)
		local status = { code = "OK", id = uuid }

		playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status, ret)
	else
		local status = { code = "ERROR", message = "No score board found with the ID ".. boardID }
		playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status, {})
	end
end



-- playdate.server.getAvatar([playerID], callbackFunction)
-- RETURNS: status, image

function server.getAvatar(playerID, callbackFunction)
	if callbackFunction == nil and type(playerID) == "function" then
		callbackFunction = playerID
		playerID = currentPlayerID
	else
		assert(type(playerID) == "string", 'playerID must be a string')
	end

	local player = players[playerID]

	if ( player ~= nil ) then
		local uuid = playdate.string.UUID(20)
		local status = { code = "OK", id = uuid }

		local avatar = players[playerID].avatar

		playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status, avatar)
	else
		local status = { code = "ERROR", message = "Player with ID.. '"..playerID.."' not found" }
		playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status, nil)
	end
end



-- playdate.server.setAvatar(image, callbackFunction)
-- RETURNS: status

function server.setAvatar(image, callbackFunction)
	assert(type(image) == "userdata", 'image must be a playdate.graphics.image')
	assert(type(callbackFunction) == "function", 'callbackFunction must be a function')

	local exists = false

	players[currentPlayerID].avatar = image	-- do this delayed instead - add checking for the UUID

	local uuid = playdate.string.UUID(20)
	local status = { code = "QUEUED", id = uuid }

	playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status)
end



-- playdate.server.uploadImage(imageOrPath, title, callbackFunction)
-- RETURNS: status

function server.uploadImage(imageOrPath, title, callbackFunction)

	local image = imageOrPath
	if type(imageOrPath) == "string" then
		image = gfx.image.new(image)
	else
		assert(type(imageOrPath) == "userdata", 'imageOrPath must be a playdate.graphics.image or a path to an image file')
	end
	assert(type(title) == "string", 'title must be a string')
	assert(type(callbackFunction) == "function", 'callbackFunction must be a function')

	local uuid = playdate.string.UUID(20)
	local status = { code = "QUEUED", id = uuid }

	playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status)
end



-- playdate.server.uploadFile(path, callbackFunction)
-- RETURNS: status

function server.uploadFile(path, callbackFunction)
	assert(type(path) == "string", 'path must be a string')
	assert(type(callbackFunction) == "function", 'callbackFunction must be a function')

	local uuid = playdate.string.UUID(20)
	local status = { code = "QUEUED", id = uuid }

	playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status)
end



-- playdate.server.createMovie(title, imagePaths, [audioPath], callbackFunction)
-- RETURNS: status

function server.createMovie(title, imagePaths, audioPath, callbackFunction)
	assert(type(title) == "string", 'title must be a string')
	assert(type(imagePaths) == "table", 'imagePaths must be an array of strings')
	if callbackFunction == nil and type(audioPath) == "function" then
		callbackFunction = audioPath
		audioPath = nil
	else
		assert(type(audioPath) == "string", 'audioPath must be a string')
	end
	assert(type(callbackFunction) == "function", 'callbackFunction must be a function')

	local uuid = playdate.string.UUID(20)
	local status = { code = "QUEUED", id = uuid }

	playdate.timer.performAfterDelay(math.random(100, 1000), callbackFunction, status)
end





-----------------------------------------------------------------
-- Coroutine-friendly wrappers for server functions
-- meant to be called from within a coroutine thread
--
-- example:
--
-- local co = coroutine.create(function()
--     local errorMessage = yieldingUploadImage(imageFilePath, "Image Name")
--     print("Image upload complete.", errorMessage)
-- end)
-- coroutine.resume(co)
-----------------------------------------------------------------


function yieldServerCall(f, ...)

	local co = coroutine.running()

	local function callback(...)
		coroutine.resume(co, ...)
	end

	local args = {...}
	args[#args+1] = callback
	f(table.unpack(args))
	return coroutine.yield()
end


function server.yieldingGetScoreboards()
	return yieldServerCall(server.getScoreboards)
end

function server.yieldingGetScores(boardID, includePlayer, maxResults)
	return yieldServerCall(server.getScores, boardID, includePlayer, maxResults)
end

function server.yieldingAddScore(boardID, score)
	return yieldServerCall(server.addScore, boardID, score)
end

function server.yieldingGetAvatar(playerID)
	return yieldServerCall(server.getAvatar, playerID)
end

function server.yieldingSetAvatar(image)
	return yieldServerCall(server.setAvatar, image)
end

function server.yieldingUploadImage(imageOrPath, title)
	return yieldServerCall(server.uploadImage, imageOrPath, title)
end

function server.yieldingUploadFile(path)
	return yieldServerCall(server.uploadFile, path)
end

function server.yieldingCreateMovie(title, imagePaths, audioPath)
	return yieldServerCall(server.createMovie, title, imagePaths, audioPath)
end



