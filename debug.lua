#include "game.lua"
#include "options.lua"
#include "score.lua"
#include "map.lua"
#include "about.lua"


function DebugMenuUI()
    local val = GetInt("options.gfx.debug")
    local is_mission = false
    local mode = " "
    local map = " "

    -- Thx to Rubikow#0098 --

    local maxDist = 500
    local plyTransform = GetPlayerTransform()
    local fwdPos = TransformToParentPoint(plyTransform, Vec(0, 0, maxDist * - 1))
    local direction = VecSub(fwdPos, plyTransform.pos)
    direction = VecNormalize(direction)

    -- LEVEL MODE --

    local levelid = GetString("game.levelid")

    if string.find(levelid, "hub") then
        mode = "Hub"
    elseif levelid == "" then
        mode = "Create"
    elseif string.find(levelid, "sandbox") then
        mode = "Sandbox"
    else
        is_mission = true
        map = levelid
        mode = "Mission"
    end


    if val == 1 then

        -- MAIN COLORS --
        --[[
            name = color in game format | hex
            white = 1, 1, 1 | #FFFFFF
            red = 1, 0.4980392157, 0.4980392157 | #FF7F7F
            green = 0.4784313725, 0.9568627451, 0.4823529412 | #7AF47B
            purple = 0.4666666667, 0.4705882353, 0.9372549020 | #7778EF
        --]]

        -- PLAYER POS --

        local playerPosX = tostring(GetPlayerPos()[1])
        local playerPosY = tostring(GetPlayerPos()[2])
        local playerPosZ = tostring(GetPlayerPos()[3])

        -- ROTATION --

        local playerDirX = direction[1] * 180
        local playerDirY = direction[2] * 180
        local playerDirZ = direction[3] * 180

        -- LOOKING AT --

        local hit, dist = Raycast(plyTransform.pos, direction, maxDist)
        local hitPos = TransformToParentPoint(plyTransform, Vec(0, 0, dist * - 1))
        if (not(hit)) then
            hitPos = {0, 0, 0}
        end

        -- ACTUAL CODE --

        UiPush()
            -- MAP INFO --
            UiPush()
                UiTranslate(15, 15)
                UiColor(0, 0, 0, 0.7) -- box background color
                UiWindow(285, 285) -- box size
                UiRect(285, 285)

                UiTranslate(UiCenter(), 30)
                UiColor(1, 1, 1)
                UiAlign("center middle")
                UiFont("font/bold.ttf", 25)
                UiText("Map Info")

                -- FIRE SOURCES --
                UiTranslate(-100, 50)
                UiColor(1, 0.4980392157, 0.4980392157)
                UiAlign("left middle")
                UiText("Fire Sources:")
                UiTranslate(200, 0)
                UiColor(1, 1, 1)
                UiAlign("right middle")
                UiText(tostring(GetFireCount()))

                -- MODE --
                UiTranslate(-200, 50)
                UiColor(0.4784313725, 0.9568627451, 0.4823529412)
                UiAlign("left middle")
                UiText("Mode:")
                UiTranslate(200, 0)
                UiColor(1, 1, 1)
                UiAlign("right middle")
                UiText(mode)

                -- MODE --
                UiTranslate(-200, 50)
                UiColor(0.4666666667, 0.4705882353, 0.9372549020)
                UiAlign("left middle")
                UiText("ID:")
                UiTranslate(200, 0)
                UiColor(1, 1, 1)
                UiAlign("right middle")
                UiText(map)
            UiPop()

            -- Player Info --

            UiPush()
                UiTranslate(15, 305)
                UiColor(0, 0, 0, 0.7) -- box background color
                UiWindow(285, 285) -- box size
                UiRect(285, 285)

                UiTranslate(UiCenter(), 30)
                UiColor(1, 1, 1)
                UiAlign("center middle")
                UiFont("font/bold.ttf", 25)
                UiText("Player Info")

                -- Looking at --
                UiTranslate(0, 50)
                UiColor(1, 0.4980392157, 0.4980392157)
                UiAlign("center middle")
                UiText("Looking At")
                -- X --
                UiFont("font/bold.ttf", 23)
                UiTranslate(-130, 25)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(1, 0.4980392157, 0.4980392157)
                UiText("X:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(hitPos[1])))
                -- Y --
                UiFont("font/bold.ttf", 23)
                UiTranslate(61, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(0.4784313725, 0.9568627451, 0.4823529412)
                UiText("Y:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(hitPos[2])))
                -- Z --
                UiFont("font/bold.ttf", 23)
                UiTranslate(61, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(0.4666666667, 0.4705882353, 0.9372549020)
                UiText("Z:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(hitPos[3])))

                -- Rotation --
                UiTranslate(-52, 25)
                UiColor(0.4784313725, 0.9568627451, 0.4823529412)
                UiAlign("center middle")
                UiText("Rotation")
                -- X --
                UiFont("font/bold.ttf", 23)
                UiTranslate(-130, 25)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(1, 0.4980392157, 0.4980392157)
                UiText("X:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(playerDirX)))
                -- Y --
                UiFont("font/bold.ttf", 23)
                UiTranslate(61, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(0.4784313725, 0.9568627451, 0.4823529412)
                UiText("Y:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(playerDirY)))
                -- Z --
                UiFont("font/bold.ttf", 23)
                UiTranslate(61, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(0.4666666667, 0.4705882353, 0.9372549020)
                UiText("Z:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(playerDirZ)))

                -- Position --
                UiTranslate(-52, 25)
                UiColor(0.4666666667, 0.4705882353, 0.9372549020)
                UiAlign("center middle")
                UiText("Position")
                -- X --
                UiFont("font/bold.ttf", 23)
                UiTranslate(-130, 25)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(1, 0.4980392157, 0.4980392157)
                UiText("X:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(playerPosX)))
                -- Y --
                UiFont("font/bold.ttf", 23)
                UiTranslate(61, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(0.4784313725, 0.9568627451, 0.4823529412)
                UiText("Y:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(playerPosY)))
                -- Z --
                UiFont("font/bold.ttf", 23)
                UiTranslate(61, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiColor(0.4666666667, 0.4705882353, 0.9372549020)
                UiText("Z:")
                UiFont("font/bold.ttf", 20)
                UiTranslate(20, 0)
                UiColor(1, 1, 1)
                UiAlign("left middle")
                UiText(string.format("%.2f", tostring(playerPosZ)))
            UiPop()
        UiPop()
    end
end
