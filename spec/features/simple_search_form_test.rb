describe "a simple search", type: :feature  do
	
	context "search params not sanitized" do

		before :each do
			visit 'simple_search'
		end

		it "correctly searches and displays matches" do
			fill_in 'First Name:', with: 'Jane'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '1'
		end

		it "is vulnerable to SQL injections when no defenses are present" do
			fill_in "First Name:", with: "' OR 1 = 1 ) --"
			click_button "Search"
			page.should have_content "GR8 SUCCESS"
			page.should have_content "10 entries"
		end

	end

	context "search params sanitized in a search method of this gem with built-in defense" do

		before :each do
			visit 'method_sanitized_simple_search'
		end

		it "is not vulnerable to SQL injections when defenses are present" do
			fill_in 'First Name:', with: "' OR 1 = 1 ) --"
			click_button "Search"
			page.should have_content 'WOPS'
			page.should have_content '0'
		end

	end

	context "search params sanitized in a controller method" do

		before :each do
			visit 'sanitized_simple_search'
		end

		it "correctly searches and displays matches" do
			fill_in 'First Name:', with: 'Jane'
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