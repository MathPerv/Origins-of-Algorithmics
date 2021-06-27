using Base: vect, Integer, Bool
#Задача 1
abstract type AbstractCombinObject
    value::Vector{Int}
end

Base.iterate(obj::AbstractCombinObject) = (get(obj), nothing)
Base.iterate(obj::AbstractCombinObject, state) = 
    if next!(obj) == false
        nothing
    else
        (get(obj), nothing)
    end

Base.get(obj::AbstractCombinObject) = obj.value

#1
struct RepPlacement{N,K} <: AbstractCombinObject
    value::Vector{Int}
end

RepPlacement{N,K}() where {N, K} = RepPlacement{N,K}(ones(Int, K))

function next!(placement::RepPlacement{N,K}) where {N, K}
    c = get(placement)
    i = findlast(item->item < N, c)
    if isnothing(i)
        return false
    end
    c[i] += 1
    c[i+1:end] .= 1
    return true
end
#2

struct RepPlacement1{K} <: AbstractCombinObject
    value::Vector{Int}
    set::Vector
end

RepPlacement1{K}(n::Integer) where K = RepPlacement{K}(ones(Int, K),collect(1:n))
RepPlacemen1t{K}(set::Set) where K = RepPlacement{K}(ones(Int, K),collect(set))

Base.get(placement::RepPlacement1) = placement.set(placement.value)

function next!(placement::RepPlacement1)
    c = placement.value
    n = length(placement.set)
    i = findlast(item->item < n, c)
    if isnothing(i)
        return false
    end
    c[i] += 1
    c[i+1:end] .= 1
    return true
end

#Задача 2

struct Permute <: AbstractCombinObject
    value::Vector{Int}
    n::Int
end

function nFill(n::Integer)
    a = []
    for i in 1:n
        push!(a, i)
    end
    return a
end

Permute(n::Integer) = Permute(nFill(n), n)
Permute(arr::AbstractVector) = Permute(arr, length(arr))

function next!(p::Permute)
    k = 0
    value = p.value
    for i in p.n-1:-1:1
        if value[i] < value[i+1]
            k=i
            break
        end
    end
    if k == 0
        return false
    end

    i=k+1
    while i < p.n && value[i+1] > value[k]
        i+=1
    end

    value[k], value[i] = value[i], value[k]

    reverse!(@view value[k+1:end])
    return true
end

