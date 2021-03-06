class Customer

  attr_reader :name, :wallet

  def initialize(name, wallet, age, drunkeness=0)
    @name = name
    @wallet = wallet
    @age = age
    @drunkeness = drunkeness
  end

  def legal?
    if @age < 18
      return false
    end
    return true
  end

  def drunk?
    if @drunkeness > 10
      return true
    end
    return false
  end

  def buy_drink(drink_name, pub)
    drink = pub.find_drink_by_name(drink_name)
    if !(legal?)
      return ("Too young, pal")
    elsif drink == nil
      return ("We don't sell that piss here")
    end
      price = drink.cost
      if @wallet < price || drunk?
        return ("Nut")
      end
      if !(pub.has_drink_left?(drink))
        return ("Sorry mate")
      end

    @wallet -= price
    pub.add_to_till(drink)
    pub.decrease_drink_stock_level(drink)
    increase_alcohol_level(drink)
  end

  def increase_alcohol_level(drink)
    alcohol_level = drink.alcohol
    @drunkeness += alcohol_level
  end


  def buy_food(food, pub)
    price = food.cost
    @wallet -= price
    pub.add_to_till(food)
    @drunkeness -= food.rejuvenation_level
  end
end
