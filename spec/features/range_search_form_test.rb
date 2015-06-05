describe "search with a range constraint within web app", type: :feature  do

	context 'search with params sanitized by ActiveRecord' do

		before :each do
			visit 'range_search'
		end

		it 'returns all the results with a field bigger than or equal to some arbitrary value' do
			fill_in 'Minimum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '3'
		end

		it 'returns all the results with a field lesser than or equal to some arbitrary value' do
			fill_in 'Maximum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '8'
		end

		it 'returns all the results with a field bigger than or equal to some arbitrary value and with another field lesser than or equal to some other arbitrary value' do
			fill_in 'Minimum Age:', with: '20'
			fill_in 'Maximum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '8'
		end

		it 'returns all the results which satisfies both "field in the range" and "field with same prefix" conditions' do
			fill_in 'First Name:', with: 'Jane'
			fill_in 'Minimum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '1'
		end

	end

	context 'search without params sanitized by ActiveRecord' do

		before :each do
			visit 'raw_range_search'
		end

		it 'returns all the results with a field bigger than or equal to some arbitrary value' do
			fill_in 'Minimum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '3'
		end

		it 'returns all the results with a field lesser than or equal to some arbitrary value' do
			fill_in 'Maximum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '8'
		end

		it 'returns all the results with a field bigger than or equal to some arbitrary value and with another field lesser than or equal to some other arbitrary value' do
			fill_in 'Minimum Age:', with: '20'
			fill_in 'Maximum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '8'
		end

		it 'returns all the results which satisfies both "field in the range" and "field with same prefix" conditions' do
			fill_in 'First Name:', with: 'Jane'
			fill_in 'Minimum Age:', with: '110'
			click_button "Search"
			page.should have_content 'GR8 SUCCESS'
			page.should have_content '1'
		end

	end

end