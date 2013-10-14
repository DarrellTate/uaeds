require 'uaeds/eds'
require 'uaeds/eds_dsml'
require 'uaeds/eds_json'
require 'highline/import'

def color(a,b)
  HighLine.color(a,b)
end

module Uaeds
  
  describe EdsDSML, EdsJSON do
    eds_user = nil
    eds_key = nil
    eds_dsml_ep = nil
    eds_json_ep = nil
    eds_0 = nil
    eds_1 = nil
    person_0 = nil
    person_1 = nil
    eds_test_user_netid = nil
    
    describe 'Get access credentials for testing' do
      info_color = [:yellow, :bold]
      question_color = [:green]
      error_color = [:red, :bold]
      
      say(color("To test this library access to an EDS system is required.", info_color))
      say(color("Please provide access credentials and endpoints for", info_color))
      say(color("testing as prompted.\n", info_color))
      
      eds_user = ask(color("EDS user name?", question_color)) do |input|
        input.validate = /.+/
        input.responses[:not_valid] = color("Please provide an EDS user name.", error_color)
        input.responses[:ask_on_error] = ""
      end
      
      eds_key = ask(color("EDS key?", question_color)) do |input|
        input.echo = "*"
        input.validate = /.+/
        input.responses[:not_valid] = color("Please provide an EDS key.", error_color)
        input.responses[:ask_on_error] = ""
      end
      
      eds_dsml_ep = ask(color("DSML endpoint?", question_color)) do |input|
        input.validate = /.+/
        input.responses[:not_valid] = color("Please provide a DSML service endpoint.", error_color)
        input.responses[:ask_on_error] = ""
      end
      
      eds_json_ep = ask(color("JSON endpoint?", question_color)) do |input|
        input.validate = /.+/
        input.responses[:not_valid] = color("Please provide a JSON service endpoint.", error_color)
        input.responses[:ask_on_error] = ""
      end
      
      eds_test_user_netid = ask(color("Please provide a NetID for testing.", question_color)) do |input|
        input.validate = /^\s*[a-zA-Z0-9]{3,16}\s*$/
        input.responses[:not_valid] = color("Please provide a NetID for testing.", error_color)
        input.responses[:ask_on_error] = ""
      end
      
      eds_user.strip!
      eds_key.strip!
      eds_dsml_ep.strip!
      eds_json_ep.strip!
      eds_test_user_netid.strip!
      
      puts(color("\nStarting tests...\n++++++++++++++\n", [:blue, :bold]))
      
      it 'Should have test credentials' do
        expect(eds_user).not_to be_empty
        expect(eds_key).not_to be_empty
        expect(eds_dsml_ep).not_to be_empty
        expect(eds_json_ep).not_to be_empty
      end
      
      Eds.eds_user = eds_user
      Eds.eds_key = eds_key
      EdsDSML.eds_endpoint = "https://#{eds_dsml_ep}"
      EdsJSON.eds_endpoint = "https://#{eds_json_ep}"
      
    end
        
        
    describe 'EdsDSML and EdsJSON retrieve the same results' do
    
      eds0 = EdsDSML.instance
      eds1 = EdsJSON.instance
      
      describe 'EdsDSML and EdsJSON should match when retrieved by NetId' do
        
        person_0 = eds0.person_by_netid(eds_test_user_netid)
        person_1 = eds1.person_by_netid(eds_test_user_netid)
        
        it 'retrieved a DSML person' do
          expect(person_0).to_not be_nil
          expect(person_0).to be_an_instance_of(DSMLPerson)
        end
        
        it 'retrieved a JSON person' do
          expect(person_1).to_not be_nil
          expect(person_1).to be_an_instance_of(JSONPerson)
        end
        
        it 'has the sanem netid' do
          expect(person_1.netid).to eq(person_0.netid)
        end
        
        it 'has the same name' do
          expect(person_0.name).to eq(person_1.name)
        end
        it 'has the same uaid' do
          expect(person_0.uaid).to eq(person_1.uaid)
        end
        it 'has the same emplid' do
          # probably nil
          expect(person_1.emplid).to eq(person_0.emplid)
        end
        
      end

      
      describe 'EdsDSML and EdsJSON should match when retrieved by uaid' do

        person_1 = eds1.person_by_uaid(person_0.uaid)
        
        # Currently uiad's starting with a letter
        # can not be retrieved by the DSML API.
        # person_0 = eds0.person_by_uaid(person_1.uaid)
        
        it 'has the same netid' do
          expect(person_1.netid).to eq(person_0.netid)
        end
        it 'has the same name' do
          expect(person_0.name).to eq(person_1.name)
        end
        it 'has the same uaid' do
          expect(person_0.uaid).to eq(person_1.uaid)
        end
        it 'has the same emplid' do
          expect(person_1.emplid).to eq(person_0.emplid)
        end
        
      end

      describe 'EdsDSML and EdsJSON both retrieve the proper user' do
        it 'has the correct NetIDs' do
          expect(person_1.netid).to eq(eds_test_user_netid)
          expect(person_0.netid).to eq(eds_test_user_netid)
        end
      
      end
      
      describe 'EdsDSML and EdsJSON return nil for undefined attributes' do
        it 'returns nil' do
          expect(person_0.lookup_value('robotDinosaur')).to be_nil
          expect(person_1.lookup_value('robotDinosaur')).to be_nil
        end
      end
      
      describe 'EdsDSML returns nils for all values when blank entry is found' do
        person_2 = eds0.person_by_uaid('T0T0T0T0T0T0T0T0T0T0T0T0')
        it 'has nils' do
          expect(person_2.netid).to be_nil
          expect(person_2.uaid).to be_nil
          expect(person_2.uid).to be_nil
        end
      end
    end
    
  end
end