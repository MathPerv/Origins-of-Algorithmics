include("robotlib.jl")
#ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. 
#Робот - в произвольной клетке поля между внешней и внутренней перегородками.
#РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.

function mark_innerrectangle_perimetr!(r::Robot)
    way_to_start = []
    way_to_start = get_to_angle!(r)
    
    find_border!(r, Ost, Nord)

    while isborder(r, Ost) == true
        move!(r, Nord)
    end

    for side in (Ost, Sud, West, Nord)
        move!(r, side)
        ort_side = HorizonSide(mod( Int(side) - 1, 4))
        while isborder(r, ort_side)
            putmarker!(r)
            move!(r, side)  
        end
    end

    get_to_angle!(r)

    back_to_start!(r, way_to_start)
end