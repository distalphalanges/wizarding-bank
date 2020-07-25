require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'

class PersonTest < Minitest::Test
  def test_it_exists
    person1 = Person.new("Minerva", 1000)

    assert_instance_of Person, person1
  end

  def test_it_has_a_name
    # skip
    person1 = Person.new("Minerva", 1000)
    person2 = Person.new("Luna", 500)

    assert_equal "Minerva", person1.name
    assert_equal "Luna", person2.name
  end

  def test_it_has_cash
    # skip
    person1 = Person.new("Minerva", 1000)
    person2 = Person.new("Luna", 500)

    assert_equal 1000, person1.cash
    assert_equal 500, person2.cash
  end

  def test_it_can_have_accounts
    # skip
    person1 = Person.new("Minerva", 1000)

    person1.open_account("JP Morgan Chase")

    assert person1.has_account_with?("JP Morgan Chase")
  end

  def test_accounts_have_balances
    # skip
    person1 = Person.new("Minerva", 1000)
    person1.open_account("JP Morgan Chase")

    assert_equal 0, person1.balance("JP Morgan Chase")
  end

  def test_it_can_deposit_into_accounts
    # skip
    person1 = Person.new("Minerva", 1000)
    person1.open_account("JP Morgan Chase")

    person1.deposit("JP Morgan Chase", 750)

    assert_equal 750, person1.balance("JP Morgan Chase")
    assert_equal 250, person1.cash
  end

  def test_it_can_withdraw_from_accounts
    # skip
    person1 = Person.new("Minerva", 1000)
    person1.open_account("JP Morgan Chase")
    person1.deposit("JP Morgan Chase", 750)

    person1.withdraw("JP Morgan Chase", 250)

    assert_equal 500, person1.balance("JP Morgan Chase")
    assert_equal 500, person1.cash
  end

  def test_it_can_transfer_between_accounts
    # skip
    person1 = Person.new("Minerva", 1000)
    person1.open_account("JP Morgan Chase")
    person1.open_account("Wells Fargo")
    person1.deposit("JP Morgan Chase", 750)

    person1.transfer("JP Morgan Chase", "Wells Fargo", 250)

    assert_equal 250, person1.balance("Wells Fargo")
    assert_equal 500, person1.balance("JP Morgan Chase")
  end
end
