require "glasses/version"

module Glasses

  def self.search(model_to_search,params_hash)
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

  def self.sanitized_search(model_to_search,params_hash)
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
      model_to_search.where(ActiveRecord::Base::sanitize(query)) # sanitize_sql() is an Alias for ActiveRecord::Sanitization::ClassMethods#sanitize_sql_for_conditions .
      # Requires rails version 3.2.1 or higher.
    else
      []
    end
  end

  def self.pg_search(model_to_search,params_hash)
    query = ""
    params_hash.each do |key,val|
      if !val.empty?
        if key.to_s[key.size-3,key.size] == "_id"
          query += "#{key} = #{val} AND "
        else
          query += "#{key} ILIKE '#{val}' AND "
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

  def self.match_val(model_to_search, params_hash)
    query = ""
    params_hash.each do |key, val|
      val = "?" if val.empty?
      query = "#{key} = #{val}"
    end
    model_to_search.where(query)
  end

  def self.pg_match_pat(model_to_search, params_hash, att_name)
    query = ""
    params_hash.each do |key, val|
      query = "#{key} ILIKE '#{val}'" if !val.empty?
    end
    if !query.empty?
      model_to_search.where(query)
    else
      []
    end
  end

  def self.mult_val(model_to_search, params_hash)
    query = ""
    params_hash.each do |key,val|
      if !val.empty?
        query += "#{key} = #{val} AND "
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
