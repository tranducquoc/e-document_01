class MonthlyMailer < ApplicationMailer
  def mail_month
    admins = User.email_admin
    current_date = Time.now - Settings.number_seven_2
    @count_download_month = Download.all.count
    @count_upload_month = Document.all.count
    mail to: admins.map(&:email).uniq,
      subject: t("statistic_order_admin_end_month")
  end
end
