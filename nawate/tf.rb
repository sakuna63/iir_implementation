require "#{__dir__}/lib/calculater"

term = ARGV[0]
doc_id = ARGV[1]
puts Calculater::tf(term, doc_id)
