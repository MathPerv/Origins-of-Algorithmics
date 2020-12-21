
function get_to_angle!(r::Robot)
    x_steps  = 0
    y_steps = 0

    while isborder(r, Sud) == false
        y_steps += 1
        move!(r, Sud)
    end

    while isborder(r, West) == false
        x_steps += 1
        move!(r, West)
    end

    return x_steps, y_steps
end

function putmarkers!(r::Robot, side::HorizonSide)
    putmarker!(r)
    while isborder(r,side) != true
        move!(r, side)
        putmarker!(r)
    end
end

function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) != true
        move!(r, side)
    end
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int64)
    for i in 1:num_steps
        move!(r, side)
    end
end

function move_if_possible!(r::Robot, side::HorizonSide)
    if isborder(r,side) != true
        move!(r, side)
    end
end

function mark_all_cells!(r::Robot)
    x_steps, y_steps = get_to_angle!(r)
    while isborder(r, Ost) == false
        for side ∈ (Nord, Sud)
            putmarkers!(r, side)
            move_if_possible!(r, Ost)
        end
    end

    moves!(r, Sud)
    moves!(r, West)

    putmarker!(r)

    moves!(r, Ost, x_steps)
    moves!(r, Nord, y_steps)

end