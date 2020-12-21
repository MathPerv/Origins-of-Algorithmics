"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.

РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.
"""

using HorizonSideRobots

include("robotlib.jl")

function HorizonSideRobots.move!(r::Robot, side::NTuple{2, HorizonSide}) 
    for s in side
        willContinue = move_if_possible!(r, s)
        if willContinue == false
            return false
        end
    end

    return true
end

function HorizonSideRobots.isborder(r::Robot, side::NTuple{2, HorizonSide}) 
    return (isborder(r, side[1]) || isborder(r, side[2]))
end

function putmarkers!(r::Robot, sides::NTuple{2, HorizonSide})
    while isborder(r, sides) == false
        willPutMarker = move!(r, sides) 
        if willPutMarker
            putmarker!(r)
        else
            move!(r,sides)
            return
        end
    end
    putmarker!(r)
end

move_by_markers!(r, side::NTuple{2, HorizonSide}) = while ismarker(r) move!(r, side) end

inverse(side::NTuple{2, HorizonSide}) = (inverse(side[1]), inverse(side[2]))

function mark_cross_x!(r::Robot)
    for sides in ((Nord, Ost), (Nord, West), (Sud, Ost), (Sud, West))
        putmarkers!(r, sides)
        move_by_markers!(r, inverse(sides))
    end

    putmarker!(r)
end