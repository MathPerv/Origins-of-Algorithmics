function get_to_angle!(r::Robot)

    num_steps =[]
    
    while isborder(r, West) != true || isborder(r,Sud) != true
        push!(num_steps, moves!(r, West))
        push!(num_steps, moves!(r, Sud))
    end

    return num_steps
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r, side) != true
        move!(r, side)
        num_steps += 1
    end

    return num_steps
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int64)
    for i in 1:num_steps
        move_if_possible!(r, side)
    end
end

function move_if_possible!(r::Robot, side::HorizonSide)
    if isborder(r,side) != true
        move!(r, side)
    end
end

function mark_angles!(r::Robot)
    num_steps = []

    num_steps = get_to_angle!(r)

    for side in (Nord, Ost, Sud, West)
        moves!(r,side)
        putmarker!(r)
    end

    for (i, n) in enumerate(reverse!(num_steps))

        side = isodd(i) ? Nord : Ost
        moves!(r,side, n)
    end
end