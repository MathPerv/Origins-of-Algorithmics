"""
ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля c перегородками.
РЕЗУЛЬТАТ: Робот — в исходном положении, все клетки поля промаркированы
"""

using HorizonSideRobots

include("robotlib.jl")



function mark_field_universal!(r::Robot)
    num_step = []
    num_step = get_to_angle!(r)
 
    putmarker!(r)
    while isborder(r, Ost) != true
        for side in (Nord, Sud)
            putmarkers_universal!(r, side)
            move_if_possible!(r, Ost)
            putmarker!(r)
        end
    end

    moves!(r, Sud)
    moves!(r, West)

    back_to_start!(r, num_step)
    
end