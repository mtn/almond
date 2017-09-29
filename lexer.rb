
def isspace(c)
    c.match(/^\s*$/)
end

def isalpha(c)
    c.match(/^[[:alpha:]]$/)
end

def isalphanum(c)
    c.match(/\A[[:alnum:]]+\z/)
end

def gettok
    lastChar = ' '
    while isspace(lastChar)
        lastChar = STDIN.getc
        STDIN.getc
    end

    if isalpha(lastChar)
        identifierStr = lastChar

        lastChar = STDIN.getc
        STDIN.getc
        while isalphanum(lastChar)
            identifierStr += lastChar
            lastChar = STDIN.getc
            STDIN.getc
        end

        if identifierStr == 'def'
            puts 'got DEF'
            return :tok_def
        elsif identifierStr == 'extern'
            puts 'got EXTERN'
            return :tok_extern
        else
            puts 'got IDENT'
            return :tok_identifier
        end
    end
end

gettok
