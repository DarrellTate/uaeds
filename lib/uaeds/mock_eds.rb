require 'date'
require 'uaeds/eds'
require 'uaeds/eds_dsml'
require 'uaeds/dsml'
require 'uaeds/dsml_person'

# Provided to ease testing of applications using DSML
module Uaeds
  class MockEdsDSML < EdsDSML


    def initialize
      @mock_overrides = {}
    end

    def self.eds_endpoint=(endpoint=nil)
    end
    
    def self.eds_endpoint
    end

    def set_mock_overrides(dict)
      @mock_overrides = dict
    end

    private

    def open_person(identifier)
      MockDSMLPerson.new(generate_attributes(identifier))
    end

    def generate_attributes(identifier)
      # I'm sure there's a more elegant way to write this, but it's already written.
      return {
        :uid => @mock_overrides[:uid] || "mockuser#{identifier}", # netid
        :uaId => @mock_overrides[:uaId] || ('%012i' % identifier), # 12 digits
        :isoNumber => @mock_overrides[:isoNumber] || ('%016i' % identifier), # cat card, 16 digits
        :emplId => @mock_overrides[:emplid] || ('%08i' % identifier), # also SID, 8 digit
        :cn => @mock_overrides[:cn] || "mock user #{identifier}", # complete name
        :givenName => @mock_overrides[:givenName] || "mock", # First + initial
        :sn => @mock_overrides[:sn] || "user #{identifier}", # surname/last name
        :mail => @mock_overrides[:mail] || "mockuser#{identifier}@example.com", # email
        :eduPersonPrimaryAffiliation => @mock_overrides[:eduPersonPrimaryAffiliation] || "staff", # staff, student, member, etc.
        :employeeTitle => @mock_overrides[:employeeTitle] || "Test Robot",
        :employeePrimaryDept => @mock_overrides[:employeePrimaryDept] || "0000",
        :employeePrimaryDeptName => @mock_overrides[:employeePrimaryDeptName] || "Robot Wing"
      }
    end
    
  end

  class MockDSMLPerson < DSMLPerson

    def initialize(data={})
       @xml = data
       @value_h = {}
    end

    def get_xml_attr(attr)
      return @xml[attr]
    end
  end

end

