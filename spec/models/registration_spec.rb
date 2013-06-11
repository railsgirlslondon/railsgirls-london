require 'spec_helper'

describe Registration do
  let(:registration) { Fabricate(:registration) }

  it '#fullname' do
    registration.fullname.should eq "#{registration.first_name} #{registration.last_name}"
  end

  it '#to_s' do
    [ :gender,
      :uk_resident,
      :programming_experience,
      :reason_for_applying,
      :spoken_languages,
      :preferred_language ].each do |information|
        registration.to_s.should include registration.send information
      end
  end
end
