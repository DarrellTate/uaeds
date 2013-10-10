require 'uaeds/version'
require 'open-uri'
require 'nokogiri'
require 'uaeds/eds'
require 'uaeds/dsml_person'

module Uaeds
  class EdsDSML < Eds
    
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
