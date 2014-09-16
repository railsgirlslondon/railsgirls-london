class AddCoachesMailingListToCity < ActiveRecord::Migration
  def change
    add_column :cities, :coaches_mailing_list, :string
  end
end
