def fib(x)
    if x < 3 then
        1
    else
        fib(x-1) + fib(x - 2)
    end
end

fib(40); # Expect 102334155
