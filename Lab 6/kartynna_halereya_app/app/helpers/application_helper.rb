module ApplicationHelper
    def sort_arrow(column)
      if params[:sort] == column
        params[:order] == "asc" ? "↑" : "↓"
      else
        ""
      end
    end
  end
  