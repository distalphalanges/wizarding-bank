class Bank
  class InsufficientFundsError < StandardError; end
  class NoAccountError < StandardError; end

  attr_reader :name, :total_cash

  def initialize(name)
    @name = name
    @total_cash = 0
  end

  def open_account(person)
    person.open_account(name)
  end

  def deposit(person, amount)
    person.deposit(name, amount)
    @total_cash += amount
  end

  def withdraw(person, amount)
    if sufficient_funds?(person, amount) == false
      raise InsufficientFundsError 
    elsif person.has_account_with?(name) == false
      raise NoAccountError
    else
      person.withdraw(name, amount)
      @total_cash += amount
    end
  end

  def transfer(person, other_bank, amount)
    if person.has_account_with?(name) == false || person.has_account_with?(other_bank.name) == false
      raise NoAccountError
    elsif sufficient_funds?(person, amount) == false
      raise InsufficientFundsError 
    else
      person.transfer(name, other_bank.name, amount)
      @total_cash -= amount
      other_bank.total_cash += amount
    end
  end

  def sufficient_funds?(person, amount)
    person.balance(name) >= amount
  end

  protected

  attr_writer :total_cash
end
