module ApplicationHelper
  def nice_date(dt)
    dt.nil? ? 'N/A' : dt.strftime('%B %e, %Y')
  end

  def nice_datetime(dt)
    dt.nil? ? 'N/A' : dt.strftime('%B %e, %Y %l:%m %P')
  end
end
