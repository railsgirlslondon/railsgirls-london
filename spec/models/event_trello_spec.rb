require 'spec_helper'

describe EventTrello do
  let(:event) { Fabricate(:event) }
  let(:event_trello) { EventTrello.new(event) }

  it 'creates a trello board' do
    event_trello.should_receive(:add_board)
    event_trello.should_receive(:add_list).with("Applications")
    event_trello.should_receive(:add_cards)

    event_trello.export "Applications"
  end

  describe "matching trello cards" do
    it "returns true if any of the cards match the given name" do
      cards = [ double(:card, name: "Chloe"), double(:card, name: "Maria")]

      event_trello.matches_any_card?(cards, "Maria").should be true
    end

    it "returns false if none of the cards match the given name" do
      cards = [ double(:card, name: "Dave"), double(:card, name: "Nick")]

      event_trello.matches_any_card?(cards, "George").should be false
    end
  end

end
