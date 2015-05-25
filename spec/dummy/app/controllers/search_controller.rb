class SearchController < ApplicationController

	before_action(only: [:sanitized_simple_search]) {|c| c.search_params_sanitizer_defined_in_the_app search_params }

	def simple_search
		if params[:search_params]
			@players = Glasses.search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end

	def sanitized_simple_search
		if params[:sanatized_search_params]
			@players = Glasses.search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end

end
