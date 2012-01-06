#!/usr/bin/env ruby
#
# $Id$

require 'optparse'

CLASS_RE = /\A\s*(?:
    class\s | module\s | include[\s\(]
  )/x

DEF_RE = /\A\s*
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

def main
  re = DEF_RE
  print_line_number_p = false
  parser = OptionParser.new
  parser.banner = "#{File.basename($0)} [-n] [file...]"
  parser.on('--class', 'Show only classes and modules') {
    re = CLASS_RE
  }
  parser.on('-n', '--lineno', 'Prints line number.') {
    print_line_number_p = true
  }
  parser.on('--help', 'Prints this message and quit.') {
    puts parser.help
    exit 0
  }
  begin
    parser.parse!
  rescue OptionParser::ParseError => err
    $stderr.puts err.message
    exit 1
  end

  f = Preprocessor.new(ARGF)
  while line = f.gets
    if re =~ line
      printf '%4d: ', f.lineno if print_line_number_p
      print getdef(line, f)
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

class Preprocessor
  def initialize(f)
    @f = f
  end

  def gets
    line = @f.gets
    if /\A=begin\s/ =~ line
      while line = @f.gets
        break if /\A=end\s/ =~ line
      end
      line = @f.gets
    end
    line
  end

  def lineno
    @f.lineno
  end
end

main
