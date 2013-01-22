module ApplicationHelper
  def current_user?(user)
    current_user == user
  end

  def mkd
    @mkd ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :hard_wrap => true)
  end

end
