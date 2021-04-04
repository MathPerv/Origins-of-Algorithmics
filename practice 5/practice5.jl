using Polynomials
using PyPlot

function find_deriative(P::Polynomial)::Polynomial
    coeffs = P.coeffs
    if length(coeffs) <= 1
        return Polynomial([0])
    end
    newcoeffs = Vector{Number}(undef, 0)
    for i in 2:length(coeffs)
        push!(newcoeffs, (coeffs[i] * (i-1)))
    end
    return Polynomial(newcoeffs)
end

function count_polynom(x::Number, p::Polynomial)::Number
    coeffs = copy(p.coeffs)
    reverse!(coeffs)
    result = coeffs[1]
    for i in 2:length(coeffs)
        result *= x
        result += coeffs[i]
    end
    return result
end

#Задача 1

function count_second_deriative(x::Number, p::Polynomial)::Number
    for i in 1:2
        p = find_deriative(p)
    end
    return count_polynom(x, p)
end

#Задача 2

function count_third_deriative(x::Number, p::Polynomial)::Number
    for i in 1:3
        p = find_deriative(p)
    end
    return count_polynom(x, p)
end

#Задача 3 и 4

function count_deriative(x::Number, p::Polynomial, k::Int)::Number
    for i in 1:k
        p = find_deriative(p)
    end
    return count_polynom(x, p)
end

diff(x::Number, p::Polynomial; ord = 1)::Number = count_deriative(x, p, ord)
#Задача 5

function divrem(a::AbstractArray, b::AbstractArray)::Vector{Number}
    n = length(a)
    m = length(b)
    if m > n
        return [0]
    end
    coeffs = []
    for i in n:-1:m
        k = i
        coeff = a[i]//b[end]
        for j in m:-1:1
            a[k] -= coeff * b[j]
            k -= 1
        end
        pushfirst!(coeffs, coeff)
    end
    return coeffs
end

#Задача 6
function \(a::Polynomial, b::Polynomial)::Polynomial
    acoeffs = copy(a.coeffs)
    bcoeffs = copy(b.coeffs)
    return Polynomial(divrem(acoeffs, bcoeffs))
end

function %(a::Polynomial, b::Polynomial)::Polynomial
    acoeffs = copy(a.coeffs)
    bcoeffs = copy(b.coeffs)
    divrem(acoeffs, bcoeffs)
    return Polynomial(acoeffs)
end

#Задача 7

function integral(p::Polynomial; constant = 0)
    coeffs = copy(p.coeffs)
    newcoeffs = Vector{Number}(undef, 0)
    for i in length(coeffs):-1:1
        pushfirst!(newcoeffs, coeffs[i]*(1//i))
    end
    pushfirst!(newcoeffs, constant)
    return Polynomial(newcoeffs)
end

function count_integral(a::Number, b::Number, p::Polynomial)
    pdx = integral(p)
    result = count_polynom(b, pdx) - count_polynom(a, pdx)
    return result    
end

#Задача 8

function dispersion(series)
    S¹ = eltype(series)(0)
    S² = eltype(series)(0)
    D, M = 0, 0
    for (n,a) in enumerate(series)
        S¹ += a
        S² += a^2
        M = S¹/n
        D = S²/n-M^2
    end
    return D, M
end

function currentstd(series, n::Int)
    a = series[1:n]
    D, l = dispersion(a)
    return D
end

function test_currentstd()
    series = randn(Float64, 50)
    D = currentstd(series, 50)
    plot(series)
    return D
end

#Задача9

function maxpartsum(array)::Number
    maxsum = array[1]
    currentsum = array[1]
    allsum = array[1]
    i = firstindex(array) + 1
    while i <= lastindex(array)
        if array[i] < 0
            allsum = currentsum < allsum ? allsum : currentsum
            if i + 1 <= lastindex(array)
                currentsum = array[i + 1]
            else
                break
            end
            if allsum > maxsum
                maxsum = allsum
            end
            allsum += array[i]
            allsum += array[i + 1]
             i += 2
        else
            allsum += array[i]
            currentsum += array[i]
            i += 1
        end
    end
    if allsum > maxsum
        maxsum = allsum
    end
    if currentsum > maxsum
        maxsum = currentsum
    end
    return maxsum
end

#Задача 10

function indexesOfmaxpartsum(array)
    i = firstindex(array) + 1
    r, l = 1, 1
    maxsum = 0
    currentsum = 0
    currentl, currentr = 1, 1
    allsum = 0
    allsuml, allsumr = 1, 1
    while i <= lastindex(array)
        if array[i] < 0
            if currentsum > allsum
                allsum = currentsum
                allsuml = currentl
                allsumr = currentr + 2
            end
            if i + 1 <= lastindex(array)
                currentsum = array[i+1]
                currentl = i + 1
                currentr = i + 1
            else
                break
            end
            if allsum > maxsum
                maxsum = allsum
                l = allsuml
                r = allsumr
            end
            allsum += array[i]
            allsum += array[i + 1]
            i += 2
        else
            allsum += array[i]
            allsumr += 1
            currentsum += array[i]
            currentr += 1
            i += 1
        end
    end
    if allsum > maxsum
        maxsum = allsum
        l = allsuml
        r = allsumr
    end
    if currentsum > maxsum
        l = currentl
        r = currentr
    end
    return [l, r]
end