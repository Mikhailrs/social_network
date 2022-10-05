module ApplicationHelper
  def inclination(count, one, few, many)
    return many if (count % 100).between?(11, 14)

    case count % 10
    when 1 then "#{count} #{one}"
    when 2..4 then "#{count} #{few}"
    else
      "#{count} #{many}"
    end
  end

end
