class SelectionStateDataMigrator
  def self.migrate!
    Registration.all.each do |registration|
      registration.update_attributes(:selection_state => new_state(registration))
    end
  end

  private
  def self.new_state(registration)
    case (old_state = registration.selection_state)
    when "RGL Weeklies"
      "weeklies"
    when "waiting list"
      "waiting_list"
    when "accepted"
      registration.attending? ? "attending" : old_state
    else
      old_state
    end
  end
end