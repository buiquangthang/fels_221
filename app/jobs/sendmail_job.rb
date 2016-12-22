class SendmailJob < ApplicationJob
  queue_as :default

  def perform(activity)
    user = User.find_by id: activity.user_id
    NotificationMailer.notification_email(user).deliver
  end
end
