module FileLoader
  class << self
    def load(filename)
      content = extract_file_content_as_flat_string(filename)
      content = extract_body_content(content)
      content = remove_navigation_panel(content)
      remove_tags(content)
    end

    def load_as_terms(filename)
      content = self.load(filename)
      to_terms(content)
    end

    private

    # ファイル内のテキストコンテンツを改行を含まない文字列として取得します
    def extract_file_content_as_flat_string(filename)
      File.open(filename) do |file|
        file.read.gsub("\n", '')
      end
    end

    # テキストからbodyタグ内部のテキストを抽出します
    def extract_body_content(content)
      content.match(/<BODY ?>.*?<\/BODY>/)[0]
    end

    # テキストからnavigation panelに当たる部分を取り除きます
    def remove_navigation_panel(content)
      content.gsub(/<!--Navigation Panel-->.*?<!--End of Navigation Panel-->/, '')
    end

    # テキストからタグ(<a>,<img>etc..)を取り除きます
    def remove_tags(content)
      content.gsub(/<.*?>/, '')
    end

    # 空白を基準に単語の配列に変換します
    def to_terms(text)
      text.split(' ')
    end
  end
end
