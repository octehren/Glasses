describe "search params are reordered in a way to give first entrance to quicker queries; the arrays will be .pop()ed, so 'prioritized' == 'last_element' here." do
	
	context "params include strings and ints/bools" do

		it "puts integers before strings" do
			Glasses.prioritize_ints_over_strings(["user_id = ?","first_name LIKE ?", "last_name LIKE ?"], ["666", "Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?", "user_id = ?"],["Rotten", "Johnny", "666"]]
		end

		it "puts booleans before strings" do
			Glasses.prioritize_ints_over_strings(["is_cokehead_bool = ?", "first_name LIKE ?", "last_name LIKE ?"], ["1", "Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?", "is_cokehead_bool = ?"],["Rotten", "Johnny", "1"]]
		end

		it "puts both integers and booleans before strings" do
			Glasses.prioritize_ints_over_strings(["user_id = ?", "is_cokehead_bool = ?", "first_name LIKE ?", "last_name LIKE ?"], ["666", "1", "Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?", "user_id = ?", "is_cokehead_bool = ?"],["Rotten", "Johnny", "666", "1"]]
		end

		it "returns the same query with inverted params if it does not contain more than one kind of input (strings)" do
			Glasses.prioritize_ints_over_strings(["first_name LIKE ?", "last_name LIKE ?"], ["Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?"], ["Rotten", "Johnny"]]
		end

	end

	context "params include strings, ints/bools and ranges" do

		it "puts integers before strings" do
			Glasses.prioritize_ints_over_strings_and_ranges(["user_id = ?","first_name LIKE ?", "last_name LIKE ?"], ["666", "Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?", "user_id = ?"],["Rotten", "Johnny", "666"]]
		end

		it "puts booleans before strings" do
			Glasses.prioritize_ints_over_strings_and_ranges(["is_cokehead_bool = ?", "first_name LIKE ?", "last_name LIKE ?"], ["1", "Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?", "is_cokehead_bool = ?"],["Rotten", "Johnny", "1"]]
		end

		it "puts both integers and booleans before strings" do
			Glasses.prioritize_ints_over_strings_and_ranges(["user_id = ?", "is_cokehead_bool = ?", "first_name LIKE ?", "last_name LIKE ?"], ["666", "1", "Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?", "user_id = ?", "is_cokehead_bool = ?"],["Rotten", "Johnny", "666", "1"]]
		end

		it "puts integers, booleans and ranges before strings" do
			Glasses.prioritize_ints_over_strings_and_ranges(["user_id = ?", "is_cokehead_bool = ?", "age_min >= ?", "age_max <= ?", "first_name LIKE ?", "last_name LIKE ?"], ["666", "1", "2", "456", "Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?", "age_max <= ?", "age_min >= ?", "user_id = ?", "is_cokehead_bool = ?"],["Rotten", "Johnny", "456", "2", "666", "1"]]
		end

		it "puts ints/booleans before ranges" do
			Glasses.prioritize_ints_over_strings_and_ranges(["user_id = ?", "is_cokehead_bool = ?", "age_min >= ?", "age_max <= ?"], ["666", "1", "2", "456"]).should == [["age_max <= ?", "age_min >= ?", "user_id = ?", "is_cokehead_bool = ?"],["456", "2", "666", "1"]]
		end

		it "returns the same query with inverted params if it does not contain more than one kind of input (strings)" do
			Glasses.prioritize_ints_over_strings_and_ranges(["first_name LIKE ?", "last_name LIKE ?"], ["Johnny", "Rotten"]).should == [["last_name LIKE ?", "first_name LIKE ?"], ["Rotten", "Johnny"]]
		end

	end

end