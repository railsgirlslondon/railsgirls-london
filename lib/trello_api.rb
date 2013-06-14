require 'trello'

class TrelloApi

  include Trello
  include Trello::Authorization

  def initialize
    Trello.configure do |config|
      config.consumer_key = TrelloApi.config.consumer_key
      config.consumer_secret = TrelloApi.config.consumer_secret
      config.oauth_token = TrelloApi.config.oauth_token
      config.oauth_token_secret = nil
    end
  end

  def find_or_create_board name
    board = Trello::Board.all.select { |b| b.name  == name }.first
    return board unless board.nil?
    Trello::Board.create name: name,
                         description: "Applications for #{name}"
  end

  def add_list_to_board name, board
    Trello::List.create name: name,
                        board_id: board.id
  end

  def add_card_to_list name, description, list
    Trello::Card.create name: name,
                        description: description,
                        list_id: list.id
  end

  def find_cards_by_label board, label_name
    board.cards.select { |c| c.labels.map(&:color).include? label_name }
  end

  def self.configure
    yield config
  end

  def self.config
    @_config ||= Config.new
  end

  class Config < Struct.new(:consumer_key, :consumer_secret, :oauth_token)
  end

end
