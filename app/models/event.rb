class Event < ActiveRecord::Base
  belongs_to :host_city
  attr_accessible :end_date, :start_date

  validates :start_date, presence:true
  validates :end_date, presence:true

  def dates
    "#{start_date.strftime("%e")}-#{end_date.strftime("%e")}th #{start_date.strftime("%B")}"
  end

end
