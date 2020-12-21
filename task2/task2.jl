using HorizonSideRobots


#Дано: робот в случайной клетке поля
function mark_frame_perimetr!(r::Robot)
    west_steps = moves!(r,West)
    sud_steps = moves!(r, Sud)

    for side in (Ost, Nord, West, Sud )
        putmarkers!(r, side)
    end

    moves!(r, Nord, sud_steps)
    moves!(r, Ost, west_steps)
end
#Результат: робот в исходном положении. Все клетки границы промаркированы

#Робот двигается в указанную сторону до стенки и возвращает количество пройденных шагов
function moves!(r::Robot, side::HorizonSide)
    num_steps = 0 
    while isborder(r, side) != true
        move!(r, side)
        num_steps += 1
    end

    return num_steps
end

#Робот совершает заданное количество шагов в указанную сторону
function moves!(r::Robot, side::HorizonSide, num_steps :: Int64)
    for i in 1:num_steps
        move!(r, side)
    end
end

#Робот двигается в указанную сторону до границы и ставит маркеры во всех клетках, кроме первой
function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side) != true
        move!(r, side)
        putmarker!(r)
    end
end