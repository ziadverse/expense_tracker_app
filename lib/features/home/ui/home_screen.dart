import 'package:expense_tracker_app/app/routing/app_routes.dart';
import 'package:expense_tracker_app/core/extensions/num_extensions.dart';
import 'package:expense_tracker_app/core/services/database_services.dart';
import 'package:expense_tracker_app/features/home/models/transaction_model.dart';
import 'package:expense_tracker_app/features/home/models/user_model.dart';
import 'package:expense_tracker_app/features/home/ui/widgets/transaction_widget.dart';
import 'package:expense_tracker_app/features/home/ui/widgets/type_container_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/transactor_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/features/home/models/transaction_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel user = UserModel(
    balance: 30000,
    income: 0,
    expense: 0,
    name: "Ziad Amer",
  );
  List<TransactionModel> transactions = [];
  late final int startBalance = user.balance ?? 0;

  Future<void> getData() async {
    final data = await DatabaseServices.readTransaction();
    data.sort((a, b) => b.date!.compareTo(a.date!));
    int inc = 0;
    int exp = 0;
    for (final t in data) {
      if (t.type == TransactionType.income) {
        inc += t.amount ?? 0;
      } else {
        exp += t.amount ?? 0;
      }
    }
    if (!mounted) return;
    setState(() {
      transactions = data;
      user.income = inc;
      user.expense = exp;
      user.balance = startBalance + inc - exp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF8FF),
      appBar: AppBar(
        title: Text(
          "Expense Tracker",
          style: TextStyle(fontWeight: .bold, fontSize: 32),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6B3FA0),
        foregroundColor: Color(0xFF1FD6D9),
      ),
      body: Column(
        children: [
          Container(
            margin: .all(16),
            padding: .all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF6B3FA0), Color(0xFF2A9FC9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x406B3FA0),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Text(
                  user.name!,
                  style: TextStyle(
                    color: Color(0xFFD8DAE8),
                    fontSize: 30,
                    fontWeight: .w500,
                  ),
                ),
                Text(
                  "Total Balance",
                  style: TextStyle(color: Color(0xFFA3A8C3), fontSize: 18),
                ),
                Text(
                  user.balance.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: .bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    Expanded(
                      child: TypeContainerWidget(
                        type: "Income",
                        icon: Icons.arrow_downward,
                        user: user,
                        moneyType: user.income,
                        iconBackgroundColor: Color(
                          0xFF4CD964,
                        ).withValues(alpha: 0.2),
                        iconForegroundColor: Color(0xFF4CD964),
                      ),
                    ),
                    12.hGap,
                    Expanded(
                      child: TypeContainerWidget(
                        type: "Expense",
                        icon: Icons.arrow_upward,
                        user: user,
                        moneyType: user.expense,
                        iconBackgroundColor: Color(
                          0xFFFF6B6B,
                        ).withValues(alpha: 0.2),
                        iconForegroundColor: Color(0xFFFF6B6B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(itemBuilder: (_, int index){
              final t = transactions[index];
              return TransactionWidget(
                transaction: t,
                onEdit: () async {
                  final res = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(builder: (_) => TransactorScreen(transaction: t)),
                  );
                  if (res == true) getData();
                },
                onDelete: () async {
                  await DatabaseServices.deleteTransaction(t.id!);
                  getData();
                },
              );
            }, separatorBuilder: (_, _){
              return Divider(height: 12);
            }, itemCount: transactions.length),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        bool? res = await Navigator.of(context).pushNamed<bool>(AppRoutes.transactor);
        if (res ?? false){
          getData();
        }
      }, backgroundColor: Color(0xFF6B3FA0), foregroundColor: Color(0xFF1FD6D9), child: Icon(Icons.add),),
    );
  }
}
