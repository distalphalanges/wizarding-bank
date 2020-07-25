require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'

class BankTest < Minitest::Test
  def test_it_exists
    chase = Bank.new("JP Morgan Chase")

    assert_instance_of Bank, chase
  end

  def test_it_has_a_name
    # skip
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")

    assert_equal "JP Morgan Chase", chase.name
    assert_equal "Wells Fargo", wells_fargo.name
  end

  def test_it_can_open_accounts
    # skip
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)

    chase.open_account(person1)
    
    assert person1.has_account_with?(chase.name)
    assert_equal 0, person1.balance(chase.name)
  end

  def test_it_can_accept_deposits
    # skip
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)

    chase.deposit(person1, 750)

    assert_equal 750, person1.balance(chase.name)
  end

  def test_it_can_perform_withdrawals
    # skip
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    chase.deposit(person1, 750)

    chase.withdraw(person1, 250)

    assert_equal 500, person1.balance(chase.name)
  end

  def test_it_wont_allow_overdrafting
    # skip
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    chase.deposit(person1, 750)

    assert_raises(Bank::InsufficientFundsError) { chase.withdraw(person1, 25000) }
    assert_equal 750, person1.balance(chase.name)
  end

  def test_it_can_transfer_to_other_banks
    # skip
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    wells_fargo.open_account(person1)
    chase.deposit(person1, 750)
  
    chase.transfer(person1, wells_fargo, 250)

    assert_equal 500, person1.balance(chase.name)
    assert_equal 250, person1.balance(wells_fargo.name)
  end

  def test_it_wont_transfer_more_than_the_balance
    # skip
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    wells_fargo.open_account(person1)
    chase.deposit(person1, 750)
  
    assert_raises(Bank::InsufficientFundsError) { chase.transfer(person1, wells_fargo, 25000) }
    assert_equal 750, person1.balance(chase.name)
    assert_equal 0, person1.balance(wells_fargo.name)
  end

  def test_it_wont_transfer_to_or_from_nonexistent_accounts
    # skip
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    chase.deposit(person1, 750)
  
    assert_raises(Bank::NoAccountError) { chase.transfer(person1, wells_fargo, 250) }
    assert_raises(Bank::NoAccountError) { wells_fargo.transfer(person1, chase, 250) }
    assert_equal 750, person1.balance(chase.name)
  end

  def test_it_has_a_total_cash_amount
    # skip
    chase = Bank.new("JP Morgan Chase")

    assert_equal 0, chase.total_cash

    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    chase.deposit(person1, 750)

    assert_equal 750, chase.total_cash

    wells_fargo = Bank.new("Wells Fargo")
    wells_fargo.open_account(person1)
    chase.transfer(person1, wells_fargo, 250)

    assert_equal 500, chase.total_cash
    assert_equal 250, wells_fargo.total_cash
  end
end
