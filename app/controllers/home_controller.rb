require 'date'

class HomeController < ApplicationController

  def create
    begin
      @year = params[:date]['year']
      @month = params[:date]['month']
      @day = params[:date]['day']

      date1 = Date.parse("#{@year}-#{@month}-#{@day}")
      cd = (date1 - 266)
      conception_date = "#{cd.year}/#{num_to_month(cd.month)}/#{cd.day}"
      split_date = conception_date.split('/')
      @conception = "#{split_date[1]} #{split_date[2]}, #{split_date[0]}"
      @event = concept(conception_date)
      render :conception

      return
    rescue
      flash[:notice] = 'Please Enter A Valid Date!'
      redirect_to :back
    end
  end

  def num_to_month(month)
    new_month = case month
                when 1  then "January"
                when 2  then "February"
                when 3  then "March"
                when 4  then "April"
                when 5  then "May"
                when 6  then "June"
                when 7  then "July"
                when 8  then "August"
                when 9  then "September"
                when 10 then "October"
                when 11 then "November"
                when 12 then "December"
                end
    return new_month
  end

  def concept(date)
    req = Curl.get("http://www.historyorb.com/date/" + date)
    result = req.body_str

    index1 = result.index("</h2>")
    index2 = result.index("<p>-", index1) + 5
    index3 = result.index("<", index2) - 1

    event = result[index2..index3]
    
    return event

  end

end
