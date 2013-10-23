class MongoConfig
   class << self
      attr_accessor :connection
      attr_accessor :db
   end
end
 
MongoConfig.connection = Mongo::Connection.new("localhost", 27017)
MongoConfig.db = MongoConfig.connection.db("#pef-#{Rails.env}")