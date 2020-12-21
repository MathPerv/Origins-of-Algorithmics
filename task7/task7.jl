include("robotlib.jl")

function mark_row_chess!(r::Robot, side::HorizonSide, num_steps::Int64)
    x = mod(num_steps, 2)
    while isborder(r, side) != true
        if mod(x, 2) ==0
            putmarker!(r)
        end

        move!(r, side)
            x += 1
    end
    
    if mod(x, 2) == 0
        putmarker!(r)
    end

    return x
end

function mark_chess!(r::Robot)
    num_steps = []
    num_steps = get_to_angle!(r)

    y = 0
    x = 0
    height = 0
    side = Nord;
    while isborder(r, Nord)  != true
        side = isodd(y) ? West : Ost
        x = mark_row_chess!(r, side, x)
        y += 1
        move!(r, Nord)
        height += 1

        if isborder(r, Nord) != true
            move!(r, Nord)
            height = 0
        else
            break
        end
    end

    side = inverse(side)

    if mod(height, 2) == 0
        x = mark_row_chess!(r, side, x)
    end
    
    moves!(r, Sud)
    moves!(r, West)

    back_to_start!(r, num_steps)
end

