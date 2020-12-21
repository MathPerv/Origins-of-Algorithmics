"""
moves!(r::Robot, side::HorizonSide)

-- перемещает Робота до упора в заданном направлении
"""
function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r,side) != true
        move!(r,side)
        num_steps += 1 
    end

    return num_steps
end

"""
    moves!(r::Robot, side::HorizonSide, num_steps::Int)

-- перемещает Робота в заданном направлении на заданное число шагов (если на пути - перегородка, то - ошибка)
"""
moves!(r::Robot, side::HorizonSide, num_steps::Int) = 
for _ in 1:num_steps
    move!(r,side)
end

"""
moves_if_possible!(r::Robot, side::HorizonSide, num_steps::Int64)

-- перемещает робота в выбранном направлении на выбранное число шагов, но в случае обнаружения преграды останавливается
"""

function moves_if_possible!(r::Robot, side::HorizonSide, num_steps::Int64)
    willContinue = true
    steps_done = 0
    for _ in 1:num_steps
        steps_done += 1
        willContinue = move_if_possible!(r, side)
        if willContinue == false
            return steps_done
            break 
        end
    end

    return steps_done
end



"""
    find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide)

-- останавливает робота у перегородки, которая ожидается с направления side_to_border, при движении робота "змейкой" в сторону перегородки (от упора до упора в поперечном этому напавлении). 

-- side_of_movement - начальное "поперечное" направление
"""
find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide) = 
while isborder(r,side_to_border)==false  
    if isborder(r,side_of_movement)==false && isborder(r, side_to_border) == false
        move!(r,side_of_movement)
    elseif isborder(r, side_of_movement) == true && isborder(r, side_to_border) == false
        move!(r,side_to_border)
        side_of_movement=inverse(side_of_movement)
    end
end

"""
    inverse(side::HorizonSide)

-- возвращает сторону горизонта, противоположную заданной
"""
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

"""
    putmarkers!(r::Robot, side::HorizonSide)

-- ставит маркеры, пермещая Робота до упора в заданном направлении (в начальной клетке маркер не ставится)    
"""
putmarkers!(r::Robot, side::HorizonSide) = 
while isborder(r,side)==false
    move!(r,side)
    putmarker!(r)
end

"""
    get_to_angle!(r::Robot)

--перемещает робота в левый нижний угол, кодирует его путь
"""
function get_to_angle!(r::Robot)

    num_steps =[]
    
    while (isborder(r, West) == false || isborder(r,Sud) == false)
        push!(num_steps, moves!(r, West))
        push!(num_steps, moves!(r, Sud))
    end

    return num_steps

end
"""
    back_to_start(r::Robot, num_steps::Array{Int64, 1})

--Если робот совершает своё движение в юго-западный угол  с движения в сторону Юга,
  то возвращает робота в исходное положение
"""

function back_to_start!(r::Robot, num_steps::Any)
    size = length(num_steps)
    num_steps = reverse!(num_steps)
    for (i,n) in enumerate(num_steps)
        side = isodd(size + (i - 1)) ? Ost : Nord
        moves!(r, side, n)
    end
    return num_steps
end

function move_if_possible!(r::Robot, side::HorizonSide)
    if isborder(r, side) == false
        move!(r,side)
        return true 
    else
        return false
    end
end

"""

move_snake!(r::Robot)
Робот двигается змейкой вверх-вниз по всему полю
"""

function move_snake!(r::Robot)
    side = Nord
    while !isborder(r, Nord) || !isborder(r, Ost)
        moves!(r, side)
        move!(r, Ost)
        side = inverse(side)
    end
end

"""
moves_to_marker!(r::Robot, side::HorizonSide, num_step::Int64)
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

"""
find_way!(r::Robot, side_of_border::HorizonSide)
Найти проход  в направлении
Возвращает разницу в координатах по оси ох или оу
"""

function find_way!(r::Robot, side_of_border::HorizonSide)
    num_steps = 1
    side = HorizonSide(mod(Int(side_of_border) + 1 , 4))
    steps_done = 0
    while isborder(r, side_of_border) == true
        moves_if_possible!(r, side, num_steps);
        num_steps += 1
        side = inverse(side)
    end
    det = 0

    side = inverse(side)
    if side == Nord || side == Ost
        det = 1
    else
        det = -1
    end

    return det * steps_done
end