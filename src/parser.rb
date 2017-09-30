require_relative 'lexer'

$currtok = nil
def getNextToken()
    $currtok = gettok()
end
