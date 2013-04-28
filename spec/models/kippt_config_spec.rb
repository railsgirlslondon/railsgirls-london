require 'spec_helper'

describe KipptConfig do
  context "#configured?" do
    before do
      subject.username = "some username"
      subject.token = "some token"
      subject.host = "some host"
    end

    it "returns true if all required settings are presnet" do
      subject.configured?.should == true
    end

    [:username, :token, :host].each do |attribute|
      it "returns false if #{attribute} is missing" do
        subject.send("#{attribute}=", nil)
        subject.configured?.should == false
      end
    end
  end
end