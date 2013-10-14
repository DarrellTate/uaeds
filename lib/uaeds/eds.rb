

module Uaeds
  class Eds
    @@eds_user = nil
    @@eds_key = nil
  
    def initialize(url=nil, user=nil, password=nil)
      if(url == nil)
        raise ArgumentError, "EDS URL required." unless (self.class.eds_endpoint && self.class.eds_endpoint.strip != "")
        if(@@eds_user && @@eds_key)
            @user = @@eds_user
            @password = @@eds_key
        end
        @url = self.class.eds_endpoint
      else
        raise ArgumentError, "EDS URL required." unless (url && url.strip != "")
        if(user && password)
            @user = user
            @password = password
        end
        @url = url
      end
    end
    
    
    def person_by_uaid(uaid)
      return open_person(uaid)
    end
    
    def person_by_netid(netid)
      return open_person(netid)
    end
    
    def person_by_emplid(emplid)
      return open_person(emplid)
    end
    
    def person(identifier)
      return open_person(identifier)
    end
    
    def self.eds_user=(user=nil)
      @@eds_user = user
    end
    
    def self.eds_key=(key=nil)
      @@eds_key = key
    end
    
    def self.eds_user
      @@eds_user
    end
    
    def self.eds_key
      @@eds_key
    end
    
    private
    
    def open_persion(idenfifier)
    
    end
  end
end