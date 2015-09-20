# it{ should have_many :orders }
# it{ should belong_to :billing_address }
# it{ should belong_to :shipping_address }
# it{ should have_many :addresses }

# describe "#cart" do
#   it "returns an order which has state :in_progress" do
#     expect(subject.cart.state).to eq "in_progress"
#   end
#
#   it "creates a new order if no orders with state :in_progress"
#
#   it "returns the order which has state :in_progress" do
#     Order.destroy_all
#     order = create :order, user: subject
#     expect(subject.cart).to eq order
#   end
# end
#
# describe "#move_addresses_to" do
#   it "changes addresses user_id"
# end
#
# describe "#move_orders_to" do
#   let(:book) { create :book }
#   let(:user2) { create :user }
#
#   it "move shopping cart items from user1 to user2" do
#     subject.cart.add_book book
#     expect { subject.move_orders_to user2 }.to change{ user2.cart.empty? }.from(true).to(false)
#   end
#
#   it "changes user_id for other orders" do
#     subject.cart.add_book book
#     order = subject.cart
#     order.checkout!
#     order.confirm!
#     order.finish!
#     expect { subject.move_orders_to user2 }.to change{ user2.orders.where.not(state: :in_progress).count }.by(1)
#   end
# end