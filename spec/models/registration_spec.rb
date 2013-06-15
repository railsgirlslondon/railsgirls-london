require 'spec_helper'

describe Registration do
  let(:registration) { Fabricate(:registration) }

  it '#fullname' do
    registration.fullname.should eq "#{registration.first_name} #{registration.last_name}"
  end

  it '#to_s' do
    [ :fullname,
      :gender,
      :uk_resident,
      :programming_experience,
      :spoken_languages,
      :preferred_language ].each do |information|
        registration.to_s.should include registration.send information
      end
  end

  it "#mark_selection" do
    registration.mark_selection "accepted"


    registration.selection_state.should eq "accepted"
  end
end
