
#Задача 1

function euler_cycle(graph, start_ver::T=1) where T
        is_positive = u -> (u>0)
    
        cycle=T[]
        stack=[start_ver]
        while !isempty(stack)
            v = stack[end]
            if count(is_positive, graph(v)) == 0
                push!(cycle, pop!(stack))
            else
                i = findfirst(is_positive, graph[v])
                push!(stack, graph[v][i])
                graph[v][i] = -stack[end]
            end
            for u in graph[v]
                if u>0
                    push!(stack, u)
                end
            end
        end
        return cycle
    end
