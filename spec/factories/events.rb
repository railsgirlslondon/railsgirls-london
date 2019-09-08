# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    active { true }
    starts_on { Date.today + 2.months }
    ends_on { Date.today + 2.months + 1.day }
    title { 'Rails Girls London' }
    registration_deadline_early_bird { Date.today + 1.month }
    registration_deadline { Date.today + 1.month + 25.days }
    image { 'image.png' }
  end
end

