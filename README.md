# almond

Almond is an _extremely_ simple toy language, patterned on [kaleidescope](https://llvm.org/docs/tutorial/), that compiles to C.

It's defined by the following grammar:

```
<prototype>  ::= <identifier> '(' <params> ')'
<params>     ::= <identifier>
               | <identifier>, <params>
<definition> ::= 'def' <prototype> <expr> 'end'
<extern>     ::= 'extern' <prototype> ';'
<operator>   ::= '+' | '-' | '*' | '/' | '%' | '>' | '<' | '>=' | '<=' | '=='
<expr>       ::= <binary> | <call> | <identifier> | <number> | <ifelse>
               | '(' <expr> ')'
<binary>     ::= <expr> <operator> <expr>
<call>       ::= <identifier> '(' <arguments> ');'
<ifelse>     ::= 'if' <expr> 'then' <expr> 'else' <expr> 'end'
<arguments>  ::= <expr>
               | <expr> ',' <arguments>
```

## Usage

    ./almond file.al

For example, to compile `examples/fib.al`:

    ./almond examples/fib.al

## LICENSE

MIT, see [LICENSE](https://github.com/mtn/almond/blob/master/LICENSE).

