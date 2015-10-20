class Building
  # attr_reader :apartment
  def initialize (address)
    @address = address
    @apartment = []
    @list_of_tenant = []
  end

  def apartment
    @apartment
  end

  def add_apartment(newApartment)
    @apartment << newApartment
  end

  def remove_apartment(apartmentNumber,override)
    @errorReturn = true
    @apartment.each do |x|
      if x.number == apartmentNumber
        if x.tenant.length != 0 && override == false
          raise "apartment #{x.number} has tenant in"
        else
          @apartment.delete(x)
          @errorReturn = false
        end
      end
    end
    raise "No SUCH NUMBER" if errorReturn == false
  end

  def total_square_footage
    @apartment.each{|x| @total_square_footage+=x.squareFootage}
  end

  def total_monthly_revenue
    @apartment.each{|x| @total_monthly_revenue+=x.rent}
  end

  def list_of_tenant
    @apartment.each do |eachApartment|
      eachApartment.tenant.each do |eachTenant|
        @list_of_tenant << eachTenant
      end
    end
  end

  def retrieve_apartment
    @apartment.group_by{|eachApartment| eachApartment.average_credit_score}
  end

  def creditRating(creditScore)
    if creditScore < 560
      @creditRating = "bad"
    elsif creditScore < 660
      @creditRating = "mediocre"
    elsif creditScore < 725
      @creditRating = "good"
    elsif creditScore < 760
      @creditRating = "great"
    elsif creditScore >=760
      @creditRating = "excellent"
    end
  end
end

class Apartment < Building
  def initialize(number,rent,sqFootage,no_bedrooms)
    @number = number
    @rent = rent
    @sqaureFootage = sqFootage
    @no_bedrooms = no_bedrooms
    @tenant = []
  end

  def add_tenant(newTenant)
    if @tenant.length >= @no_bedrooms
      raise "Too many tenants already!"
    elsif newTenant.creditRating != "bad"
      @tenant << newTenant
    elsif newTennat.creditRating == "bad"
      raise "The tenant does not have enough Credit Score"
    end
  end

  def remove_tenant(tenantName)
    if not @tenant.delete_if{|tenant| tenant.name == tenantName}
      raise "apartment does not exist"
    end
  end

  def remove_all_tenant
    @tenant = []
  end

  def tenant
    @tenant
  end

  def creditRating(creditScore)
    if creditScore < 560
      @creditRating = "bad"
    elsif creditScore < 660
      @creditRating = "mediocre"
    elsif creditScore < 725
      @creditRating = "good"
    elsif creditScore < 760
      @creditRating = "great"
    elsif creditScore >=760
      @creditRating = "excellent"
    end
  end

  def update_creditScore
    i = 0
    @tenant.each{|k| i = i + k.creditScore}
    @average_credit_score = i/@tenant.length
    creditRating(@average_credit_score)
  end

  def average_credit_score
    @average_credit_score
  end

end

class Tenant < Apartment
  def initialize(name,age,creditScore)
    @name = name
    @age = age
    @creditScore = creditScore
  end

  def creditRating
    if @creditScore < 560
      @creditRating = "bad"
    elsif @creditScore < 660
      @creditRating = "mediocre"
    elsif @creditScore < 725
      @creditRating = "good"
    elsif @creditScore < 760
      @creditRating = "great"
    elsif @creditScore >=760
      @creditRating = "excellent"
    end
  end

  def creditScore
    @creditScore
  end

  def name
    @name
  end
end

# #new building
mybuilding = Building.new("shatin")

#new apartment
flat_a = Apartment.new(1,10000,300,2)
flat_b = Apartment.new(1,10000,300,2)
#new tenant
frances = Tenant.new('Frances',10,650)
tom = Tenant.new('Tom',20,700)
amy = Tenant.new('Amy',50,800)

mybuilding.add_apartment(flat_a)
mybuilding.add_apartment(flat_b)

flat_a.add_tenant(frances)
flat_a.add_tenant(tom)
flat_a.update_creditScore

flat_b.add_tenant(amy)
flat_b.update_creditScore

mybuilding.retrieve_apartment



