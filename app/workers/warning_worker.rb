class WarningWorker
  include Sidekiq::Worker

  def perform
    UserMailer.send_email.deliver_now
  end
end
