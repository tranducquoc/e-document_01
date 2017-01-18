class MonthlyMailer < ApplicationMailer
  def mail_month
    admins = User.email_admin
    @hot_document = Document.get_hot_document
    @hot_user = User.get_hot_user
    mail to: admins.map(&:email).uniq,
      subject: t("statistic_order_admin_end_month")
  end
end
