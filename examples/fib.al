# Compute the nth fibonacci number
def fib(x)
    if x > 3 then
        if x > 3 then
            1
        else
            2
        end
    else
        fib(x-1) + fib(x - 2)
    end
end

fib(40);
