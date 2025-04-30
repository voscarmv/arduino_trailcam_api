class User < ApplicationRecord
  ROLES = %w[admin camera user].freeze
  before_validation :set_default_role, on: :create
  validates :role, inclusion: { in: ROLES }
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :photos, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def unviewed_photos_count
    photos.where(viewed: false).count
  end

  private
  def set_default_role
    self.role ||= "user"
  end
end
