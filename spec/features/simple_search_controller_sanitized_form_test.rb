describe "a simple search", type: :feature  do
	
	before :each do
		visit 'sanitized_simple_search'
	end

	it "correctly searches and displays matches" do
		#visit 'sanitized_simple_search'
		fill_in 'First Name:', with: 'Jane'
		click_button "Search"
		page.should have_content 'GR8 SUCCESS'
		page.should have_content '1'
	end

	it "correctly prevents a SQL injection" do
		#visit 'sanitized_simple_search'
		fill_in "First Name:", with: "' OR 1 = 1 ) --"
		click_button "Search"
		page.should have_content "GR8 SUCCESS"
		page.should have_content "1"
	end

end