include("plain.jl")
using .Vector2Ds
using  Plots
using  LinearAlgebra
Vector2D{T<:Real} = Tuple{T, T}
#Задача 1 в файле plain.jl

#Задача2
displayPoints(points) = scatter(points; legend = false)

#Задача 3
function plotsegments(segments; kwargs...)
    p = plot(;kwargs)
    for s in segments
        plot!(collect(s), kwargs...)
    end
    return p
end

#Задача 4

Point=Vector2D
Segment{T<:Real} = Tuple{Point{T},Point{T}}

function intersect((A₁,B₁)::Segment, (A₂,B₂)::Segment)    
    A = [B₁[2]-A₁[2]  A₁[1]-B₁[1]
         B₂[2]-A₂[2]  A₂[1]-B₂[1]]

    b = [A₁[2]*(A₁[1]-B₁[1])+A₁[1]*(B₁[2]-A₁[2])
         A₂[2]*(A₂[1]-B₂[1])+A₂[1]*(B₂[2]-A₂[2])]


    x,y = A\b

    if isinner((x, y), (A₁,B₁))==false || isinner((x, y), (A₂,B₂))==false
        return nothing
    end

    return (x,y)
end

isinner(P::Point, (A,B)::Segment) = 
    (A[1] <= P[1] <= B[1] || A[1] >= P[1] >= B[1]) &&
    (A[2] <= P[2] <= B[2] || A[2] >= P[2] >= B[2])

function plotSegmentsIntersectionsPoints(segments)
    pointsToMark = []
    for i in 1:length(segments)
        for j in i:length(segments)
            tmp = intersect(segments[i], segments[j])
            if tmp !== nothing
                push!(pointsToMark, tmp)
            end
        end
    end
    plotsegments(segments)
    displayPoints(pointsToMark)
end