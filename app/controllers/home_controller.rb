require 'rubygems'
require 'curb'
require 'curb-fu'

class HomeController < ApplicationController
  def index
  end

  def create
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
    @date = date(@year, @month, @day)
    @event = concept(@year, @month, @day)
    render :conception
  end

  def date(year, month, day)
    year = Integer(year)
    month = Integer(month)
    day = Integer(day)

    if month < 10
        year = year - 1
    end

    new_month = month_conversion(month)

    date = "#{new_month}, #{day} #{year}".capitalize!

    return date
  end

  def concept(year, month, day)
    year = Integer(year)
    month = Integer(month)
    day = Integer(day)

    if month < 10
        year = year - 1
    end

    new_month = month_conversion(month)

    rest = "#{year}/#{new_month}/#{day}"
    req = Curl.get("http://www.historyorb.com/date/" + rest)
    result = req.body_str

    index1 = result.index("</h2>")
    index2 = result.index("<p>-", index1) + 5
    index3 = result.index("<", index2) - 1

    event = result[index2..index3]
    
    return event#, date]

  end

  def month_conversion(month)
    if month < 10
        new_month = (month - 9) % 12
    else
        new_month = month - 9
    end

    if new_month == 1
        return "january"
    elsif new_month == 2
        return "february"
    elsif new_month == 3
        return "march"
    elsif new_month == 4
        return "april"
    elsif new_month == 5
        return "may"
    elsif new_month == 6
        return "june"
    elsif new_month == 7
        return "july"
    elsif new_month == 8
        return "august"
    elsif new_month == 9
        return "september"
    elsif new_month == 10
        return "october"
    elsif new_month == 11
        return "november"
    elsif new_month == 12
        return "december"
    else
        return "not valid"
    end

  end

end
