class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    Money.new(object, "USD").to_s
  end
end
