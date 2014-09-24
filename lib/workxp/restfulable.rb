module Workxp::Restfulable
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    def restful_api(name)
      names = name.pluralize
      define_method "#{names}" do |*args|
        opts = args.first || Hash.new
        valid_token.get("/api/#{names}.json", params: opts, headers: domain_hash).parsed
      end
  
      define_method name do |id|
        valid_token.get("/api/tasks/#{id}.json", headers: domain_hash).parsed
      end
  
      define_method "create_#{name}" do |json|
        valid_token.post("/api/#{names}.json", body: json, headers: domain_hash).parsed
      end
  
      define_method "update_#{name}" do |id, json|
        valid_token.put("/api/#{names}/#{id}.json", body: json, headers: domain_hash).parsed
      end
  
      define_method "delete_#{name}" do |id|
        valid_token.delete("/api/#{names}/#{id}.json", headers: domain_hash).parsed
      end
    end
    
  end
end