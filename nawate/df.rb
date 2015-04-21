require "#{__dir__}/lib/calculater"
require "#{__dir__}/lib/searcher"

terms = Searcher::indexes.map { |index| index.term }
terms.each do |term|
  puts "#{term} : #{Calculater::df(term)}"
end
