describe 'search entries which have a value within a specific range' do
	
	it 'returns all the results with a field bigger than or equal to some arbitrary value' do
		(Glasses.search_range(Player, {age_min: '110'}).size).should == 3
	end

	it 'returns all the results with a field lesser than or equal to some arbitrary value' do
		(Glasses.search_range(Player, {age_max: '110'}).size).should == 8
	end

	it 'returns all the results with a field bigger than or equal to some arbitrary value and with another field lesser than or equal to some other arbitrary value' do
		(Glasses.search_range(Player, {age_min: '20', age_max: '110'}).size).should == 4
	end

end