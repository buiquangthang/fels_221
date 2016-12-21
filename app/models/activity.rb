class Activity < ApplicationRecord
  belongs_to :user

  delegate :name, to: :user, prefix: :user, allow_nil: true

  validates :user_id, presence: true
  validates :action, presence: true
  validates :source, presence: true

  enum action: [:follow, :unfollow, :had_learn]

  scope :order_by_date, -> {order created_at: :desc}

  after_create_commit { SendmailJob.perform_later self }
end
