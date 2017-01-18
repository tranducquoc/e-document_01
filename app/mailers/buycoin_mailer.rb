class BuycoinMailer < ApplicationMailer
  def code_coin buycoin
    @buycoin = buycoin
    mail to: buycoin.user.email, subject: t("send_code")
  end
end
