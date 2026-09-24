class UserModel {
  String? name;
  double? balance, income, expenses;

  UserModel({required this.name, required this.balance, required this.income, required this.expenses});

  void withdraw(double amount){
    balance = balance! - amount;
    expenses = expenses! + amount;
  }

  void deposit(double amount){
    balance = balance! + amount;
    income = income! + amount;
  }

  void updateBalance(double oldAmount, double newAmount){
    if (oldAmount > newAmount){
      double difference = oldAmount - newAmount;
      balance = balance! + difference;
    }else{
      double difference = newAmount - oldAmount;
      balance = balance! - difference;
    }
  }
}