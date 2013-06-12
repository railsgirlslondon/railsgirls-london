require 'spec_helper'

describe EventTrello do
  let(:event) { Fabricate(:event) }
  let(:event_trello) { EventTrello.new(event) }

  it 'creates a trello board' do
    event_trello.should_receive(:add_board)
    event_trello.should_receive(:add_applications_list)
    event_trello.should_receive(:add_cards)

    event_trello.export
  end
end
