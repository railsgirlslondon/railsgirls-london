require 'spec_helper'

describe EventTrello do
  let(:event) { Fabricate(:event) }
  let(:event_trello) { EventTrello.new(event) }

  it 'creates a trello board' do
    event_trello.should_receive(:add_board)
    event_trello.should_receive(:add_list)
    event_trello.should_receive(:add_cards)

    event_trello.export
  end

  it "moves filtered cards to list" do
    VCR.use_cassette("move_cards") do
      event_trello.stub(:board_name).and_return("test Lorem Ipsum Dolor 5")
      event_trello.move_cards_to_list "Accepted", "purple"

      event_trello.find_list("Accepted").should have(1).cards
    end
  end

end
