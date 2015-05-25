describe "a simple search", type: :feature  do
	
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
		page.should have_content "10"
	end

	it "is not vulnerable to SQL injections when defenses are present" do
		fill_in 'First Name:', with: "' OR 1 = 1 ) --"
		click_button "Search"
		page.should have_content 'GR8 SUCCESS'
		page.should have_content '1'
	end

end