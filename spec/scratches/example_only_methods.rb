  def search_within_range(model_to_search,params_hash)
    params_array = params_hash.to_a
    query = ""
    consecutive_ints = 0
    params_array.each_with_index do |pair, index|
      if !pair[1].empty?
        if pair[0].to_s[key.size-3,key.size] == "_id" || pair[] ~= /\A[-+]?[0-9]+\z/ # checks if value is basically an integer within quotes

          possible_query = "#{key} = #{val} AND "
          consecutive_ints += 1
          if consecutive_ints % 2 == 0 #check if the case is of an integer field followed by another

          end
          query += possible_query
        else
          query += "#{key} LIKE '#{val}%' AND " # percent sign matches any string of 0 or more chars.
        end
      end
    end
    if !query.empty?
      query = query[0,query.size-5]
      model_to_search.where(query)
    else
      []
    end
  end