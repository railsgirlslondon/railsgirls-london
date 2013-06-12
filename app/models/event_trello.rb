class EventTrello
  attr_reader :event, :board, :list

  def initialize event
    @event = event
  end

  def export
    add_board
    add_applications_list
    add_cards
  end

  private

  def trello
    @trello ||= TrelloApi.new
  end

  def add_board
    @board = trello.find_or_create_board "#{event.city_name} #{event.dates}"
  end

  def add_applications_list
    @list = trello.add_list_to_board "Applications", board
  end

  def add_cards
    event.registrations.each { |r| add_card r.reason_for_applying, r.to_s }
  end

  def add_card name, description
    trello.add_card_to_list name, description, list
  end

end
