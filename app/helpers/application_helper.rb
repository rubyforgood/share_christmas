module ApplicationHelper
  def nice_date(dt)
    dt.nil? ? "N/A" : dt.strftime("%B %d, %Y")
  end

  def nice_datetime(dt)
    dt.nil? ? "N/A" : dt.strftime("%B %d, %Y %l:%m %P")
  end
end
