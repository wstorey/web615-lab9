# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  message    :text
#  visible    :boolean          default(FALSE)
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Comment < ApplicationRecord
  extend FriendlyId

  friendly_id :uuid, use: [:slugged, :finders]

  # devise :databse_authenticatable, :rememberable, :trackable, :validatable

  before_create :generate_uuid
  after_create :manually_update_slug

  belongs_to :article
  belongs_to :user

  validates :message, presence: true

  private

  def generate_uuid
    self.uuid = "#{self.model_name.name}-" + SecureRandom.uuid
  end

  def manually_update_slug
    self.update_column(:slug, self.uuid)
  end
end
