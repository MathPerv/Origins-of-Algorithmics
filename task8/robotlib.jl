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
    find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide)

-- останавливает робота у перегородки, которая ожидается с направления side_to_border, при движении робота "змейкой" в сторону перегородки (от упора до упора в поперечном этому напавлении). 

-- side_of_movement - начальное "поперечное" направление
"""
find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide) = 
while isborder(r,side_to_border)==false  
    if isborder(r,side_of_movement)==false
        move!(r,side_of_movement)
    else
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
    
    while isborder(r, West) != true && isborder(r,Sud) != true
        push!(num_steps, moves!(r, West))
        push!(num_steps, moves!(r, Sud))
    end

    return num_steps

end
"""
    back_to_start(r::Robot, num_steps::Array{Int64, 1})

--Если робот совершает своё движение в юго-западный  с движения в сторону Юга,
  то возвращает робота в исходное положение
"""

function back_to_start!(r::Robot, num_steps::Any)
    num_steps = reverse!(num_steps)
    for (i,n) in enumerate(num_steps)
        side = isodd(i) ? Ost : Nord
        moves!(r, side, n)
    end
    return num_steps
end

function move_if_possible!(r::Robot, side::HorizonSide)
    if isborder == false
        move!(r,side)
        return(true)
    else
        return(false)
    end
end