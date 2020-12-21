"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту, а две - ту же долготу, что и Робот, стоят маркеры.
"""

include("robotlib.jl")

function newMove_for_mark_cross_points!(r::Robot, side::HorizonSide, steps_to_markerplace::Int)
    moves!(r, side, steps_to_markerplace)
    putmarker!(r)
    moves!(r,side)
end

function mark_cross_points!(r::Robot)
    steps_to_SW_angle = []
    steps_to_SW_angle = get_to_angle!(r)

    from_bottom_to_point = 0
    for i in steps_to_SW_angle[2:2:end]
        from_bottom_to_point += i
    end

    from_west_to_point = 0
    for i in steps_to_SW_angle[1:2:end]
        from_west_to_point += i
    end

    newMove_for_mark_cross_points!(r, Nord, from_bottom_to_point)
    newMove_for_mark_cross_points!(r, Ost, from_west_to_point)

    get_to_angle!(r)
    newMove_for_mark_cross_points!(r, Ost, from_west_to_point)
    newMove_for_mark_cross_points!(r, Nord, from_bottom_to_point)
    get_to_angle!(r)

    back_to_start!(r, steps_to_SW_angle)

end