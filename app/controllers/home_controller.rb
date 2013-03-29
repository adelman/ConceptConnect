class HomeController < ApplicationController
  def index
  end

  def create
    @year = params[:date]['year']
    @month = params[:date]['month']
    @day = params[:date]['day']

    @date = helper(@year, @month, @day)
    @event = concept(@date)
    render :conception
  end

  def helper(year, month, day)
    year = Integer(year)
    month = Integer(month)
    day = Integer(day)

    days = 0

    if year % 4 == 0
      days = date_to_number_leap(month, day)
    else
      days = date_to_number(month, day)
    end

    if month < 10
      year = year - 1
    end

    days = (days - 266)

    date = Hash.new

    if year % 4 == 0
      days = days % 366
      date = number_to_date_leap(days)
    else
      days = days % 365
      date = number_to_date(days)
    end

    return {"year" => year, "month" => date["month"], "day" => date["day"]}
  end

  def concept(date)
    year = date['year']
    month = date['month']
    day = date['day']

    rest = "#{year}/#{month}/#{day}"
    req = Curl.get("http://www.historyorb.com/date/" + rest)
    result = req.body_str

    index1 = result.index("</h2>")
    index2 = result.index("<p>-", index1) + 5
    index3 = result.index("<", index2) - 1

    event = result[index2..index3]
    
    return event

  end

  def date_to_number(month, day)
    days = case month
      when 1  then day
      when 2  then day + 31
      when 3  then day + 59
      when 4  then day + 90
      when 5  then day + 120
      when 6  then day + 151
      when 7  then day + 181
      when 8  then day + 212
      when 9  then day + 243
      when 10 then day + 273
      when 11 then day + 304
      when 12 then day + 334
    end
    return days
  end
  
  def date_to_number_leap(month, day)
    days = case month
      when 1  then day
      when 2  then day + 31
      when 3  then day + 59 + 1
      when 4  then day + 90 + 1
      when 5  then day + 120 + 1
      when 6  then day + 151 + 1
      when 7  then day + 181 + 1
      when 8  then day + 212 + 1
      when 9  then day + 243 + 1
      when 10 then day + 273 + 1
      when 11 then day + 304 + 1
      when 12 then day + 334 + 1
    end
    return days
  end

    def number_to_date(days)
      date = case
        when days <= 31  then {"month" => "January",   "day" => days}
        when days <= 59  then {"month" => "February",  "day" => (days - 31)}
        when days <= 90  then {"month" => "March",     "day" => (days - 59)}
        when days <= 120 then {"month" => "April",     "day" => (days - 90)}
        when days <= 151 then {"month" => "May",       "day" => (days - 120)}
        when days <= 181 then {"month" => "June",      "day" => (days - 151)}
        when days <= 212 then {"month" => "July",      "day" => (days - 181)}
        when days <= 243 then {"month" => "August",    "day" => (days - 212)}
        when days <= 273 then {"month" => "September", "day" => (days - 243)}
        when days <= 304 then {"month" => "October",   "day" => (days - 273)}
        when days <= 334 then {"month" => "November",  "day" => (days - 304)}
        when days <= 365 then {"month" => "December",  "day" => (days - 334)}
      end
      return date
    end

  def number_to_date_leap(days)
    date = case
      when days <= 31  then {"month" => "January",   "day" => days}
      when days <= 60  then {"month" => "February",  "day" => (days - 31)}
      when days <= 91  then {"month" => "March",     "day" => (days - 60)}
      when days <= 121 then {"month" => "April",     "day" => (days - 91)}
      when days <= 152 then {"month" => "May",       "day" => (days - 121)}
      when days <= 182 then {"month" => "June",      "day" => (days - 152)}
      when days <= 213 then {"month" => "July",      "day" => (days - 182)}
      when days <= 244 then {"month" => "August",    "day" => (days - 213)}
      when days <= 274 then {"month" => "September", "day" => (days - 244)}
      when days <= 305 then {"month" => "October",   "day" => (days - 274)}
      when days <= 335 then {"month" => "November",  "day" => (days - 305)}
      when days <= 366 then {"month" => "December",  "day" => (days - 335)}
    end
    return date
  end





end
