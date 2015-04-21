require "#{__dir__}/lib/calculater"

DOC_NUM = 21

terms = Searcher::indexes.map { |index| index.term }
terms.each do |term|
  print "#{term} = {"

  21.times do |i|
    id = i+1
    print "doc#{id}: #{Calculater::tf(term, id)} "
  end
  puts "}"
end
