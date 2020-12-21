"""
ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля c перегородками.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.
"""

using HorizonSideRobots

include("robotlib.jl")

"""
    Робот обходит перегородку(даже если она прямоугольная). Если это граница поля, возвращает 0, иначе 1
"""

function evade_border!(r::Robot, side_to_border::HorizonSide)
    temp_side = HorizonSide(mod(Int(side_to_border) + 1, 4))
    sides = (temp_side, inverse(temp_side))
    steps_to_back = find_way!(r, side_to_border)
    isStepDone = move_if_possible!(r,side_to_border)
    side_to_back = steps_to_back >=  0 ? sides[2] : sides[1] 

    while isborder(r, side_to_back) == true
        move!(r,side_to_border)
    end

    if steps_to_back == 0
        if isStepDone == true
            move!(r, inverse(side_to_back))
        end
        return 0
    else
        steps_to_back = abs(steps_to_back)
        moves!(r, side_to_back, steps_to_back)
        return 1
    end
end

function putmarkers_universal!(r::Robot, side::HorizonSide)
    det = 1
    while det == 1
        willJustPutMarker = move_if_possible!(r, side)
        if willJustPutMarker == false
            det = evade_border!(r, side)
        end
        putmarker!(r)
    end
end

function move_by_markers_universal!(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        isStepDone = move_if_possible!(r, side)
        if isStepDone == false
            evade_border!(r, side)
        end
    end
end

function mark_cross_universal!(r::Robot)
    for side in (Ost, Nord, West, Sud) 
        putmarkers_universal!(r, side)
        move_by_markers_universal!(r, inverse(side))
    end

    putmarker!(r)
end