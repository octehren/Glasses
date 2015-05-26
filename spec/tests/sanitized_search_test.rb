describe Glasses do 

	describe '.sanitized_search()' do

		it 'is vulnerable to SQL injection when totally unprotected' do
			results = Glasses.search(Player, {first_name: "' OR 1 = 1 ) --"})
			(results.size).should == 10
		end

		it 'is not vulnerable to SQL injection when protected' do
			results = Glasses.sanitized_search(Player, {first_name: "' OR 1 = 1 ) --"})
			(results.size).should == 0
		end

		it 'correctly searches for a result in a sanitized_search' do
			results = Glasses.sanitized_search(Player, {first_name: "Jane"})
			(results.size).should == 1
		end

	end

end