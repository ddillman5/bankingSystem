# Error class for handling errors
class BankError < StandardError
end

# Parent class
class BankAccount
  attr_reader :account_holder, :balance # Get our default variables

  # Default initialize method to setup object
  def initialize(account_holder, starting_balance = 0)
    raise BankError, "Starting balance cannot be negative!" if starting_balance < 0 # Make sure starting balance is non-negative
    @account_holder = account_holder
    @balance = starting_balance # Give our instance variables their values
    @transactions = []
    add_transaction("Account opened with $#{starting_balance}") # Add a transaction to our transactions tracker
  end

  # Function for depositing an amount to an account
  def deposit(amount)
    raise BankError, "Deposit amount must be positive!" if amount <= 0 # Make sure the amount is non-negative
    @balance += amount # Add the amount to our account balance
    add_transaction("Deposited $#{amount}") # Log in our add_transaction
  end

  # Function for withdrawling an amount from our account
  def withdraw(amount)
    raise BankError, "Withdrawal amount must be positive!" if amount <= 0
    # Make sure the withdrawl amount is positive
    raise BankError, "Insufficient funds!" if amount > @balance # Make sure the account has a large enough balance
    @balance -= amount # Subtract the amount from our account balance
    add_transaction("Withdrew $#{amount}") # Log the transaction
  end

  # Function for transferring from one account to another
  def transfer_to(other_account, amount)
    withdraw(amount) # Withdraw the amount from our account
    other_account.deposit(amount) # Deposit the same amount into
    other_account
    add_transaction("Transferred $#{amount} to
#{other_account.account_holder}") # Log transaction
  end

  # Function for providing the account type
  def account_type
    "General Bank Account"
  end

  # Function for printing a statement for an account
  def print_statement
    puts "\nStatement for #{@account_holder}" # Shows the account holder
    puts "Account Type: #{account_type}" # Shows the type of Account
    puts "Current Balance: $#{@balance}" # Shows the current balance
    puts "Transactions:" # Header for list of transactions
    @transactions.each do |transaction| # Loops through transactions and prints
      puts "- #{transaction}"
    end
  end

  protected

  # Function for logging a transaction
  def add_transaction(description)
    @transactions << description
  end
end

# Child class CheckingAccount inherits from BankAccount class
class CheckingAccount < BankAccount

  # Default constructor function
  def initialize(account_holder, starting_balance = 0, overdraft_limit =
        100)
    super(account_holder, starting_balance) # Uses the parent classes initialize method
    @overdraft_limit = overdraft_limit # Set our overdraft_limit value
  end

  # Function for withdrawling an amount from an account
  def withdraw(amount)
    raise BankError, "Withdrawal amount must be positive!" if amount <= 0
    # Make sure the withdrawl amount is positive
    if amount > @balance + @overdraft_limit # If the amount is greater than our balance plus our withdrawl limit, raise error
      raise BankError, "Withdrawal exceeds overdraft limit!"
    end

    # If not, we subtract amount from our balance and log the transaction
    @balance -= amount
    add_transaction("Withdrew $#{amount} using checking account")
  end

  # Function for defining the account type
  def account_type
    "Checking Account"
  end
end

# Child class SavingsAccount inherits from BankAccount class
class SavingsAccount < BankAccount

  # Default initialize function (constructor)
  def initialize(account_holder, starting_balance = 0, interest_rate = 0.03)
    super(account_holder, starting_balance) # Use the initalize function from our parent class BankAccount
    @interest_rate = interest_rate # Set the interest_rate to the correct value
  end

    # Function for applying interest
    def apply_interest
      interest = @balance * @interest_rate # Calculate how much we will make in interest
      @balance += interest # Add this amount to our balance
      add_transaction("Applied interest: $#{interest.round(2)}") # Log the transaction
    end

    # Function for defining the account type
    def account_type
      "Savings Account"
    end
end

  # Bank class will manage multiple accounts
  class Bank
    # Default constructor
    def initialize(name)
      @name = name # Set name
      @accounts = [] # Accounts is an empty array
    end

    # Function add_account adds an account to our array of accounts
    def add_account(account)
      @accounts << account
    end

    # Function to list all of the accounts
    def show_all_accounts
      puts "\n#{@name} Accounts"
      @accounts.each do |account|
        puts "#{account.account_holder} - #{account.account_type} - Balance: $#{account.balance.round(2)}"
      end
    end

    # Function to show the total balance across all accounts
    def total_bank_balance
      @accounts.reduce(0) do |sum, account|
        sum + account.balance
      end
    end

    # Function to show the accounts with a balance over x amount
    def accounts_with_balance_over(amount)
      @accounts.select do |account|
        account.balance > amount
      end
    end
  end

  # Main program for testing
  begin
    bank = Bank.new("Bank of America") # Create a new bank to hold all of our accounts
    dane = CheckingAccount.new("Dane", 500, 200)
    lucy = SavingsAccount.new("Lucy", 1000, 0.03) # Create three people with accounts and specifics
    nora = CheckingAccount.new("Nora", 300, 100)
    bank.add_account(dane)
    bank.add_account(lucy) # Add each account to our bank
    bank.add_account(nora)
    dane.deposit(150) # Account balance = 650
    dane.withdraw(700) # Withdrawaling more than available, but still under balance + withdrawl limit, so no error raised
    lucy.deposit(250) # Account balance = 1250
    lucy.apply_interest # Will output the total amount after interest
    nora.withdraw(50) # Account balance = 250
    dane.transfer_to(nora, 100) # Account balance = 350
    bank.show_all_accounts # Prints all accounts and their balances
    puts "\nTotal money stored in bank:
$#{bank.total_bank_balance.round(2)}" # Prints the total amount across all accounts
    puts "\nAccounts with balance over $400:"
    # Will loop through and determine which accounts have over $400, and will print
    bank.accounts_with_balance_over(400).each do |account|
      puts "- #{account.account_holder}: $#{account.balance.round(2)}"
    end
    dane.print_statement
    lucy.print_statement # Print the list of transactions for each person
    nora.print_statement
  rescue BankError => error
    puts "Bank error: #{error.message}"
  end