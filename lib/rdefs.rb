require 'optparse'

class Rdefs
  CLASS_REGEX = /\A\s*(?:
    class\s | module\s | include[\s\(]
    )/x

  DEF_REGEX = /\A\s*
    (?: def\s
      | class\s
      | module\s
      | include\b
      | alias(?:_\w+)?\b
      | attr_reader\b
      | attr_writer\b
      | attr_accessor\b
      | attr\b
      | public\b
      | private\b
      | protected\b
      | module_function\b
      )/x

  class Preprocessor
    def initialize(f)
      @f = f
    end

    def gets
      line = @f.gets
      if /^=begin\s/ =~ line
        while line = @f.gets
          break if /^=end\s/ =~ line
        end
        line = @f.gets
      end
      line
    end

    def lineno
      @f.lineno
    end
  end

  def initialize
    @re = DEF_REGEX
    @print_line_number_p = false
    @f = Preprocessor.new(ARGF)
    parse_options
  end

  def parse_options
    options = OptionParser.new do |opt|
      opt.banner = "#{File.basename($0)} [-n] [file...]"
      opt.on('--class', 'Show only classes and modules') {
        @re = CLASS_REGEX
      }
      opt.on('-n', '--lineno', 'Prints line number.') {
        @print_line_number_p = true
      }
      opt.on('--help', 'Prints this message and quit.') {
      puts opt.help
        exit 0
      }
    end

    begin
      options.parse!
    rescue OptionParser::ParseError => err
      $stderr.puts err.message
      exit 1
    end
  end

  def process
    while line = @f.gets
      if @re =~ line
        printf '%4d: ', @f.lineno if @print_line_number_p
        print getdef(line, @f)
      end
    end
  end

  def getdef(str, f)
    until balanced?(str)
      line = f.gets
      break unless line
      str << line
    end
    str
  end

  def balanced?(str)
    s = str.gsub(/'.*?'/, '').gsub(/".*?"/, '')
    s.count('(') == s.count(')')
  end
end
