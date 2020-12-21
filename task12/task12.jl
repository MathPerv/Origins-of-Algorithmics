"""
На прямоугольном поле произвольных размеров расставить маркеры в виде "шахматных" клеток, начиная с юго-западного угла поля,
когда каждая отдельная "шахматная" клетка имеет размер n x n клеток поля (n - это параметр функции).
Начальное положение Робота - произвольное, конечное - совпадает с начальным.
Клетки на севере и востоке могут получаться "обрезанными" - зависит от соотношения размеров поля и "шахматных" клеток.
"""

include("robotlib.jl")

function mark_square!(r::Robot, n::Int)

    steps_done_x = 0

    for x in 1:n
        
        steps_done_y = 0

        for y in 1:n
            putmarker!(r)

            isStepDone = move_if_possible!(r, Nord)
            steps_done_y = isStepDone == true ? (steps_done_y + 1) : steps_done_y
        end

        moves!(r, Sud, steps_done_y)

        isStepDone = move_if_possible!(r, Ost)
        steps_done_x = isStepDone == true ? (steps_done_x) + 1 : steps_done_x
    end

    moves!(r, West, steps_done_x)
end

function mark_chess_modified!(r::Robot, n::Int)
    steps_to_SW_angle = []
    steps_to_SW_angle = get_to_angle!(r)

    while isborder(r, Ost) == false || isborder(r, Nord) == false
        while isborder(r, Ost) == false
            if isborder(r, Nord) == false
                mark_square!(r, n)
            end
            moves_if_possible!(r, Ost , 2*n)
        end

        if isborder(r, Ost) && isborder(r, Nord)
            break 
        end

        moves!(r, West)
        moves_if_possible!(r, Nord, 2*n)
    end

    get_to_angle!(r)

    back_to_start!(r,steps_to_SW_angle)
end