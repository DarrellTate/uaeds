module Uaeds
  class EdsJSON < Eds
    include Singleton

    @@eds_json_endpoint = nil

    def person_by_uaid(uaid)
      return open_person('uaId', uaid)
    end

    def person_by_netid(netid)
      return open_person('uid', netid)
    end

    def person_by_emplid(emplid)
      return open_person('emplid', emplid)
    end

    def person(identifier)
      return open_person(nil, identifier)
    end

    def self.eds_endpoint=(endpoint=nil)
      @@eds_json_endpoint = endpoint
    end

    def self.eds_endpoint
      @@eds_json_endpoint
    end

    private

    def open_person(attribute=nil, value)
      raise ArgumentError, "value required." unless (value && value.strip != "")
      if(attribute)
        if(@user && @password)
          JSONPerson.new(handle_stream(open(@url + "/#{value}/#{attribute}.json", :http_basic_authentication=>[@user, @password])))
        else
          JSONPerson.new(handle_stream(open(@url + "/#{value}/#{attribute}.json")))
        end
      else
        if(@user && @password)
            JSONPerson.new(handle_stream(open(@url + "/#{value}.json", :http_basic_authentication=>[@user, @password])))
        else
            JSONPerson.new(handle_stream(open(@url + "/#{value}.json")))
        end
      end
    end

    def handle_stream(stream)
      string = stream.read()
      stream.close()
      JSON.parse(string)
    end

  end
end
