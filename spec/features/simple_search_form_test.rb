describe "search within web app", type: :feature  do
	
	context "search params sanitized in ActiveRecord" do

		before :each do
			visit 'simple_search'
		end

		it "correctly searches and displays matches" do
			fill_in 'First Name:', with: 'Jane'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '1'
		end

		#it "is vulnerable to SQL injections when no defenses are present" do
		#	fill_in "First Name:", with: "' OR 1 = 1 ) --"
		#	click_button "Search"
		#	page.should have_content "GR8 SUCCESS"
		#	page.should have_content "10 entries"
		#end

		#context "search with a boolean value as one of the params" do

			it "correctly return values when a boolean value is passed to the form and there are matches" do
				fill_in 'First Name:', with: 'Jane'
				#all('input[type=checkbox]').each { |checkbox| check(checkbox) }
				# forms checkboxes are checked "true" by default.
				click_button 'Search'
				page.should have_content 'GR8 SUCCESS'
				page.should have_content '1'
			end

			it "correctly return values when a boolean value is passed to the form and there are no matches" do
				fill_in 'First Name:', with: 'Rachel'
				#all('input[type=checkbox]').each { |checkbox| check(checkbox) }
				# forms checkboxes are checked "true" by default.
				click_button 'Search'
				#puts page.body
				page.should have_content 'WOPS'
				page.should have_content '0'
			end

		#end

	end

=begin
commented out. This part has become redundant.
	context "search params sanitized in a search method of this gem with built-in defense" do

		before :each do
			visit 'method_sanitized_simple_search'
		end

		it "correctly searches and display matches" do
			fill_in 'First Name:', with: 'Jane'
			click_button 'Search'
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '1'
		end

		it "is not vulnerable to SQL injections when defenses are present" do
			fill_in 'First Name:', with: "' OR 1 = 1 ) --"
			click_button "Search"
			page.should have_content 'WOPS'
			page.should have_content '0'
		end

	end
=end

	context "search params sanitized in a controller method" do

		before :each do
			visit 'controller_sanitized_simple_search'
		end

		it "correctly searches and displays matches" do
			fill_in 'First Name:', with: 'Jan'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '1'
		end

		it "correctly prevents a SQL injection" do
			fill_in "First Name:", with: "' OR 1 = 1 ) --"
			click_button "Search"
			page.should have_content "WOPS"
			page.should have_content "0 entries"
		end

	end

end