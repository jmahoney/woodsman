module Taggable
  extend ActiveSupport::Concern

  #set the model's tags field based on a comma-delimited
  #string of tags
  def tag_list=(str)
    self.tags = str.split(',').map{|t| t.downcase.strip}.uniq
  end
  
  #return the model's tags as a comma-delimited string
  def tag_list
    return "" if self.tags.nil?
    self.tags.join(", ")
  end
  
  module ClassMethods
    #find items with a specific tag
    def tagged(str)
      #nicked from 
      #http://reefpoints.dockyard.com/ruby/2012/09/21/querying-postgresql-datatypes-in-active-record-with-postgres_ext.html
      tag_arel = arel_table
      any_tags_function = Arel::Nodes::NamedFunction.new('ANY', [tag_arel[:tags]])
      predicate = Arel::Nodes::Equality.new(str, any_tags_function)
      sql_statement = tag_arel.project('*').where(predicate).to_sql
      find_by_sql(sql_statement)
    end
    
  end
  
end