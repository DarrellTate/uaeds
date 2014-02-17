require 'uaeds/mock_eds'


module Uaeds
  
  describe MockEdsDSML, MockDSMLPerson do

    describe 'MockEdsDSML' do
      let(:eds){ MockEdsDSML.instance }
      
      it 'provides an mock instance' do
        expect(eds).to be_an_instance_of MockEdsDSML
      end
    end

    describe 'MockEdsDSML can retrieve a mock person' do
      before{
        @test_id = 1
      }
      let(:person){ MockEdsDSML.instance.person_by_uaid(@test_id) }

      it 'provides a mock person' do
        expect(person).to be_an_instance_of MockDSMLPerson
        expect(person.uaid).to eq('%012i' % @test_id)
        expect(person.first_name).to eq('mock')
      end
    end

    describe 'can override default mock values' do
      before{
        @test_id = 1
        MockEdsDSML.instance.set_mock_overrides({:givenName => 'Larry'})
      }
      let(:person){ MockEdsDSML.instance.person_by_uaid(@test_id) }

      it 'overrode property' do
        expect(person).to be_an_instance_of MockDSMLPerson
        expect(person.uaid).to eq('%012i' % @test_id)
        expect(person.first_name).to eq('Larry')
      end
    end

  end
end


