require 'pp'

def ppd(*arg)
  if $DEBUG
    arg.each do |e|
      PP.pp(e, STDERR)
    end
  end
end

def putsd(*arg)
  if $DEBUG
    STDERR.puts(*arg)
  end
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

def puts_sync(str)
  puts str
  STDOUT.flush
end

def array_2d(r, c)
  ret = []
  r.times do
    ret << [0] * c
  end
  ret
end

class Integer
  def popcount32
    bits = self
    bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555)
    bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333)
    bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f)
    bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff)
    return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff)
  end

  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri

  arr = []
  for i in 0..9
    for j in 1..4
      arr << j * (10 ** i)
    end
  end

psum = 0
  for i in 1...1000
    break if arr.size == 100
    psum += i if !arr.include?(i)
    arr << i if !arr.include?(i)
  end
ppd psum


  puts_sync(arr.join(" "))
ppd "#{arr.sum}, len = #{arr.sum.to_s.size}"

j = []
for i in 0...100
  j << 10 ** 9 - i
end
ppd "#{j.sum}, len = #{j.sum.to_s.size}"

ppd "#{arr.sum + j.sum}, len = #{(arr.sum + j.sum).to_s.size}"

raise
  res = ris

  sum = (arr + res).sum

  half = sum / 2

  ans = []
  i = 0
  while half != 0
    ans << (half % 10) * (10 ** i)
    half /= 10
    i += 1
  end

  # sum = 10-12桁
  # half = 9-11桁


  puts_sync(ans.join(" "))




  puts "Case ##{case_index}: #{answer}"
end

STDERR.puts("time: #{Time.now - t_start} s")
