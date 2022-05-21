module ApplicationHelper
  def active_link_to(path, &block)
    link_to path, class: ('active' if current_page?(path)), &block
  end
end
