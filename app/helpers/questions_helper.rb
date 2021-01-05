module QuestionsHelper

  def text_with_hashtag_link(text)
    text.gsub(Hashtag::REGEXP) do |ht|
      link_to ht, hashtag_path(ht.delete('#').downcase)
    end.html_safe
  end

  def inclination(num, slon, slona, slonov)
    div10 = num % 10
    div100 = num % 100
    # исключения - возвращаем форму множественного сущ. для чисел 11, 12, 13, 14
    return slonov if [11, 12, 13, 14].include?(div100)
    # сущ. в единственном числе, если число заканчивается на 1(кроме 11, см. выше)
    return slon if div10 == 1
    # форма сущ. для чисел заканчивающихся на 2, 3, 4 (кроме 12, 13, 14, см. выше)
    return slona if [2, 3, 4].include?(div10)
    # форма множественного числа для всех остальных случаев
    slonov
  end
end
