#Задача 1
function pow(a, n::Integer)
    k = a
    t = 1
    while n > 1
        if n%2 == 1
            a *= k
            n -= 1
        else
            a *= k
            k *= k
            n = n ÷ 2
        end 
    end

    return a
end

#Задача 2

function get_matrix_in_power_of_two(M::Matrix, p::Integer)
    if p == 0
        E = zeros((2,2))
        E[1, 1] = 1
        E[2, 2] = 1
        return E
    end
    if p == 1
        return M
    else
        L = get_matrix_in_power_of_two(M, p ÷ 2)
        return pow(M, 2)
    end
end

function Fibbonaci(n::Integer)
    if n == 0
        return 0
    end
    if n == 1
        return 1
    end
    if n == 2
        return 1
    end
    n -= 1
    M = fill(Int(1), (2, 2))
    M[2,2] = 0
    E = zeros(Integer, (2,2))
    E[1,1] = 1
    E[2,2] = 1
    m = 1
    while m <= n
        m *= 2
    end
    m = m ÷ 2
    powers = []
    while m > 0
        tmp = n%m
        powers_coeff = (n - tmp) ÷ m
        n = tmp
        m = m ÷ 2
        pushfirst!(powers, powers_coeff)
    end

    for i in 1:length(powers)
        tmp = get_matrix_in_power_of_two(M, 2^(i-1))
        for j in 1:powers[i]
            E = E * tmp
        end
    end

    return E[1,1]
end

#Задача 3
function log(a::Real, b::Real, eps::Real)
    z, t, y = x, 1, 0
    while z > a || z < 1/a || t > ε   
        if z > a
            z /= a
            y += t 
        elseif z < 1/a
            z *= a
            y -= t # т.к. z^t = (z*a)^t * a^-t
        else # t > ε
            t /= 2
            z *= z # т.к. z^t = (z*z)^(t/2)
        end
    end
end

#Задача 4
function isprime(n::Int)::Bool
    spqr = convert(Int, (ceil(sqrt(n))))
    for i in 2:spqr
        if n%i == 0 && i != n
            return false
        end
    end
    return true
end

#Задача 5
function eratosphen(n)
    numbers = fill(true, n)
    newNumbers = []
    for i in 2:n
        if numbers[i] == true
            push!(newNumbers, i)
            for j in (2*i):i:n
                numbers[j] = false 
            end
        end
    end
    return newNumbers
end

#Задача 6

function factor(n)
    if n == 1 || n == 0
        return n
    end
    divs = [1, n]
    spqr = convert(Int, (ceil(sqrt(n))))
    for i in 2:spqr
        if n%i == 0
            push!(divs, i)
            push!(divs, n/i)
        end
    end
    return divs
end

#Задача 7

function factor_m(n)
    divs = []
    div_powers = []
    spqr = convert(Int, (ceil(sqrt(n))))
    i = 2
    original = n
    while i*i <= original
        if n % i == 0
            if length(divs) == 0 || divs[lastindex(divs)] != i
                push!(divs, i)
                push!(div_powers, 1)
            else
                div_powers[lastindex(div_powers)] += 1
            end
            n = n ÷ i
        else
            i += 1
        end
    end
    if n != 1
        if divs[lastindex(divs)] == n
            div_powers[lastindex(div_powers)] += 1
        else
            push!(divs, n)
            push!(div_powers, 1)
        end
    end
    return divs, div_powers
end

function ϕ(n)
    divs, div_powers = factor_m(n)
    result = 1
    for i in 1:lastindex(divs)
        result *= (divs[i] - 1) * (divs[i]^(div_powers[i] - 1))
    end
    return result
end

#Задача 8

function just_gcd(a, b)
    if a == b || b == 0 
        return a
    else
        return just_gcd(b, a%b)
    end
end

function gcd_ext(a, b)
    if b == 0
        return (1, 0, a)
    end
    y, x, c = gcd_ext(b, a%b)
    return (x, y - (a ÷ b)*x, c)
end

#задача 9
function inv(m::Integer, n::Integer)
    x, y, c = gcd_ext(m, n)
    if c != 1
        return nothing
    else
        while x < 0
            x += n
        end
        return x
    end
end

#Задача 10

function zerodivisors(n)::Vector{Int}
    zeroes::Vector{Int} = []
    for i in 1:(n-1)
        if just_gcd(i, n) != 1
            push!(zeroes, i)
        end
    end
    return zeroes
end

#Задача 11
function nilpotents(n)
    divs, _ = factor_m(n)
    multip = 1
    for x in divs
        multip *= x
    end
    return multip:multip:(n-1)
end

#Задача 12
function ord(a, p)
    orders = factor(p - 1)
    for x in orders
        if pow(a, x)%p == 1
            return x
        end
    end
end

#Задача 13
function bisection(f::Function, a, b; atol = 0.001, rtol = 0.001)
    x = (a+b) / 2
    while (b-a) > atol || (b - a)/x > rtol
        if f(a)*f(x) < 0
            b = x
            x = (a+b)/2
        elseif f(x)*f(b) < 0
            a = x
            x = (a+b)/2
        elseif f(x) == 0
            return x
        end
    end
    return x
end

#тип элементы кольца вычетов по модулю m
struct ResidueRing{m}
    value::Int
    ResidueRing{m}(a=0) where m = new(a%m) 
    Base. +(a::ResidueRing{m}, b::ResidueRing{m}) where m = ResidueRing{m}((a.value+b.value)%m)
    Base.inv(a::ResidueRing{m}) where m = ResidueRing{m}.inv(a.value,m)
    ord(a::ResidueRing{m}) where m = ResidueRing{m}.ord(a.value,m)
    nilpotents(a::ResidueRing{m}) where m = ResidueRing{m}.nilpotents(m)
    zerodivisors(::ResidueRing{m}) where m = ResidueRing{m}.zerodivisors(m)
end    