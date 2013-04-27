require 'spec_helper'

describe Kippt do

  context "clips" do
    let(:clips) { VCR.use_cassette("kippt_clips") { Kippt.get_clips } }
    let(:clip) { clips.first }

    it "retrieves clips from kippt" do
      clips.length.should == 2
    end

    context "attributes" do
      it "has a title" do
        clip.title.should == "Git Immersion - Brought to you by Neo"
      end

      it "has a link" do
        clip.link.should == "http://gitimmersion.com/"
      end

      it "has a kippt url" do
        clip.kippt_url.should == "/railsgirlslondon/learning-resources/clips/12818298"
      end

    end
  end
end
