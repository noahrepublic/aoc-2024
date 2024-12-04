local fs = require("@lune/fs")

local input = fs.readFile("src/inputs/day3.txt")

local total = 0
for x, y in input:gmatch("mul%((%d+),%s*(%d+)%)") do
    total += (x * y)
end

print(`Part 1: {total}`)

total = 0

local currentCommand = ""
local allowed = true

for i = 1, #input do
    local char = input:sub(i, i)
    currentCommand = currentCommand .. char

    if char == ")" then
        local activeCommand = currentCommand
        currentCommand = ""
        local processedCommand = activeCommand:gmatch("[a-zA-Z']+%b()")()
        if not processedCommand then continue end
        processedCommand = processedCommand:gsub("'", "")

        local endInstructionLocation = string.find(processedCommand, "%(")
        if not endInstructionLocation then continue end -- linter
        local instruction = processedCommand:sub(1, endInstructionLocation - 1)
        
        if instruction:find("dont") and processedCommand:sub(endInstructionLocation + 1, endInstructionLocation + 1) == ")" then
            allowed = false
        elseif instruction:find("do") and processedCommand:sub(endInstructionLocation + 1, endInstructionLocation + 1) == ")" then
            allowed = true
        elseif instruction == "mul" and allowed then
           
            if not string.find(processedCommand, ",") then 
                continue 
            end
            local endOf = string.find(processedCommand, ")") -- linter
            local insideBrackets = processedCommand:sub(endInstructionLocation + 1, endOf - 1)
            local x, y = insideBrackets:split(",")[1], insideBrackets:split(",")[2]
            x = tonumber(x)
            y = tonumber(y)
            if x == nil or y == nil then 
                continue
            end

            total += (x * y)
        end

    end
end

print(`Part 2: {total}`)