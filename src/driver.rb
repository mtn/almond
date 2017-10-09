require_relative 'emit'

begin
    if ARGV.length > 0
        f = File.open(ARGV[0],'r')
    else
        raise NoInput, 'No input file'
    end

    toks = Lexer.new(f.read).lex()
    topLevel = Parser.new(toks).parseTopLevel()
    out = Emitter.new(topLevel).run()
    puts out
rescue Exception => e
    STDERR.puts "#{e.class}: #{e}"
    exit 1
end

