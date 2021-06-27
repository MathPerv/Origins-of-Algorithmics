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

#Задача 5
otr=[(1,-1),(5,7)]

using Plots
function where_points(seg,otr)
    p=plot()
    a=otr[1][2]-otr[2][2]
    b=otr[2][1]-otr[1][1]
    c=otr[1][1]*otr[2][2]-otr[1][2]*otr[2][1]
    #Ax+By+C=0
    a1=[]
    a2=[]
    a3=[]
    for i in seg
        k=a*i[1]+b*i[2]+c
        if k>0
            push!(a1,i)
        elseif k==0
            push!(a2,i)
        else
            push!(a3,i)
        end
    end
    plot!([otr[1][1],otr[2][1]],[otr[1][2],otr[2][2]]; linecolor=:green, markershape=:circle, markercolor=:blue)
    for i in a1
        scatter!(i;legend=false,markercolor=:red)
    end
    for i in a2
        scatter!(i;legend=false,markercolor=:orange)
    end
    for i in a3
        scatter!(i;legend=false,markercolor=:yellow)
    end
    return p
end

where_points(seg,otr)

# Задача 6

points=[s for s in zip([0.0,3.0,6.0,2.0,6.0],[0.0,6.0,4.0,3.0,0.0])]

mnog=[s for s in zip([1.0,0.0,3.0,5.0,4.0,2.0,1.0],[0.0,2.0,7.0,2.0,-3.0,1.0,0.0])]

function in_mnog(points,mnog)
    pairs=[]
    u=1
    while u<length(mnog)
        push!(pairs,[mnog[u],mnog[u+1]])
        u=u+1
    end
    ins=[]
    out=[]
    for p in points
        ugol=0
        for i in pairs
            vec1=(p[1]-i[1][1],p[2]-i[1][2])
            vec2=(p[1]-i[2][1],p[2]-i[2][2])
            ugol=ugol+acos(cos(vec1,vec2))*180/pi
        end
        if round(ugol)>=359
            push!(ins,p)
        else
            push!(out,p)
        end
    end
    p=plot()
    for x in out
        scatter!(x;legend=false,markercolor=:blue)
    end
    for x in ins
        scatter!(x;legend=false,markercolor=:red)
    end
    plot!(mnog)
    return p
end

in_mnog(points,mnog)