# HOW TO USE
# ruby search.rb query

require "#{__dir__}/lib/searcher"

# インデックスファイルを読み込みます
# 正確には単語をキー、出現頻度-ポスティングリストをバリューとしたハッシュを作ってます

query = ARGV[0]
index = Searcher::search(query)
puts index.posting_list
