class Index
  attr_reader :term, :frequency, :posting_list

  def initialize(term, frequency, posting_list)
    @term = term
    @frequency = frequency
    @posting_list = posting_list
  end
end
