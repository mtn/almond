
def gettok
    lastChar = ' '
    while lastChar =~ /^\s*$/
        lastChar = STDIN.getc
    end

    if lastChar =~ /^[[:alpha:]]$/
        puts 'it was in the alphabet'
    end
end

gettok
