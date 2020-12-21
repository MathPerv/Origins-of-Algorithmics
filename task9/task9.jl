# ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер.
# Робот - в произвольной клетке поля.
# РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.

include("robotlib.jl")
"""
робот делает указанное число шагов в указанном направлении, если на его пути нет маркера.
Иначе останавливается на клетке с маркером
"""
function moves_to_marker!(r::Robot, side::HorizonSide, num_step::Int64)
    for i in 1:num_step
        if ismarker(r)
            break
        else
            move!(r, side)
        end
    end
end

function move_sigment!(r::Robot, sides::Any, num_steps::Int64)
    for side_of_movement in sides 
        moves_to_marker!(r, side_of_movement,num_steps)
    end
end

function move_snake_to_find_marker!(r::Robot)
    num_steps = 1
    while ismarker(r) != true
        move_sigment!(r, (Nord, Ost), num_steps)
        
        num_steps += 1

        move_sigment!(r, (Sud, West), num_steps)

        num_steps += 1
    end 
end