
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
            return :tok_def
        elsif identifierStr == 'extern'
            return :tok_extern
        else
            return identifierStr
        end
    elsif isdigit(lastChar) or lastChar == '.'
        numstr = ''
        loop do
            numstr += lastChar
            lastChar = STDIN.getc
            STDIN.getc
            break if not isdigit(lastChar) or lastChar == '.'
        end
        return numstr.to_f
    elsif lastChar == '#'
        loop do
            break if lastChar == EOF or lastChar == '\n' or lastChar == '\r'
        end
        if lastChar != EOF
            return gettok
        end
    elsif lastChar == EOF
        return :tok_eof
    else
        thisChar = lastChar
        lastChar = STDIN.getc
        STDIN.getc
        return thisChar
    end
end

gettok
