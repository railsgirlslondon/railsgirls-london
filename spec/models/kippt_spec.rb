require 'spec_helper'

describe Kippt do

  context "clips" do
    let(:clips) { VCR.use_cassette("kippt_clips") { Kippt.get_clips } }
    let(:clip) { clips.first }

    context "when configured" do
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

    context "when unconfigured" do
      let(:clips) { Kippt.get_clips } 

      before do
        Kippt.configure do |config|
          config.token = nil
        end
      end

      it "returns doesn't request data from Kippt" do
        Net::HTTP.any_instance.should_not_receive(:get)  
      end

      it "returns no clips" do
        clips.length.should == 0
      end
    end
  end
end