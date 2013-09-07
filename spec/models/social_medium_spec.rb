require 'spec_helper'

describe SocialMedium do

  context "#validations" do

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }

    it { should validate_uniqueness_of(:name) }

    context "#is_name_valid?" do
      it "complains if the name is not supported" do
        social_medium = SocialMedium.new
        social_medium.url = "http://some/url.com"
        social_medium.name = "random"
        expect { social_medium.save! }.to raise_error
      end

      it "allows gplus facebook and github to be set as social media" do
        city = Fabricate(:city_without_social_media)
        SocialMedium::SUPPORTED.each do |name|
          social_medium = Fabricate.build(:social_medium, name: name, city: city)

          expect(social_medium.save).to eq true
        end
      end
    end
  end
end

