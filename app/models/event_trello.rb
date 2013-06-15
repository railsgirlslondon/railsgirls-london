class EventTrello
  attr_reader :event, :board, :list

  def initialize event
    @event = event
  end

  def export list
    add_board
    add_list list
    add_cards
  end

  def add_list list_name
    @list ||= trello.add_list_to_board list_name, board
  end

  def move_cards_to_list list_name, label
    trello.find_and_move_cards_to_list board, list_name, label
  end

  def applications
    trello.find_list_by_name(board, "Applications").cards
  end

  def trello
    @trello ||= TrelloApi.new
  end

  def matches_any_card? cards, name
    cards.select { |c| c.name; c.name == name }.any?
  end

  private

  def board
    @board ||= trello.find_or_create_board board_name(event)
  end

  def add_board
    board
  end

  def add_cards
    event.registrations.each { |r| add_card r.reason_for_applying, r.to_s }
  end

  def add_card name, description
    trello.add_card_to_list name, description, list
  end

  def board_name event
    "#{event.city_name} #{event.dates}"
  end

end
