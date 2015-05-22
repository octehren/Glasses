require 'test_helper'

#describe Glasses do

#  describe '.search' do

#    it "should search for an ActiveRecord model" do
#      expect(Glasses.search(Player, {first_name: "Jane"}).size).to eq 1
#    end

#  end

#end

class GlassesSearchTest < ActionController:TestCase
	test "should search for an ActiveRecord model" do
		assert(Glasses.search(Player, {first_name: "Jane"}).size == 1)
	end
end