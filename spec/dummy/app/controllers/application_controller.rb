class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def search_params_sanitizer_defined_in_the_app(search_params)
  	search_query = ActiveRecord::Base.sanitize(search_params)
  	return search_query.gsub(/[IS NULL]/, "= ?")
  end

end
