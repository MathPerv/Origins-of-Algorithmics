using Base: return_types
#Задача 1

ConnectList{T}=Vector{Vector{T}}
NestedVectors = Vector

function IsPrimalTree(tree::ConnectList{T},root::T) where T
    if tree[root] == []
        return true
    else
        return false
    end
end

function convert_to_nested(tree::ConnectList{T},root::T) where T
    NestedTree = []
    for subroot in tree[root]
        if IsPrimalTree(tree, subroot)
            push!(NestedTree, [subroot])
        else
            push!(NestedTree, convert_to_nested(tree, subroot))
        end
    end
    push!(NestedTree, root)
    return NestedTree
end

#Задача 2

function recurs_trace!(tree, connect_tree)
    connect_tree[tree[end]]=[]
    for subtree in tree[1:end-1] # - перебор всех поддеревьев
        push!(connect_tree[tree[end]], recurs_trace!(subtree, connect_tree))
    end
    return tree[end] # - индекс конрня
end

function convert_to_dict(tree::NestedVectors)
    T=typeof(tree[end])
    connect_tree = Dict{T,Vector{T}}()
    recurs_trace!(tree, connect_tree)
    return connect_tree
end

function convert_to_list(tree::NestedVectors)
    T = typeof(tree[end])
    dTree = convert_to_dict(tree)
    list_tree=Vector{Vector{T}}(undef,length(dTree))
    for subroot in eachindex(list_tree)
        list_tree[subroot]=dTree[subroot]
    end
    return list_tree
end

