class SearchController < ApplicationController

	#include Glasses

	def simple_search
		if params[:search_params]
			@players = Glasses.search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end
end
