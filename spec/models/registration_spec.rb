require 'spec_helper'

describe Registration do

  it 'converts the registration to a string' do
    registration = Fabricate(:registration)

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
