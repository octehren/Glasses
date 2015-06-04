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
        key = key.to_s
        key_suffix = key[key.size-3,key.size]
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
        prioritized = Glasses.prioritize_ints_over_strings_and_ranges(query, query_params)
        query = prioritized[0]
        query_params = prioritized[1]
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

  def self.prioritize_ints_over_strings(columns_to_search, values_to_search)
    # Order params, prioritize ids over ranges and both of these over strings to boost performance.
    for i in (0..columns_to_search.size-1) do
      if columns_to_search[i][columns_to_search[i].size-3] == "E" #if it's a "like" statement
        columns_to_search.insert(0, columns_to_search.delete_at(i))
        values_to_search.insert(0, values_to_search.delete_at(i))
      end
    end
    return [columns_to_search, values_to_search]
  end

  def self.prioritize_ints_over_strings_and_ranges(columns_to_search, values_to_search)
    # Order params, prioritize ids over ranges and both of these over strings to boost performance.
    string_shifts = 0
    total_columns = columns_to_search.size - 1
    for i in (0..total_columns) do
      if columns_to_search[i][columns_to_search[i].size-3] == "E" #if it's a "like" statement
        columns_to_search.insert(0, columns_to_search.delete_at(i))
        values_to_search.insert(0, values_to_search.delete_at(i))
        string_shifts += 1
      end
    end
    if string_shifts < total_columns
      for i in (string_shifts..columns_to_search.size - 1) do
        if columns_to_search[i][columns_to_search[i].size-4] != " " #if it's a "like" statement
          columns_to_search.insert(0, columns_to_search.delete_at(i))
          values_to_search.insert(0, values_to_search.delete_at(i))
        end
      end
    end
    return [columns_to_search, values_to_search]
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

end
