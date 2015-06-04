describe 'performs a full search on strings, looking for fragments of text instead of prefixes.' do

	context 'performs a full search that is sanitized by ActiveRecord' do

		it 'returns results which contain the fragment' do
			(Glasses.full_search(Player, {first_name: "bb"}).size).should == 1
		end

		it 'returns results which contain the fragment and other parameters' do
			(Glasses.full_search(Player, {first_name: "bb", email: ".com"}).size).should == 1
		end

	end

	context 'performs a full search that is not sanitized by ActiveRecord' do

		it 'returns results which contain the fragment' do
			(Glasses.full_raw_search(Player, {first_name: "bb"}).size).should == 1
		end

		it 'returns results which contain the fragment and other parameters' do
			(Glasses.full_raw_search(Player, {first_name: "bb", email: ".com"}).size).should == 1
		end

	end
	
end