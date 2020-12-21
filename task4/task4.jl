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

function find_width(r::Robot)
    num_steps = 0
    while isborder(r, Ost) != true
        move!(r, Ost)
        num_steps += 1
    end

    moves!(r,West)
    return num_steps
end

function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) != true
        move!(r, side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide, num_steps::Int64)
    for i ∈ 1:num_steps
        putmarker!(r)
        move!(r,side)
    end
    putmarker!(r)
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

function mark_triangle!(r::Robot)
    x, y = get_to_angle!(r)
    width = find_width(r)
    while width > 0
        putmarkers!(r,Ost,width)
        moves!(r, West)
        move_if_possible!(r, Nord)

        width -= 1
    end 
    
    moves!(r, Sud)
        
    moves!(r, Ost, x)
    moves!(r, Nord, y)
end
