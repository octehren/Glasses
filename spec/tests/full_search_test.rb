describe 'performs a full search on strings, looking for fragments of text instead of prefixes.' do

	context 'performs a full search that is sanitized by ActiveRecord' do

		it 'returns results which contain the fragment' do
			(Glasses.full_search(Player, {first_name: "bb"}).size).should == 1
		end

		it 'returns results which contain the fragment and other parameters' do
			(Glasses.full_search(Player, {first_name: "bb", email: ".com"}).size).should == 1
		end

		it 'does not return anything when no params match any text fragment for that column' do
			(Glasses.full_search(Player, {first_name: "zidbb"}).size).should == 0
		end

		it 'does not return anything when there is no record which matches all the params' do
			(Glasses.full_search(Player, {first_name: "zidbb", email: "@"}).size).should == 0
		end

		it 'returns all the results which satisfies both "field in the range" and "field with text fragment" conditions' do
			(Glasses.full_search_range(Player, {first_name: 'ane', age_min: '110'}).size).should == 1
		end

		context 'performs a full search which includes a range that is not sanitized by ActiveRecord' do

			it 'returns all the results which satisfies both "field in the range" and "field with text fragment" conditions' do
				(Glasses.full_search_range(Player, {first_name: 'ane', age_min: '110'}).size).should == 1
			end

		end

	end

	context 'performs a full search that is not sanitized by ActiveRecord' do

		it 'returns results which contain the fragment' do
			(Glasses.full_raw_search(Player, {first_name: "bb"}).size).should == 1
		end

		it 'returns results which contain the fragment and other parameters' do
			(Glasses.full_raw_search(Player, {first_name: "bb", email: ".com"}).size).should == 1
		end

		it 'does not return anything when no params match any text fragment for that column' do
			(Glasses.full_raw_search(Player, {first_name: "zidbb"}).size).should == 0
		end

		it 'does not return anything when there is no record which matches all the params' do
			(Glasses.full_raw_search(Player, {first_name: "zidbb", email: "@"}).size).should == 0
		end

		context 'performs a full search which includes a range that is not sanitized by ActiveRecord' do

			it 'returns all the results which satisfies both "field in the range" and "field with text fragment" conditions' do
				(Glasses.full_raw_search_range(Player, {first_name: 'ane', age_min: '110'}).size).should == 1
			end
			
		end

	end
	
end