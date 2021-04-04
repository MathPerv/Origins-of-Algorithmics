#Задача 1
function reverse_user!(A::Vector{Int})
    len = length(A)
    N = isodd(len) ? (len ÷ 2 + 1) : (len ÷ 2)
    for i in 1:N
        A[i], A[ len - i + 1] = A[len - i + 1], A[i]
    end
end

function reverse_user!(A::Matrix, dim = (2, 2))
    len_rows, len_columns = dim
    len_of_array = len_rows * len_columns
    A = reshape(A, len_of_array)
    reverse_user!(A)
    A = reshape(A, (len_rows, len_columns))
end

#Задача 2
function copy_user(A::Vector{Int})
    B = Vector{Int}(undef, length(A))
    for i in 1:length(A)
        B[i] = A[i]
    end
    return B
end

function copy_user(A::Matrix, dim = (2, 2))
    len_rows, len_columns = dim
    len_of_array = len_rows * len_columns
    A = reshape(A, len_of_array)
    B = copy_user(A)
    A = reshape(A, dim)
    B = reshape(A, dim)
end

#Задача 3
#Возвращает отсортированный массив
function bubbleSort!(x)
    N = length(x)
    for  i in 1:(N-1)
        for j in i:N
            if x[i] > x[j]
                x[i], x[j] = x[j], x[i]
            end
        end
    end
end


#Возвращает отсортрованную копию массива (не меняя исходный массив)
bubbleSort(x) = bubbleSort!(copy(x)) 


#Возвращает индексы элементов так, чтобы элементы с этими индексами шли по возрастанию (отсортировав исходный массив)
function BubbleSortPerm!(x)
    size = length(x)
    index_array = [1]
    for i in 2:size
         push!(index_array, i) 
    end
    for i in 1:(size-1)
        for j in i+1:size
            if x[i] > x[j]
                x[i], x[j] = x[j], x[i]
                index_array[i], index_array[j] = index_array[j], index_array[i]
            end
        end
    end

    return index_array
end


#Возвращает индексы элементов так, чтобы элементы с этими индексами шли по возрастанию (не меняя исходный массив)
BubbleSortPerm(x) = BubbleSortPerm!(copy(x))

# Задача 4
function bubbleSort!(A::Matrix)
    _ , column_size = size(A)
    for i in 1:column_size
        column = @view A[:, i]
        bubbleSort!(column)
    end
end

bubbleSort(A::Matrix) = bubbleSort!(copy(A))


#Каждый элемент в столбце пронумерован. Первый элемент в столбце имеет номер (*номер последнего элемента предыдущего столбца* + 1)
#Сортируется каждый столбец и возвращается перестановка каждого столбца.
function BubbleSortPerm!(A::Matrix)
    row_size , column_size = size(A)
    B = copy(A)
    k = 0
    for i in 1:column_size
        column = @view A[:, i]
        index_array = BubbleSortPerm!(column)
        index_column = @view B[: , i]
        for j in 1:row_size
            index_column[j] = index_array[j] + k
        end
        k += 2
    end

    return B
end

BubbleSortPerm(A::Matrix) = BubbleSortPerm!(copy(A))


#Задача 5
function sortkey!(a::Vector{Int}, key_value::Vector{Int})
    index_array = BubbleSortPerm!(a)
    b = copy(a)
    for i in 1:length(a)
        a = b[index_array[i]]
    end
end

function sortkey!(f::Function, a)
    b = []
    for i in a
        push!(b,f(i))
    end
    indperm = sortperm(b)
    return indperm
end


#Сортировка столбцов матрицы в порядке не убывания количества нулей

#Считает нули в массиве
function countZeroes(a::Vector{Int})
    s = 0
    for i in a
        if i == 0
            s+=1
        end
    end
    return s
end

#Вспомогательная функция присваивания элементам одного массива для элементов другого массива.(Для срезов)
function ArraysCanBeAppropriated!(A, B)
    n = length(A)
    for i in 1:n
        A[i] = B[i]
    end
end

