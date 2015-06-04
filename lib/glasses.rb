require "glasses/version"

module Glasses

  def self.search(model_to_search,params_hash)
    query = []
    query_params = []
    params_hash.each do |key,val|
      if !val.empty?
        if key.to_s[key.size-3,key.size] == "_id"
          query.push("#{key} = ?")
          query_params.push(val.to_s)
        else
          query.push("#{key} LIKE ?") # percent sign matches any string of 0 or more chars.
          query_params.push(val + "%")
        end
      end
    end
    if !query.empty?
      if query.size == 1
        return model_to_search.where(query.pop(), query_params.pop())
      else
        results = model_to_search.where(query.pop(), query_params.pop())
        (results.size).times do |search|
          results = results.where(query.pop(), query_params.pop()) # important to note that ".where()" is not hitting the database.
        end
        return results
      end
    else
      []
    end
  end

  def self.full_search(model_to_search,params_hash)
    query = []
    query_params = []
    params_hash.each do |key,val|
      if !val.empty?
        if key.to_s[key.size-3,key.size] == "_id"
          query.push("#{key} = ?")
          query_params.push(val.to_s)
        else
          query.push("#{key} LIKE ?") # percent sign matches any string of 0 or more chars.
          query_params.push("%" + val + "%")
        end
      end
    end
    if !query.empty?
      if query.size == 1
        return model_to_search.where(query.pop(), query_params.pop())
      else
        results = model_to_search.where(query.pop(), query_params.pop())
        (results.size).times do |search|
          results = results.where(query.pop(), query_params.pop()) # important to note that ".where()" is not hitting the database.
        end
        return results
      end
    else
      []
    end
  end

    def self.search_range(model_to_search,params_hash)
    query = []
    query_params = []
    params_hash.each do |key,val|
      if !val.empty?
        key_suffix = key.to_s[key.size-3,key.size]
        if key_suffix == "min"
          query.push("#{key[0,key.size-4]} >= ?")
          query_params.push(val.to_s)
        elsif key_suffix == "max"
          query.push("#{key[0,key.size-4]} <= ?")
          query_params.push(val.to_s)
        elsif key_suffix == "_id"
          query.push("#{key} = ?")
          query_params.push(val.to_s)
        else
          query.push("#{key} LIKE ?") # percent sign matches any string of 0 or more chars.
          query_params.push(val + "%")
        end
      end
    end
    if !query.empty?
      if query.size == 1
        return model_to_search.where(query.pop(), query_params.pop())
      else
        results = model_to_search.where(query.pop(), query_params.pop())
        (results.size).times do |search|
          results = results.where(query.pop(), query_params.pop()) # important to note that ".where()" is not hitting the database.
        end
        return results
      end
    else
      []
    end
  end

  def self.full_search_range(model_to_search, params_hash)
    query = []
    query_params = []
    params_hash.each do |key,val|
      if !val.empty?
        key_suffix = key.to_s[key.size-3,key.size]
        if key_suffix == "min"
          query.push("#{key[0,key.size-4]} >= ?")
          query_params.push(val.to_s)
        elsif key_suffix == "max"
          query.push("#{key[0,key.size-4]} <= ?")
          query_params.push(val.to_s)
        elsif key_suffix == "_id"
          query.push("#{key} = ?")
          query_params.push(val.to_s)
        else
          query.push("#{key} LIKE ?") # percent sign matches any string of 0 or more chars.
          query_params.push("%" + val + "%")
        end
      end
    end
    if !query.empty?
      if query.size == 1
        return model_to_search.where(query.pop(), query_params.pop())
      else
        results = model_to_search.where(query.pop(), query_params.pop())
        (results.size).times do |search|
          results = results.where(query.pop(), query_params.pop()) # important to note that ".where()" is not hitting the database on this line.
        end
        return results
      end
    else
      []
    end
  end

  def self.raw_search(model_to_search,params_hash)
    query = ""
    params_hash.each do |key,val|
      if !val.empty?
        if key.to_s[key.size-3,key.size] == "_id"
          query += "#{key} = #{val} AND "
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

  def self.full_raw_search(model_to_search,params_hash)
    query = ""
    params_hash.each do |key,val|
      if !val.empty?
        if key.to_s[key.size-3,key.size] == "_id"
          query += "#{key} = #{val} AND "
        else
          query += "#{key} LIKE '%#{val}%' AND " # percent sign matches any string of 0 or more chars.
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

    def self.raw_search_range(model_to_search,params_hash)
    query = ""
    params_hash.each do |key,val|
      if !val.empty?
        key_suffix = key.to_s[key.size-3,key.size]
        if key_suffix == "min"
          query += "#{key[0,key.size-4]} >= #{val} AND "
        elsif key_suffix == "max"
          query += "#{key[0,key.size-4]} <= #{val} AND "
        elsif key_suffix == "_id"
          query += "#{key} = #{val} AND "
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

  def self.full_raw_search_range(model_to_search, params_hash)
    query = ""
    params_hash.each do |key,val|
      if !val.empty?
        key_suffix = key.to_s[key.size-3,key.size]
        if key_suffix == "min"
          query += "#{key[0,key.size-4]} >= #{val} AND "
        elsif key_suffix == "max"
          query += "#{key[0,key.size-4]} <= #{val} AND "
        elsif key_suffix == "_id"
          query += "#{key} = #{val} AND "
        else
          query += "#{key} LIKE '%#{val}%' AND " # percent sign matches any string of 0 or more chars.
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

  #def self.prioritize_params(column_to_search, entry_to_search)
    # Order params, prioritize ids over ranges and both of these over strings to boost performance.
  #end

end
