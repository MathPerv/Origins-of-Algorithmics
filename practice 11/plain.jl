module Vector2Ds

    export xdot, sin, cos
    using LinearAlgebra

    Vector2D{T<:Real} = Tuple{T, T}


    Base.cos(a::Vector2D, b::Vector2D) = dot(a, b)/norm(a)/norm(b)
    xdot(a::Vector2D, b::Vector2D) = a[1]*b[2]-a[2]*b[1]
    Base. sin(a::Vector2D, b::Vector2D) = xdot(a,b)/norm(a)/norm(b)
end

using .Vector2Ds

randpoints(random::Function, num::Integer) = [(10*random(),10*random()) for _ in 1:num]