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
function sort_perm!(x)
    size = length(x)
    index_array = [1]
    for i in 2:size push!(index_array, i) end
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
sort_perm(x) = sort_perm!(copy(x))


#Реализовать сортировку элементов матрицы по столбцам
function Matrix_column_bubbleSort!(A::Matrix)
    _ , column_size = size(A)
    for i in 1:column_size
        column = @view A[:, i]
        bubbleSort!(column)
    end
end


#Реализовать сортировку столбцов матрицы в порядке возрастания сумм чисел в них

#Вспомогательные функции
function get_sum_of_vector(x)
    sum = 0
    for i in x
        sum += i
    end

    return sum
end

function swap_columns!(a, b)
    N = length(a)
    for i in 1:N
        a[i], b[i] = b[i], a[i]
    end
end

#Сама сортировка
function sort_of_columns_by_sum!(A::Matrix)
    sum_array = [get_sum_of_vector( A[:, 1])]
    row_size, column_size = size(A)
    for i in 2:column_size
        push!(sum_array, get_sum_of_vector(A[ : , i]))
    end

    index_array = sort_perm!(sum_array)

    A1 = copy(A)
    Matrix_column_bubbleSort!(A1)

    for i in 1:column_size
        a = @view A[ : , i]
        swap_columns!(a, A1[ : , index_array[i]])
    end
end


#Cортировка подсчетом
function CountingSort!(a)
    max = maximum(a)
    min = minimum(a)
    N = length(a)
    nums = zeros(Int, max - min + 1)
    for i in 1:N
        nums[a[i] - min + 1] += 1
    end
    k = 1
    number = min
    for x in nums
        for i in 1:x
            a[k] = number
            k += 1
        end
        number += 1
    end
end