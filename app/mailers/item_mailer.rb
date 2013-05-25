class ItemMailer < ActionMailer::Base
  default from: "shoutsid@gmail.com"

  def item_sold(item, bid)
    @bid = bid
    @bid_user = bid.user
    @item = item
    @item_user = item.user

    mail(to: @item_user.email, subject: "#{@item.name}: Sold! Congrats")
  end
  
end
