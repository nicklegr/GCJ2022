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

class Node
  def initialize(idx, fac)
    @idx = idx
    @fac = fac
    @to = nil
    @froms = []
    @used = false
  end
  attr_accessor :idx, :fac, :to, :froms, :used
end

$sum = 0

def find_root(nodes, node)
  return node if node.to.nil?
  return node if nodes[node.to].used
  find_root(nodes, nodes[node.to])
end

def bfs(nodes, q)
  n = q.shift
# ppd n
  return if n.nil?

  inits = n.froms.select{|e| nodes[e].froms.empty?}.map{|e| nodes[e]}
  inits.sort_by!{|n| n.fac}
  inits.each do |e|
    raise if e.used
    run_chain(nodes, e)
  end

  q += n.froms.select{|e| !nodes[e].used}.map{|e| nodes[e]}

  bfs(nodes, q)
end

def run_chain(nodes, node)
  max = 0

  cur = node
# route = []
  while !cur.nil? && !cur.used
# route << cur
    max = cur.fac if max < cur.fac
    cur.used = true
    break if cur.to.nil?
    cur = nodes[cur.to]
  end

# ppd "route #{route.map{|e|"#{e.idx}(#{e.fac})"}.join("-")} max #{max}"

  $sum += max
end

(1 .. cases).each do |case_index|
  n = ri
  facs = ris
  points = ris

  $sum = 0

  nodes = []
  facs.each_with_index do |e, i|
    nodes << Node.new(i, e)
  end
  points.each_with_index do |p, i|
    if p != 0
      nodes[i].to = p - 1
      nodes[p - 1].froms << i
    end
  end
# ppd nodes
# puts "---"

  nodes.each do |node|
    next if node.used
    q = [find_root(nodes, node)]
    bfs(nodes, q)
  end

  # alone
  nodes.each do |node|
    next if node.used
    raise if !node.froms.empty?
    raise if !node.to.nil?
    $sum += node.fac
  end

  puts "Case ##{case_index}: #{$sum}"
end

STDERR.puts("time: #{Time.now - t_start} s")
