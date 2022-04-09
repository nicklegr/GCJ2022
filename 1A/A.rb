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

def gen(db, s)
  raise if db.size != s.size
  ret = ""
  db.each_with_index do |e, i|
    ret += s[i]
    ret += s[i] if e
  end
  ret
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  s = rs

  db = []
  s.size.times do
    db << false
  end

  cand = s
  loop do
    cur = cand

    for i in 0...s.size
      mod = nil
      for j in i...s.size
        db[j] = true if !db[j]
        mod = j
        break
      end

      raise if mod.nil?
      n = gen(db, s)
      if n < cur
        cur = n
      else
        db[mod] = false
      end
    end

    if cur < cand
      cand = cur
    else
      break
    end
  end

  puts "Case ##{case_index}: #{cand}"
end

STDERR.puts("time: #{Time.now - t_start} s")
