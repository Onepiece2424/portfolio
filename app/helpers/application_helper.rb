module ApplicationHelper
  BASE_TITLE = "Potepan".freeze
  def full_title(page_title)
    page_title.blank? ? BASE_TITLE : page_title
  end
end
