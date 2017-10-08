extern sqrt(n);
def foo(n)
    (n * sqrt(n * 200) + 57 * n)
end

foo(2); # Expect 154
