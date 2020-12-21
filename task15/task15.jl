# ДАНО: Робот - в произвольной клетке поля с перегородками
# РЕЗУЛЬТАТ: Робот - в исходном положении, все клетки по периметру внешней рамки промаркированы

using HorizonSideRobots

include("robotlib.jl")

function mark_perimetr_universal!(r::Robot)
    num_steps = []
    num_steps = get_to_angle!(r)
    
    moves!(r, Ost)

    for i in 0:3
        side = HorizonSide(i)
        putmarkers!(r, side)
    end

    moves!(r, West)

    back_to_start!(r, num_steps)
end