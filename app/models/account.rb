class Account < ApplicationRecord
  has_many :transactions
  validates :name, :balance, presence: true

  def update_balance(transaction)
    if transaction.kind == 'deposit'
      self.balance = self.balance + transaction.amount
      self.save
    elsif transaction.kind == 'withdraw'
      if self.balance >= transaction.amount
        self.balance = self.balance - transaction.amount
        self.save
      else
        return "Insufficient Funds"
      end
    end
  end
end


# t = Transaction.create(amount:10, kind:'deposit')
# a = Account.first
#
# a.change_balance(t)
