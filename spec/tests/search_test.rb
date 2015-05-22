describe Glasses do

  describe 'search' do

    it 'should search for an ActiveRecord model' do

      ((Glasses.search(Player,{first_name: "Jane"})).size).should == 1

    end

    it 'should search for an ActiveRecord model when input is only partial' do

      ((Glasses.search(Player,{first_name: "J"})).size).should == 2 # Jane & Jessica

    end

    it 'should return an empty array if no matches are found' do
      (Glasses.search(Player,{first_name: "HELLOOOOOOO IZE A PLAYAH"})).should == []
    end

  end

end

  #describe 'string-pattern search' do

  #  it 'specialized search quicker than general search' do
  #  	begin1 = Time.now
  #  		Glasses.search(Player,{first_name: "Jane"})
  #  	finish1 = Time.now

  #  	begin2 = Time.now
  #  		Glasses.match_pat(Player,{first_name: "Jane"})
  #  	finish2 = Time.now

  #  	((finish1 - begin1) > (finish2 - begin2)).should == true
  #  end
