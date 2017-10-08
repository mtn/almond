require_relative 'emit'

if ARGV.length > 0
    begin
        f = File.open(ARGV[0],'r')
    rescue
        puts 'Error: Input file not found'
        exit 1
    end
else
    puts 'Error: No input file'
    exit 1
end

toks = Lexer.new(f.read).lex()
topLevel = Parser.new(toks).parseTopLevel()
out = Emitter.new(topLevel).run()
puts out

