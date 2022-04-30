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

# def concat(set)
#   ret = set.shift
#   while !ret.empty?
#     ok = false
#     for i in 0...set.size
#       cur = set[i]
#       if ret[0] == cur[cur.size-1]
#         ret = cur + ret
#         set.delete_at(i)
#         ok = true
#         break
#       elsif ret[ret.size-1] == cur[0]
#         ret = ret + cur
#         set.delete_at(i)
#         ok = true
#         break
#       end
#     end
#     break if !ok
#   end
#   [ret, set]
# end

def concat(arr)
  loop do
    concated = []
    ok = false
    for i in 0...arr.size-1
      cur1 = arr[i]
      for j in i+1...arr.size
        cur2 = arr[j]
        if cur1[0] == cur2[cur2.size-1]
          str = cur2 + cur1
          concated << str
          arr.delete_at(j)
          arr.delete_at(i)
          ok = true
          break
        elsif cur1[cur1.size-1] == cur2[0]
          str = cur1 + cur2
          concated << str
          arr.delete_at(j)
          arr.delete_at(i)
          ok = true
          break
        end
      end
      break if ok
    end

    if ok
      arr = concated + arr
      next
    else
      break
    end
  end

  arr
end

def check(str)
  for c in "A".."Z"
    r = str.scan(/#{c}+/)
    return false if !(r.size == 0 || r.size == 1)
  end
  true
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri
  arr = rss
ppd arr

  loop do
    s = arr.size
    arr = concat(arr)
    break if arr.size == s
  end

  ans = arr.join
  ans = "IMPOSSIBLE" if !check(ans)
  puts "Case ##{case_index}: #{ans}"
end

STDERR.puts("time: #{Time.now - t_start} s")
