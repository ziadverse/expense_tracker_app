import 'package:expense_tracker_app/app/routes/app_routes.dart';
import 'package:expense_tracker_app/core/extensions/num_extensions.dart';
import 'package:expense_tracker_app/core/services/database_services.dart';
import 'package:expense_tracker_app/features/home/data/models/expense_transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/income_transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/user_model.dart';
import 'package:expense_tracker_app/features/home/ui/widgets/expense_list_tile_widget.dart';
import 'package:expense_tracker_app/features/home/ui/widgets/income_list_tile_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/transactor_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel user = UserModel(
    name: "Ziad Amer",
    balance: 50000,
    income: 0,
    expenses: 0,
  );
  List<ExpenseTransaction> expense_models = [];
  List<IncomeTransaction> income_models = [];

  void getData() async {
    await DatabaseServices.readDatabase().then((transactionsData) {
      setState(() {
        expense_models.clear();
        income_models.clear();
        List<IncomeTransaction> incomes_data = [];
        List<ExpenseTransaction> expense_data = [];
        transactionsData.forEach((model) {
          if (model is IncomeTransaction) incomes_data.add(model);
          if (model is ExpenseTransaction) expense_data.add(model);
        });
        expense_models.addAll(expense_data);
        income_models.addAll(incomes_data);
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Color(0xFF4B4FC4),
        title: Text(
          "Expense Tracker",
          style: TextStyle(fontSize: 20, fontWeight: .bold),
        ),
      ),
      body: expense_models.isEmpty && income_models.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 100,
                    color: Color(0xFF6A2CE0),
                  ),
                  32.vGap,
                  Text(
                    "No Transactions Found",
                    style: TextStyle(fontSize: 24, color: Color(0xFF6A2CE0)),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(child: Text(user.name!)),
                      Container(
                        child: Text("Balance: ${user.balance.toString()} EGP"),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Income"),
                        Text("+${user.income.toString()} EGP"),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    // Takes only necessary space
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: income_models.length,
                    itemBuilder: (_, int index) {
                      IncomeTransaction model = income_models[index];
                      return IncomeListTileWidget(
                        model: model,
                        onUpdate: () async {
                          bool? result = await Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.transactor, arguments: model);
                          if (result ?? false) {
                            getData();
                          }
                        },
                        onDelete: () async {
                          await DatabaseServices.deleteTransaction(model.id!);
                        },
                      );
                    },
                    separatorBuilder: (_, _) => Divider(height: 25),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    // Takes only necessary space
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expense_models.length,
                    itemBuilder: (_, int index) {
                      ExpenseTransaction model = expense_models[index];
                      return ExpenseListTileWidget(
                        model: model,
                        onUpdate: () async {
                          bool? result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  TransactorScreen(model: model, user: user),
                            ),
                          );
                          if (result ?? false) {
                            getData();
                          }
                        },
                        onDelete: () async {
                          await DatabaseServices.deleteTransaction(model.id!);
                        },
                      );
                    },
                    separatorBuilder: (_, _) => Divider(height: 25),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.of(
            context,
          ).pushNamed<bool>(AppRoutes.transactor);
          if (result ?? false) {
            getData();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
