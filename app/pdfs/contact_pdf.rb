class ContactPdf < Prawn::Document
  def initialize(donor, timeframe, sortby, topn, user)
    super(:page_layout => :landscape) #makes report landscape
    @donors = donor
    @timeframe = timeframe
    @sortby = sortby
    @topn = topn
    @user = user
    header
    text_content
    table_content
  end

  def header
    image ReportsHelper.report_logo, 
    width: 40, height: 40
    move_up 30
    text "Full Contact Donors Report", size: 24, style: :bold, :align => :center  
  end
  
  def text_content
    y_position = cursor - 20

    bounding_box([0, y_position], :width => 658, :height => 50) do
      text "This Gift Garden report created " + Time.zone.now.to_date.to_s + 
      " by " + @user['username'].to_s + ".", size: 15
      text "Report options: " + timeframe_exalanation(@timeframe) + 
       "," + topn_explanation(@topn) +  "sorted by " + @sortby.to_s + ".", size: 15
    end
  end
  
  def table_content
    table donor_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      #width is 720px total
    self.column_widths = [60, 485, 90, 85] #720 total
      style(column(3), align: :right)
    end
  end
  
  def donor_rows
    [['ID', 'Donor Information', 'Last Gift Date', 'Gift Total']] +
      @donors.map do |donor|
        
      if donor.address2.to_s.length > 0
        donor.address = donor.address + "\n" + donor.address2
      end
        
      ["DON" + donor.id.to_s, 
      donor.first_name.to_s + " " + donor.last_name.to_s + "\n" + 
      donor.address.to_s + "\n" + 
      donor.city.to_s + ", " + donor.state.to_s + " " + donor.zip.to_s + "\n" + 
      donor.phone.to_s + "\n" + 
      donor.email.to_s,
      donor.title,
      format_currency(donor.nickname, false)]
    end
  end
  
  #custom currency formatting method for reports
  #handles any monetary amounts under $1bn
  def format_currency(amount, chopOff)
    if amount.length > 0
      result = amount.to_s
      if chopOff
        2.times do result.chop! end #takes off the .0
      end
      if result.length <= 3
        result = "$" + result
      elsif result.length >= 4 && result.length <=6
        idx = result.length - 3
        result = "$" + result[0,idx] + "," + result[(idx)..(idx + 2)]
      elsif result.length >= 7 && result.length <=9
        idx = result.length - 6
        result = "$" + result[0,idx] + "," + result[(idx)..(idx + 2)] + "," + 
          result[(idx + 3)..(idx + 5)]
      end
      return result
    else
      return ''
    end
  end
  
  #timeframe 'more-English-like' conversion
  def timeframe_exalanation(range)
    result = ""
    case range
      when "All"
        result += "All Donors listed"
      when "This Year"
        result += "This year's Donors"
      when "This Quarter"
        result += "This quarter's Donors"
      when "This Month"
        result += "This month's Donors"
      when "Last Year"
        result += "Last year's Donors"
      when "Last Quarter"
        result += "Last quarter's Donors"
      when "Last Month"   
        result += "Last month's Donors"
      when "Past 2 Years"
        result += "Donors from " + Time.now.year.to_s + " and " + 
          (Time.now.year - 1).to_s
      when "Past 5 Years"
        result += "Donors from " + (Time.now.year - 4).to_s + " to " + 
          Time.now.year.to_s
      when "Past 2 Quarters"
        result += "Donors from the Past 2 quarters"
      when "Past 3 Months"
        result += "Donors from the Past 3 months"
      when "Past 6 Months"
        result += "Donors from the Past 6 months"
    end
    result
  end
  
  #topn 'more-English-like' conversion
  def topn_explanation(range)
    result = " "
    case @topn
    when 'all'
      result += ""
    when '10'
      result += "Top 10 Donors "
    when '20'
      result += "Top 20 Donors "
    when '50'
      result += "Top 50 Donors "
    when '100'
      result += "Top 100 Donors "
    end
    result
  end
end
