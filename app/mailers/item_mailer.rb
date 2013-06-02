class ItemMailer < ActionMailer::Base
  default from: "shoutsid@gmail.com"

  def item_sold_owner(item, bid)
    @bid = bid
    @bid_user = bid.user
    @item = item
    @item_user = item.user
    mail(to: @item_user.email, subject: "#{@item.name}: Sold! Congrats")
  end

  def item_sold_bidder(item, bid)
    @bid = bid
    @bid_user = bid.user
    @item = item
    @item_user = item.user
    mail(to: @bid_user.email, subject: "#{@item.name}: Won! Congrats")
  end

  def item_not_sold_owner(item)
    @item = item
    @item_user = item.user
    mail(to: @item_user.email, subject: "#{@item.name}: Failed Miserably :(")
  end

end
