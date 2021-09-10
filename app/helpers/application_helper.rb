module ApplicationHelper
  def page_title(page_title)
    base_title = "Potepan"
    page_title.empty? ? base_title : page_title
  end
end
