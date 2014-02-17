require "uaeds/version"

module Uaeds
  class DSML
    def initialize(xml=nil)
      raise ArgumentError, 'Argument is not numeric' unless xml
      @xml = xml
      @value_h = {}
    end
    
    def get_value(prop_name)
      data = get_xml_attr(prop_name)
      if data.is_a? String
        return data
      elsif data.length == 0
        return nil
      elsif data.length == 1
        return data[0].content
      else
        values = []
        data.each { |value| values.push(value.content) }
        return values
      end
    end
    
    def get_values(prop_name)
      data = get_xml_attr(prop_name)
      if data.length == 0
        return []
      else
        values = []
        data.each { |value| content.push(value.content) }
        return values
      end
    end
    
    def lookup_value(kv)
      if(@value_h.key? kv)
        return @value_h[kv]
      else
        val = get_value(kv)
        if val.nil? || (val.length == 0)
          @value_h[kv] = nil
        else
          @value_h[kv] = val
        end
        @value_h[kv]
      end
    end
    
    private
    
    def get_xml_attr(prop_name)
      @xml.xpath("//dsml:attr[@name='#{prop_name}']/dsml:value")
    end
  end
end