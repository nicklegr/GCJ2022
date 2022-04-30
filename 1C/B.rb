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
  n, k = ris
  arr = ris

  sum = arr.sum
  add_sq = sum ** 2
  sq_add = 0
  arr.each do |e|
    sq_add += e ** 2
  end
ppd arr
ppd add_sq, sq_add

  ans =
    if add_sq == sq_add
      0
    else
      # x > 0
      # l = (sum+x)^2
      # r = sq_add + x^2
      # (sum+x)^2 = sq_add + x^2
      # sum^2 + 2*sum*x + x^2 = sq_add + x^2
      # sum^2 + 2*sum*x = sq_add
      # 2*sum*x = sq_add - sum^2
      # x = (sq_add - sum^2) / (2*sum)
      if 2*sum == 0
        nil
      else
        # q, r = (add_sq - sum**2).divmod(2*sum)
        q, r = (sq_add - sum**2).divmod(2*sum)
ppd "q: #{q}, r: #{r}"
        if r == 0
          q
        else
          nil
        end
      end
    end

  if ans
    puts "Case ##{case_index}: #{ans}"
  else
    puts "Case ##{case_index}: IMPOSSIBLE"
  end
end

STDERR.puts("time: #{Time.now - t_start} s")

__END__

      # l- = add_sq - (sum+x)^2
      # r+ = x^2
      #
      # add_sq - (sum+x)^2 = x^2
      # add_sq - (sum^2 + 2*x*sum + x^2) = x^2
      # add_sq - sum^2 - 2*x*sum - x^2 = x^2
      # add_sq - sum^2 = 2 * x^2 + 2*x*sum
      # 2 * x^2 + 2*x*sum + sum^2 - add_sq = 0

      # l+ = -add_sq + (sum+x)^2
      # r+ = x^2
      # -add_sq + (sum+x)^2 = x^2
      # -add_sq + (sum^2 + 2*x*sum + x^2) = x^2
      # -add_sq + sum^2 + 2*x*sum + x^2 = x^2
      # -add_sq + sum^2 + 2*x*sum = 0
      # 2*x*sum = add_sq - sum^2
      # x = (add_sq - sum^2) / (2*sum)
      #

    elsif add_sq > sq_add
      # x < 0
      # l- = add_sq - (sum+x)^2
      # r+ = x^2
      #
      # add_sq - (sum+x)^2 = x^2
      # add_sq - (sum^2 + 2*x*sum + x^2) = x^2
      # add_sq - sum^2 - 2*x*sum - x^2 = x^2
      # add_sq - sum^2 = 2 * x^2 + 2*x*sum
      # 2 * x^2 + 2*x*sum + sum^2 - add_sq = 0
      a = 2
      b = 2 * sum
      c = sum**2 - add_sq
      check = (b**2) - 4*a*c
      if check < 0
        nil
      else
        root = Integer.sqrt(check)
        if root*root == check
          (-b - root) / (2*a)
        else
          nil
        end
      end
    elsif add_sq < sq_add
