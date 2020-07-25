class Person
  attr_reader :name, :cash

  def initialize(name, cash)
    @name = name
    @cash = cash
    @accounts = {}
  end

  def open_account(bank_name)
    @accounts[bank_name] = 0
  end

  def balance(bank_name)
    @accounts[bank_name]
  end

  def has_account_with?(bank_name)
    @accounts[bank_name].nil? == false
  end

  def deposit(bank_name, amount)
    @accounts[bank_name] += amount
    @cash -= amount
  end

  def withdraw(bank_name, amount)
    @accounts[bank_name] -= amount
    @cash += amount
  end

  def transfer(from, to, amount)
    @accounts[from] -= amount
    @accounts[to] += amount
  end
end
