require "simple_summary/version"

class Summary
  def self.get_dummary_ratio content, summary
    100 - (100 * (summary.length.to_f / content.to_f))
  end

  def self.squash content
    sentences_dic = self.get_senteces_ranks(content)
    summary = self.get_summary(content, sentences_dic)
  end

  private

  def self.split_content_to_sentences content
    content.gsub("\n",". ").split(". ")
  end

  def self.split_content_to_paragraphs content
    content.split("\n\n")
  end

  def self.sentences_intersection sent1, sent2
    (sent1.scan(/./) & sent2.scan(/./)).length.to_f / ((sent1.length + sent2.length).to_f / 2.0).to_f || 0
  end

  def self.format_sentence sentence
    sentence.gsub(/[^0-9a-z ]/i, '')
  end

  def self.get_senteces_ranks content
    sentences = self.split_content_to_sentences(content)
    n = sentences.count
    values = Array.new(n, 0) { Array.new(n, 0) }

    for i in 0..n-1
      for j in 0..n-1
        values[i][j] = self.sentences_intersection(sentences[i], sentences[j])
      end
    end

    sentences_dic = {}
    for i in 0..n-1
      score = 0
      for j in 0..n-1
        next if i == j
        score += values[i][j]
        sentences_dic[self.format_sentence(sentences[i])] = score
      end
    end
    sentences_dic
  end

  def self.get_best_sentence paragraph, sentences_dic
    # Split the paragraph into sentences
    sentences = self.split_content_to_sentences(paragraph)
    best_sentence = ""
    max_value = 0
    # Ignore short paragraphs
    if sentences.count > 2
      # Get the best sentence according to the sentences dictionary
      for s in sentences
        strip_s = self.format_sentence(s)
        if strip_s
          if sentences_dic[strip_s] > max_value
            max_value = sentences_dic[strip_s]
            best_sentence = s
          end
        end
      end
    end

    best_sentence
  end

  def self.get_summary content, sentences_dic
    # Split the content into paragraphs
    paragraphs = self.split_content_to_paragraphs(content)

    # Add the title
    summary = []

    # Add the best sentence from each paragraph
    for p in paragraphs
      sentence = self.get_best_sentence(p, sentences_dic).strip()
      if sentence
        summary.push(sentence)
      end
    end    

    summary.join("\n")
  end
end
