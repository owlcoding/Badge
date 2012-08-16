module(..., package.seeall)

local string = require("string")
local math = require("math")

local pathOfThisFile = ...
local folderOfThisFile = (...):match("(.-)[^%.]+$")
local path = string.gsub(folderOfThisFile, "%.", "\/")

function new(number, params)
    local badge = display.newGroup()
    
    if (params.minDisplayedNumber and params.minDisplayedNumber > number) then
        return badge
    end
    local width = 1
    local n = number
    while (n >= 10) do
        n = math.round(n/10)
        width = width + 1
    end
    print ("number", number, "width", width)
    
    local left = display.newImageRect(path.."gfx/badge_l.png", 14, 29)
    -- local center = display.newImageRect(path.."gfx/badge_c.png", 36, 87)
    local right = display.newImageRect(path.."gfx/badge_l.png", 14, 29)
    right.xScale = -1
    
    -- add stuff to the group
    left.xReference, left.yReference = 0, 0
    local leftW = left.contentWidth
    left.x, left.y = 0, 0
    badge:insert(left)
    local lastX = leftW-1
    print ("lastX", lastX)
    local i = 1
    while (i < width) do
        local center = display.newImageRect(path.."gfx/badge_c.png", 13, 29)
        center.xReference, center.yReference = 0, 0
        center.x, center.y = lastX, 0
        
        badge:insert(center)
        lastX = lastX + center.contentWidth-1
        i = i +1
    end
    right.xReference, right.yReference = 0, 0
    right.x, right.y = lastX, 0
    badge:insert(right)
    lastX = lastX + leftW-1
    
    local txt = display.newText(""..number, 0, 0, native.systemFontBold, 16)
    print ("origin", txt.xOrigin, txt.yOrigin, txt.contentWidth, txt.contentHeight)

    txt:setTextColor(255, 255, 255)
    badge:insert(txt)
    txt.y = 0
    print ("x,y", txt.x, txt.y)
    
    return badge
end