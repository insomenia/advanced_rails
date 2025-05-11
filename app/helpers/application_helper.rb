module ApplicationHelper
  def format_date(date, format = :long)
    return "-" unless date

    case format
    when :short
      date.strftime("%Y-%m-%d")
    when :long
      date.strftime("%Y-%m-%d %H:%M")
    when :relative
      time_ago_in_words(date) + " 전"
    else
      date.to_s
    end
  end
end
