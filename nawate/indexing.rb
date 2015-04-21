require "#{__dir__}/lib/fileloader"

PATH_TO_CURRENT_DIR = File.expand_path('..', __FILE__)
PATH_TO_CHAPS_DIR = "#{PATH_TO_CURRENT_DIR}/../chaps/"

# ファイルネームから大チャプターの数値に変換します
# ex.
# 1.html   => 1
# 1.1.html => 1
# 2.1.html => 2
def chomp_small_chap_num(chap_name)
  chap_name[0...chap_name.index('.')].to_i
end

# 構築したindexを出力します
def output(indexes, path_to_dir, filename = 'iir.index')
  File.open("#{path_to_dir}/#{filename}", 'w') do |file|
    indexes.each do |index|
      index[2] = index[2].join(',')
      file.puts index.join('-')
    end
  end
end

# term-doc_idのペアを表すクラス
class Pair < Struct.new(:doc_id, :term); end

Dir.chdir(PATH_TO_CHAPS_DIR)
chap_filenames = Dir.glob('*.html')

# ファイルからテキストを抽出して単語の配列に変換するまで〜
terms = chap_filenames
  .map {|filename| FileLoader.load_as_terms(filename)}

# 単語(term)を文書ID(doc_id)と紐付けたペアの配列に変換するまで〜
big_chap_nums = chap_filenames.map { |filename| chomp_small_chap_num(filename) }
pairs = big_chap_nums.zip(terms).to_h
  .map {|chap_num, terms| terms.map {|term| Pair.new(chap_num, term) }}
  .flatten

# 単語を基準にソートするまで〜
pairs_sorted = pairs.sort_by { |pair| pair.term }

# インデックスの構築まで〜
# 正確には単語-出現頻度-ポスティングリストの3つの要素を持った配列の配列を作ってます
indexes = pairs_sorted
  .group_by {|pair| pair.term} # 単語を基準にしたグループ(正確には単語をキー、文書IDの配列をバリューとしたハッシュ)を作ってます
  .map do |term, pairs|
    freq = pairs.length
    # term-doc_idのペアからdoc_idだけを抽出して重複を取り除けばポスティングリストの完成
    posting_list = pairs.map {|pair| pair.doc_id}.uniq.sort
    [term, freq, posting_list]
  end

output(indexes, PATH_TO_CURRENT_DIR)
