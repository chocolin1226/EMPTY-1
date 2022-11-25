class Bank
  attr_reader :balance

  def initialize(amount)
    @balance = amount
  end

  def deposit(amount)
    @balance += amount if amount > 0
  end

  def withdraw(amount)
    return 0 if amount < 0 || enough?(amount)
    @balance -= amount 
    amount
  end

  private

  def enough?(amount)
    balance < amount
  end

end

RSpec.describe Bank do
  describe "存錢功能" do
    it "可以存錢" do
      # 3A 原則
      account = Bank.new(10)
      account.deposit(5)
      expect(account.balance).to be 15
    end

    it "不可以存 0 元或是小於 0 元的金額" do
      account = Bank.new(10)
      account.deposit(-5)
      expect(account.balance).to be 10
    end
  end

  describe "領錢功能" do
    it "可以領錢" do
      account = Bank.new(10)
      amount = account.withdraw(4)

      expect(amount).to be 4
      expect(account.balance).to be 6
    end

    it "不能領 0 元或是小於 0 元的金額" do
      account = Bank.new(10)
      amount = account.withdraw(-2)

      expect(amount).to be 0
      expect(account.balance).to be 10
    end

    it "不能領超過本身餘額" do
      account = Bank.new(10)
      amount = account.withdraw(12)

      expect(amount).to be 0
      expect(account.balance).to be 10
    end

    it "領剛好" do
      account = Bank.new(10)
      amount = account.withdraw(10)

      expect(amount).to be 10
      expect(account.balance).to be 0
    end
  end
end