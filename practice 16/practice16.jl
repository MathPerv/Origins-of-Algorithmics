#Задача 2

function ford_bellman(G::AbstractMatrix, s::Integer)
    n = size(G,1)
    C = G[s,:]
    for k in 1:n-2, j in 2:n
        C[j] = min(C[j], minimum(C .+ G[:,j]))
    end
    return C
end

#Задача 4

function floyd(G::AbstractMatrix)
    for j in 2:n, i in 1:n
        if C[n-1,i] + G[i,j] < 0
            return false
        end
    end
    n=size(A,1)
    C=Array{eltype(G),2}(undef,n,n)
    C=G
    for k in 1:n, i in 1:n, j in 1:n
        if C[i,j] > C[i,k]+C[k,k,j]
            C[i,j] = C[i,k]+C[k,j]
        end
    end
    return C
end

#Задача 6 
function optpathfloyd(next::AbstractMatrix, i::Integer, j::Integer)
    p = [i]
    f = i
    while (fin!=j)
        push!(p,next[f,j])
        f = next[f,j]
    end
    return p
end

#Задача 7

function dijkstra(G::AbstractMatrix, s::Integer)
    _, N = size(G)
    valid = [true for i in 1:N]
    m = maximum(G)
    weight = [m for i in 1:N]
    weight[s] = 0
    for i in 1:N
        min_weight = m
        id = 0
        for j in 1:N
            if valid[j] && weight[j] < min_weight
                min_weight = weight[j]
				id = j
            end
        end
        for z in 1:N
			if weight[id] + G[id, z] < weight[z]
				weight[z] = weight[id] + G[id, z]
            end
        end
		valid[id] = false
    end

    return weight
end