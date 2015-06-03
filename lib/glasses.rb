require "glasses/version"

module Glasses

  def self.search(model_to_search,params_hash)
    query = ""
    query_params = []
    params_hash.each do |key,val|
      if !val.empty?
        if key.to_s[key.size-3,key.size] == "_id"
          query += "#{key} = ? AND "
          query_params.push(val.to_s)
        else
          query += "#{key} LIKE ? AND " # percent sign matches any string of 0 or more chars.
          query_params.push(val + "%")
        end
      end
    end
    if !query.empty?
      query = query[0,query.size-5]
      model_to_search.where(query, query_params)
    else
      []
    end
  end

    def self.search_range(model_to_search,params_hash)
    query = ""
    query_params = []
    params_hash.each do |key,val|
      if !val.empty?
        key_suffix = key.to_s[key.size-3,key.size]
        if key_suffix == "min"
          query += "#{key[0,key.size-4]} >= ? AND "
          query_params.push(val.to_s)
        elsif key_suffix == "max"
          query += "#{key[0,key.size-4]} <= ? AND "
          query_params.push(val.to_s)
        elsif key_suffix == "_id"
          query += "#{key} = ? AND "
          query_params.push(val.to_s)
        else
          query += "#{key} LIKE ? AND " # percent sign matches any string of 0 or more chars.
          query_params.push(val + "%")
        end
      end
    end
    if !query.empty?
      query = query[0,query.size-5]
      model_to_search.where(query, query_params)
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

    def self.raw_search_range(model_to_search,params_hash)
    query = ""
    params_hash.each do |key,val|
      if !val.empty?
        if key_suffix == "min"
          query += "#{key} >= ? AND "
          query_params.push(val.to_s)
        elsif key_suffix == "max"
          query += "#{key} <= ? AND "
          query_params.push(val.to_s)
        elsif key_suffix == "_id"
          query += "#{key} = ? AND "
          query_params.push(val.to_s)
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

end
