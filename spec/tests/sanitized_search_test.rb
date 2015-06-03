	describe '.sanitized_search()' do

		it 'is vulnerable to SQL injection when totally unprotected' do
			results = Glasses.raw_search(Player, {first_name: "' OR 1 = 1 ) --"})
			(results.size).should == 10
		end

		it 'is not vulnerable to SQL injection when protected' do
			results = Glasses.search(Player, {first_name: "' OR 1 = 1 ) --"})
			(results.size).should == 0
		end

		it 'correctly searches for a result in a sanitized_search' do
			results = Glasses.search(Player, {first_name: "Jane"})
			(results.size).should == 1
		end

		#it 'ensures that search has best performance than sanitized_search' do
		#	start1 = Time.now
		#		Glasses.search(Player, {first_name: "Jane"})
		#	end1 = Time.now
		#	start2 = Time.now
		#		Glasses.sanitized_search(Player, {first_name: "Jane"})
		#	end2 = Time.now
		#	puts (end1.to_f * 1000.0).to_i
		#	puts ((start1.to_f) * 1000.0).to_i
		#	puts (end2.to_f * 1000.0).to_i
		#	puts ((start2.to_f) * 1000.0).to_i
		#	puts ((end1 - start1) * 1000).to_i
		#	puts ((end2.to_f - start2.to_f) * 1000.0).to_i
		#	((end1 - start1) < (end2 - start2)).should == true
		#end

	end