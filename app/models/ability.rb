class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, to: :modify

    user ||= User.new

    can :read, :all

    can :create, Item
    ## Can't delete or update someone elses Item
    can :modify, Item, user_id: user.id

    can :create, Bid
    ## Restrict bidding on own item.
    cannot :create, Bid, item: { user_id: user.id }
    ## Can't delete or update someone elses Bid
    can :modify, Bid, user_id: user.id
    
  end
end
