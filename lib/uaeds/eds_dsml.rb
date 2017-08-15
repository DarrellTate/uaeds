module Uaeds
  class EdsDSML < Eds
    include Singleton

    @@eds_dsml_endpoint = nil

    def self.eds_endpoint=(endpoint=nil)
      @@eds_dsml_endpoint = endpoint
    end

    def self.eds_endpoint
      @@eds_dsml_endpoint
    end

    private

    def open_person(identifier)
      # This might be improved with some more handling here and in DSML init.
      if(@user && @password)
        DSMLPerson.new(Nokogiri::XML(open(@url + "/people/#{identifier}", :http_basic_authentication=>[@user, @password])))
      else
        DSMLPerson.new(Nokogiri::XML(open(@url + "/people/#{identifier}")))
      end
    end
  end
end
