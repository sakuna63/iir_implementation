require "#{__dir__}/lib/calculater"

term = ARGV[0]
puts Calculater::df(term)
