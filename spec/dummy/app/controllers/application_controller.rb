class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #def search_params_sanitizer_defined_in_the_app(search_params)
  	#sanitized_params = {}
  	#search_params.each {|key, val| sanitized_params[key] = ActiveRecord::Base.sanitize(val)}
  	#search_query = ActiveRecord::Base.sanitize(search_params)
  	#return search_query.gsub(/[IS NULL]/, "= ?")
  	#return sanitized_params
  	#return ActiveRecord::Base::sanitize(search_params)
  	#params[:search_params] = search_params.class
  #end
  	  def search_params_sanitizer_defined_in_the_app(search_params)
  	sanitized_params = {}
  	search_params.each {|key, val| sanitized_params[key] = ActiveRecord::Base.sanitize(val)}
  	#search_query = ActiveRecord::Base.sanitize(search_params)
  	#return search_query.gsub(/[IS NULL]/, "= ?")
  	return sanitized_params
  	#search_params = params
  	#params[:search_params] = ActiveRecord::Base::sanitize(params[:search_params])
  	#search_params = search_params.class
  end
# Deprecated 'sanitize_sql_hash_for_conditions' ActiveRecord method. Following, the code's repo: https://github.com/rails/rails/blob/d5902c9e7eaba4db4e79c464d623a7d7e6e2d0e3/activerecord/lib/active_record/sanitization.rb#L89
#  def self.sanitize_sql_hash_for_conditions(attrs, default_table_name = self.table_name)
#    ActiveSupport::Deprecation.warn(<<-EOWARN)
#sanitize_sql_hash_for_conditions is deprecated, and will be removed in Rails 5.0
#        EOWARN
#    attrs = PredicateBuilder.resolve_column_aliases self, attrs
#    attrs = expand_hash_conditions_for_aggregates(attrs)
#    table = Arel::Table.new(table_name, arel_engine).alias(default_table_name)
#    PredicateBuilder.build_from_hash(self, attrs, table).map { |b|
#      connection.visitor.compile b
#      }.join(' AND ')
#    end
end
