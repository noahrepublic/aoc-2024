local fs = require("@lune/fs")
local roblox = require("@lune/roblox")

local input = fs.readFile("src/inputs/day2.txt")

local lines = input:split("\n")

local safe = 0

local function checkLine(line)
    local split = line:split(" ")

    local lastNum = nil
    local decreasing = nil
    local lineSafe = true

    for i, n in split do
        n = tonumber(n)
        
        if lastNum == nil then
            lastNum = n
            continue
        end

        if decreasing == nil then
            decreasing = lastNum > n
        end

        local diff = math.abs(n - lastNum)
        if (n > lastNum and decreasing or n < lastNum and not decreasing) or diff < 1 or diff > 3 then
            lineSafe = false
            return i
        end

        lastNum = n
    end

    return lineSafe
end

for _, line in lines do
   local res = checkLine(line)
   if res == true then
        safe += 1
   end
end

print(`Part 1: {safe}`)

safe = 0

local function stringToTable(str) -- luau
    local t = {}
    for _, char in str:split(" ") do
        if char == "" or char == " " then
            continue
        end
        table.insert(t, char)
    end
    return t
end

for _, line in lines do
    local ok = false
    for i in line:split(" ") do
        local copy = stringToTable(line)
        table.remove(copy, i)

        local res = checkLine(table.concat(copy, " "))
        if res == true then
            ok = true
            break
        end
    end

    if ok then
        safe += 1
    end
end

print(`Part 2: {safe}`)