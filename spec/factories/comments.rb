# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    sequence(:message) { |n| "message_#{n}" }
    article
    user
  end
end