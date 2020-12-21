inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 


#Дано: робот стоит на маркере, в указаннном направлении находится ряд маркеров
function move_by_markers!(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        move!(r, side)
    end
end
#Результат: робот прошел по маркерам и стоит в первой клетке без маркера

#Дано:робот стоит в случайной клетке
function move_if_possible!(r::Robot, side::HorizonSide)
    if isborder(r, side) == false
        move!(r, side)
        return true
    else 
        return false
    end
end
#Результат: робот двигается в указанном направлении до первой клетки с стенкой

#Дано:Робот стоит в случайной клетке
function mark_cross!(r::Robot)
    for side in (Nord, Ost, Sud, West)
        while move_if_possible!(r, side) == true
            putmarker!(r)
        end
        move_by_markers!(r, inverse(side)) 
    end
    putmarker!(r)
end
#Результат: робот стоит в той же клетке, на поле маркеры образуют крест с центром в этой же точке