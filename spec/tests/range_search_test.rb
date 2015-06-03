describe 'search entries which have a value within a specific range' do
	
	context 'search with params sanitized by ActiveRecord' do

		it 'returns all the results with a field bigger than or equal to some arbitrary value' do
			(Glasses.search_range(Player, {age_min: '110'}).size).should == 3
		end

		it 'returns all the results with a field lesser than or equal to some arbitrary value' do
			(Glasses.search_range(Player, {age_max: '110'}).size).should == 8
		end

		it 'returns all the results with a field bigger than or equal to some arbitrary value and with another field lesser than or equal to some other arbitrary value' do
			(Glasses.search_range(Player, {age_min: '20', age_max: '110'}).size).should == 4
		end

		it 'returns all the results which satisfies both "field in the range" and "field with same prefix" conditions' do
			(Glasses.search_range(Player, {first_name: 'Jane', age_min: '110'}).size).should == 1
		end

	end

	context 'search without params sanitized by ActiveRecord' do

		it 'returns all the results with a field bigger than or equal to some arbitrary value' do
			(Glasses.raw_search_range(Player, {age_min: '110'}).size).should == 3
		end

		it 'returns all the results with a field lesser than or equal to some arbitrary value' do
			(Glasses.raw_search_range(Player, {age_max: '110'}).size).should == 8
		end

		it 'returns all the results with a field bigger than or equal to some arbitrary value and with another field lesser than or equal to some other arbitrary value' do
			(Glasses.raw_search_range(Player, {age_min: '20', age_max: '110'}).size).should == 4
		end

		it 'returns all the results which satisfies both "field in the range" and "field with same prefix" conditions' do
			(Glasses.raw_search_range(Player, {first_name: 'Jane', age_min: '110'}).size).should == 1
		end

	end

end