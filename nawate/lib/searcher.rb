require "#{__dir__}/../model/index"

PATH_TO_CURRENT_DIR = File.expand_path('..', __FILE__)

module Searcher
  class << self
    def search(term)
      index = _indexes[term]
      Index.new(term, index[0], index[1])
    end

    # インデックスファイルを読み込みます
    # 正確には単語をキー、出現頻度-ポスティングリストをバリューとしたハッシュを作ってます
    def indexes
      _indexes.map do |index|
        Index.new(index[0], index[1][0], index[1][1])
      end
    end

    private

    def _indexes
      indexes = File.readlines("#{PATH_TO_CURRENT_DIR}/../iir.index").map do |line|
        index = line.split('-')
        posting_list = index[-1].split(',').map(&:to_i)
        freq = index[-2].to_i
        term = index[0..-3].join('-')
        [term, [freq, posting_list]]
      end
      indexes.to_h
    end
  end
end
