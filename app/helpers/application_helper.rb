module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == session[:mov] ? "current #{params[:direction]}" : nil
    direction = (column == session[:mov] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, movies_path(:mov=> column, :direction=> direction.to_s), {:class => css_class}
  end
end
