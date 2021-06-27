#Задача 1

function dfsearch(startver::T, graph) where T
    mark = zeros(Bool, length(graph))
    stack  = [startver]
    mark[startver] = 1
    visited = Int64[]
    while !isempty(stack)
        v = pop!(stack)
        push!(visited,v)
        for u in graph[v]
            if mark[u] == 0
                push!(stack,u)
                mark[u] = 1
            end
        end
    end
    return visited
end

#Задача 3

function valency(G)
    v = zeros(Int64, length(G))
    for i in firstindex(G):lastindex(G)
        v[i] = length(G[i])
    end
    return v
end

#Задача 4

function valency2(G)
    v = zeros(Int64, length(G))
    for i in firstindex(G):lastindex(G)
        for j in firstindex(G):lastindex(G)
            if i != j
                tmp = false
                for x in G[j]
                    if x == i
                        tmp = true
                        break
                    end
                end 
                v[i] = tmp ? v[i] + 1 : v[i]
            end
        end
    end
    return v
end

#Задача 5

function attempt_achievable!(start_ver::T, graph::ConnectList{T}, mark::AbstractVector{<:Integer}) where T   
    stack  = [start_ver]
    mark[start_ver] = 1 
    while !isempty(stack)
        v = pop!(stack)
        for u in graph[v]
            if mark[u] == 0
                push!(stack,u)
                mark[u] = 1
            end
        end
    end
end

function strongly_connected(graph::ConnectList)
    for s in 1:length(graph)
        if all_achievable(s, graph) == false
            return false
        end
    end
    return true
end

function all_achievable(started_ver::Integer, graph::ConnectList)
    mark = zeros(Bool,length(graph))
    attempt_achievable!(started_ver, graph, mark)
    return count(m->m==0, mark) == 0 #all(mark .== 1)
end