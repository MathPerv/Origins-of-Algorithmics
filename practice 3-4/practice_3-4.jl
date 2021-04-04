#Задача 1
function find_all_max(A::AbstractVector)::AbstractVector{Int}
    max_i = [firstindex(A)]
    maxEl = A[max_i[1]]
    for i ∈ (firstindex(A) + 1):lastindex(A)
        if A[i] > maxEl
            maxEl = A[i]
            max_i = [i]
        elseif A[i] == maxEl
            push!( max_i, i)
        end
    end

    return max_i
end

#Задача 2
function BubbleSortModified!(a)
    k = 0
    n = length(a)
    while n - k != 1
        for i in 2:n-k
            if a[i] < a[i - 1]
                a[i], a[i-1] = a[i-1], a[i]
            end
        end
        k+=1
    end
end

#Задача 3
function ShakerSort!(a)
    n = length(a)
    k = 0 
    while n - k != 1
        for i in 2:n-k
            if a[i] < a[i - 1]
                a[i], a[i-1] = a[i-1], a[i]
            end
        end
        for i in n - k - 1: - 1: 1
            if a[i] > a[i+1]
                a[i], a[i+1] = a[i+1], a[i]
            end
        end
        k += 1
    end
end
#Задача4
function shellsort!(a; distseries::Base.Generator=(length(a)÷2^i for i in 1:Int(floor(log2(length(a))))))
    for d in distseries
        for i in firstindex(a):lastindex(a)-d
            j=i
            while j>=firstindex(a) && a[j]>a[j+d]
                a[j],a[j+d] = a[j+d],a[j]
                j-=d
            end
        end
    end
    return a
end

#Задача 5
function slice(A::AbstractVector,p::Vector{Int})::AbstractVector 
    b = []
    for x in p
        push!(b, A[x])
    end
    return b
end

#Задача6
function permute_!(a::Vector, perm::Vector{Int})
    for i in 1:length(A)
        j = 1
        while perm[j] != i
            j += 1
        end
        a[j],a[i] = a[i], a[j]
        perm[i], perm[j] = perm[j], perm[i] 
    end
end

#Задача7

function deleteat_!(a::Vector, inds::Vector{Int})::Vector
    b = []
    j = 1
    for i in 1:length(a)
        if j > length(inds) || i != inds[j]
            push!(b, a[i])
        else
            j += 1
        end
    end
    a = b
end

function insert_!(a::Vector, index::Int, item)
    push!(a,0)
    N = length(a)
    for i in N:-1:index
        a[i] = a[i-1]
    end
    a[index] = item
end


#Задача 8
function unique_!(a::Vector)::Vector
    sort!(a)
    b = []
    k = 0
    for x in a
        if k == 0 || b[k] < x
            push!(b, x)
            k += 1
        end
    end

    return b
end

unique_(a::Vector) = unique!(copy(a))

#Задача 9

function reverse_!(a::Vector)
    b = []
    for i in length(a):-1:1
        push!(b, i)
    end
    permute_!(a, b)
end

#Задача 10

function cyclic_move!(a::Vector)
    temp = a[length(a)]
    for i in length(a):-1:2
        a[i] = a[i - 1]
    end
    a[1] = temp
end

function cyclic_move!(a::Vector, m::Int)
    for i in 1:m
        cyclic_move!(a)
    end
end

#Задача 11

function transpose_(A::Matrix)
    row_count, column_count = size(A)
    B = Matrix{Int}(undef, column_count, row_count)
    for i in 1:row_count
        for j in 1:column_count
            B[j, i] = A[i, j]
        end
    end
    return B
end

#Задача 12
function find_new_place(a::Matrix, i, j)::Int
    row_count, column_count = size(a)
    return (j - 1) * column_count + i
end

function find_permutation_for_transpose(a::Matrix)::Vector{Int}
    n = []
    row_count, column_count = size(a)
    for i in 1:column_count
        for j in 1:row_count
            push!(n, find_new_place(a, i, j))
        end
    end
    return n
end

function transpose_1(A::Matrix)
    permut = find_permutation_for_transpose(A)
    row_count, column_count = size(A)
    len = row_count * column_count
    A = reshape(A, len)
    permute_!(A, permut)
    A = reshape(A, column_count, row_count)
    return A
end