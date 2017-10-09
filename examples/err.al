extern sqrt(n);
def foo(n)
    (n * sqrt(n * 200) + 57 * n)
end

foo(2,3); # Expect graceful arritymismatch error
