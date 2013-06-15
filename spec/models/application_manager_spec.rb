require 'spec_helper'

describe ApplicationManager do

  let(:event) { Fabricate(:event) }
  let(:registrations) { 10.times.map { Fabricate(:registration, event: event) } }
  let(:trello) { event.trello }

  it "#process!" do
    trello_api = mock(:api, find_list_by_name: nil, find_or_create_board: nil)
    trello.stub(:trello).and_return(trello_api)
    trello.stub(:applications).and_return([])
    trello.stub(:add_list)

    trello.should_receive(:move_cards_to_list)

    application_manager = ApplicationManager.new(event, 1)
    application_manager.process!
  end

end
