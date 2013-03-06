module LyricThiefHelper
  def title_ize name

    not_allowed = ['for', 'and', 'nor', 'but',
                   'or', 'yet', 'so', 'in', 'to',
                   'over', 'an', 'a', 'the']

    result = []

    name.split(' ').each() do | word |
      result << word if not_allowed.include? word
      result << word.capitalize if not not_allowed.include? word
    end

    result[0] = result[0].capitalize

    result.join ' '
  end
end
