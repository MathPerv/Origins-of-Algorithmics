#ДАНО: Робот - рядом с горизонтальной перегородкой (под ней), бесконечно продолжающейся в обе стороны, в которой имеется проход шириной в одну клетку.
#РЕЗУЛЬТАТ: Робот - в клетке под проходом

include("robotlib.jl")

function find_way!(r::Robot)
    moves!(r, Nord)

    side = Ost
    num_steps = 1

    while isborder(r, Nord) == true
        moves!(r, side, num_steps)
        num_steps += 1
        side = inverse(side)
    end
end