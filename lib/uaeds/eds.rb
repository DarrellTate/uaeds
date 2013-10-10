

module Uaeds
  class Eds
    def initialize(url, user=nil, password=nil)
      raise ArgumentError, "EDS URL required." unless (url && url.strip != "")
      if(user && password)
        @user = user
        @password = password
      end
      @url = url
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
    
    private
    
    def open_persion(idenfifier)
    
    end
  end
end