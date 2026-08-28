# Ruby Banking System

A console-based banking system developed in Ruby as a final course project. The application demonstrates object-oriented programming principles by modeling different bank account types, transactions, and bank operations.

## Features

* Create and manage checking and savings accounts
* Deposit and withdraw funds
* Transfer money between accounts
* Track transaction history for each account
* Apply interest to savings accounts
* Support overdraft limits for checking accounts
* Calculate the total balance across all bank accounts
* Filter accounts based on account balance
* Generate account statements
* Handle invalid banking operations with custom exceptions

## Object-Oriented Programming Concepts

The project demonstrates several OOP concepts, including:

* **Inheritance** – `CheckingAccount` and `SavingsAccount` inherit functionality from `BankAccount`
* **Polymorphism** – Different account types provide their own implementations of methods such as `account_type`
* **Method Overriding** – `CheckingAccount` overrides the default withdrawal behavior to support overdrafts
* **Encapsulation** – Account data and transaction history are managed through account methods
* **Exception Handling** – A custom `BankError` exception handles invalid deposits, withdrawals, balances, and overdraft attempts

## Classes

### `BankAccount`

The parent class containing common banking functionality, including deposits, withdrawals, transfers, transaction tracking, and account statements.

### `CheckingAccount`

Extends `BankAccount` and adds support for an overdraft limit.

### `SavingsAccount`

Extends `BankAccount` and allows interest to be calculated and applied to the account balance.

### `Bank`

Manages multiple accounts and provides operations for displaying accounts, calculating the bank's total balance, and finding accounts above a specified balance.

### `BankError`

A custom exception used to handle invalid banking operations.

## Technologies

* Ruby
* Object-Oriented Programming

## Purpose

This project was created as a university programming final project to demonstrate Ruby fundamentals and object-oriented programming concepts through a practical banking application.
