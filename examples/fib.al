# Compute the nth fibonacci number

def fib(x)
    if x < 3 then
        1
    else
        fib(x-1) + fib(x - 2)

# Compute 40th fibonacci number
fib(40)