function sortZeroes!(A::Matrix)
    row_size, column_size = size(A)
    B = []
    for i in 1:column_size
        push!(B, A[:,i])
    end
    index_array = sortkey!(x -> countZeroes(x), B)
    B = copy(A)
    for i in 1:column_size
        C = @view A[: , i]
        ArraysCanBeAppropriated!(C, B[: , index_array[i]])
    end
end

# Сортировка столбцов матрицы в порядке не убывания суммы

function array_sum(a)
    s = 0
    for i in a
        s += i
    end
    return s
end

function sortSum!(A::Matrix)
    row_size, column_size = size(A)
    B = []
    for i in 1:column_size
        push!(B, A[:,i])
    end
    index_array = sortkey!(x -> array_sum(x), B)
    B = copy(A)
    for i in 1:column_size
        C = @view A[: , i]
        ArraysCanBeAppropriated!(C, B[: , index_array[i]])
    end
end

#Задача 6

function calcsort(a::Vector{Int}, diap::NTuple{2, Int})
    l, r = diap
    N = r - l + 1
    nums = zeros(Int, N)
    for i in a
        nums[i - l + 1] += 1 
    end
    b = []
    for i in 1:(r - l + 1)
        for j in 1:nums[i]
            push!(b, i + l - 1)
        end
    end
    a = b
    return b 
end

function calcsort(a::Vector{Int}, diap::Vector{Int})
    N = length(diap)
    nums = zeros(Int, N)
    for x in a
        for i in 1:N
            if a == diap[i]
                nums[i] += 1
                break
            end
        end    
    end
    b = []
    for i in 1:N
        for j in 1:nums[i]
            push!(b,diap[i])
        end
    end
    a = b
    return b 
end

#Задача 7

function insertsort!(a)
    n = length(a)
    for i in 2:n
        j = i - 1
        while j > 0 && a[j] > a[j + 1]
            a[j+1], a[j] = a[j], a[j+1]
            j -= 1
        end 
    end
    return a    
end

insertsort(a) = insertsort!(copy(a))

function insertsortPerm!(a)
    n = length(a)
    b = []
    for i in 1:n
        push!(b, i)
    end
    for i in 2:n
        j = i - 1
        while j > 0 && a[j] > a[j + 1]
            a[j+1], a[j] = a[j], a[j+1]
            b[j+1], b[j] = b[j], b[j + 1]
            j -= 1
        end 
    end

    return b
end

insertsortPerm(a) = insertsortPerm!(copy(a))

#Задача 8
insertsort!(A)=reduce(1:length(A))do _, k
    while k>1 && A[k-1] > A[k]
        A[k-1], A[k] = A[k], A[k-1]
        k-=1
    end
    return A
end

#Задача 9
function qseek(iter, value)
    l = 1
    r = lastindex(iter)
    n = r

    while r >= l
        if r == l + 1
            if iter[l] > value
                return l - 1
            elseif iter[l] == value
                return l
            elseif iter[l] < value <= iter[r]
                return r
            else
                return r + 1
            end
        elseif r == l
            return l + 1
        end
        m = (l + r) ÷ 2
        if iter[m] == value
            return m
        elseif iter[m] < value
            l = m
        else
            r = m 
        end
    end
    
end

function qinsertsort!(a)
    n = length(a)
    for i in 2:n
        j = i - 1
        index = qseek(a[1:j], a[i])
        index = index == 0 ? 1 : index
        while j >= index
            a[j + 1], a[j] = a[j], a[j+1]
            j -= 1 
        end
    end
    return a       
end

#Задача10

function nummax(a)
    r = lastindex(a)
    maxes = 0
    maxEl = a[1]
    for i in 2:r
        if maxEl == a[i]
            maxes += 1
        elseif maxEl < a[i]
            maxes = 1
            maxEl = a[i]
        end
    end
    return maxes
end

#Задача11
function findallmax(a)
    m = maximum(a)
    b = []
    for i in 1:length(a)
        if a[i] == m
            push!(b, i)
        end
    end
    
    return b    
end

#Задача12
function findallmax(f::Function, a)
    a1 = copy(a)
    for i in 1:length(a1)
        a1[i] = f(a1[i])
    return findallmax(a1)
end