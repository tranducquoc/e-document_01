class CodeCoin < Struct.new(:buycoin)
  def perform
    BuycoinMailer.code_coin(buycoin).deliver
  end
end
