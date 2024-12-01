local fs = require("@lune/fs")

local input = fs.readFile("src/inputs/day1.txt")

local list1 = {}
local list2 = {}

for _, line in input:split("\n") do
	local found = line:find(" ")
	local num1 = line:sub(1, found):gsub(" ", "")
	local num2 = line:sub(found):gsub(" ", "")

	table.insert(list1, tonumber(num1))
	table.insert(list2, tonumber(num2))
end

table.sort(list1, function(a0: number?, a1: number?): boolean
	return a0 < a1
end)

table.sort(list2, function(a0: number?, a1: number?): boolean
	return a0 < a1
end)

local n = 0

for i = 1, #list1 do
	local num1 = list1[i]
	local num2 = list2[i]

	local distance = math.abs(num1 - num2)
	n += distance
end

print(`Part 1: {n}`)

n = 0

for _, num1 in list1 do
	local occurences = 0
	for _, num2 in list2 do
		if num1 == num2 then
			occurences += 1
		end
	end

	n += (occurences * num1)
end

print(`Part 2: {n}`)
