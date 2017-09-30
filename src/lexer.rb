require_relative 'tokens'

class Lexer

    def intialize(input)
        @input = input
        @ind = 0
    end

    def peek
        @input[@ind]
    end

    def advance
        @ind += 1
    end

    def readIdOrNum
        tok = ''

        loop do
            c = @input[@ind]
            break if not isdigits(c) or c == '.'
            tok += c
            advance
        end

        tok
    end

    def getTok
        while isspace(@input[@ind])
            advance
        end

        if @ind == @input.length
            return nil
        end

        if $singleTokTable[@input[@ind].to_sym]
            advance
            return $singleTokTable[@input[@ind].to_sym].call()
        end

        if isalphanum(@input[@ind])
            str = readIdOrNum()
            if ['def','extern','if','then','else'].include? str
                return Token.new(str.to_sym)
            elsif isdigits(str)
                return Number.new(str.to_i)
            else
                return Identifier.new(str)
            end
        end

        nil
    end

    def lex
        toks = []

        loop do
            tok = getTok()
            if tok
                toks += tok
            end
        end

        toks
    end
end

def isspace(c)
    c.match(/^\s*$/)
end

def isalpha(c)
    c.match(/^[[:alpha:]]$/)
end

def isalphanum(c)
    c.match(/\A[[:alnum:]]+\z/)
end

def isdigits(c)
    c.match(/[0-9]+$/)
end

toks = Lexer.new(input: "def foo(n) (n * 100.34);").lex()
p toks
