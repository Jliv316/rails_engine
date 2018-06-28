class InvoiceItemSerializer < ActiveModel::Serializer

  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    Money.new(object.unit_price, "USD").to_s
  end
end