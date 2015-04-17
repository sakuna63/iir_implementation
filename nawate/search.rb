# HOW TO USE
# ruby search.rb query

PAHT_TO_CURRENT_DIR = File.expand_path('..', __FILE__)

# インデックスファイルを読み込みます
# 正確には単語をキー、出現頻度-ポスティングリストをバリューとしたハッシュを作ってます
indexes = File.readlines("#{PATH_TO_CURRENT_DIR}/iir.index").map do |line|
  index = line.split('-')
  posting_list = index[-1].split(',').map(&:to_i)
  freq = index[-2].to_i
  term = index[0..-3].join('-')

  [term, [freq, posting_list]]
end
indexes = indexes.to_h

query = ARGV[0]
doc_ids = indexes[query][1]
puts doc_ids
