module ApplicationHelper
  def full_title(page_title)
    base_title = "Potepan".freeze
    page_title.blank? ? base_title : page_title
  end
end
