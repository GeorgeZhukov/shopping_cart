module ShoppingCart
  class QuantityValidator < ActiveModel::Validator
    def validate(record)
      if record.product
        unless (1..record.product_in_stock).include? record.quantity
          record.errors[:quantity] << 'Wrong quantity.'
        end
      end
    end
  end

  class OrderItem < ActiveRecord::Base
    include ActiveModel::Validations
    validates_with QuantityValidator

    belongs_to :product, class_name: ShoppingCart.product_class.to_s
    belongs_to :order

    validates :quantity, presence: true
    validates :product, presence: true
    # validates :order, presence: true

    delegate :title, :in_stock, :price, to: :product, prefix: true

    before_save do
      update_price!
    end

    def to_s
      "#{product} x#{quantity}"
    end

    def update_price!
      self.price = product_price * quantity
    end
  end
end
