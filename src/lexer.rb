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
            break if not isdigit(c) or c == '.'
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
            nil
        end


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

def isdigit(c)
    c.match(/[0-9]+$/)
end

p $singleTokTable
