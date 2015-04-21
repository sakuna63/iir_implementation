require "#{__dir__}/searcher"
require "#{__dir__}/fileloader"

PATH_TO_CHAPS_DIR = "#{PATH_TO_CURRENT_DIR}/../../chaps/"

module Calculater
  class << self
    def word_count_in_dictionary
      File.read("#{PATH_TO_CURRENT_DIR}/../iir.index").count("\n")
    end

    # document frequency
    def df(term)
      index = Searcher::search(term)
      index.posting_list.length
    end

    # term frequency
    def tf(term, doc_id)
      Dir.glob("#{PATH_TO_CHAPS_DIR}/#{doc_id}.*html")
        .map { |filename| FileLoader.load_as_terms(filename) }
        .flatten
        .select {|t| t == term}
        .length
    end
  end
end
