describe "a simple search", type: :feature  do
	
	before :all do
		visit 'simple_search'
	end

	it "correctly searches and displays matches" do
		fill_in 'First Name:', with: 'Jane'
		click_button "Search"
		page.should have_content 'GR8 SUCCESS'
		page.should have_content '1'
	end
end