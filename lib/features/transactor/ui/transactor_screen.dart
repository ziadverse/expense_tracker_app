import 'package:expense_tracker_app/core/extensions/num_extensions.dart';
import 'package:expense_tracker_app/core/services/database_services.dart';
import 'package:expense_tracker_app/features/home/data/models/Transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/expense_categories_enum.dart';
import 'package:expense_tracker_app/features/home/data/models/expense_transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/income_categories_enum.dart';
import 'package:expense_tracker_app/features/home/data/models/income_transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/type_enum.dart';
import 'package:expense_tracker_app/features/home/data/models/user_model.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/expense_categories_combo_box_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/income_categories_combo_box_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/text_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/type_combo_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransactorScreen extends StatefulWidget {
  final TransactionModel? model;
  final UserModel? user;

  const TransactorScreen({required this.model, required this.user, super.key});

  @override
  State<TransactorScreen> createState() => _TransactorScreenState();
}

class _TransactorScreenState extends State<TransactorScreen> {
  bool isLoading = false;
  double? amount;
  TransactionType? type;
  IncomeCategories? inc_category;
  ExpenseCategories? exp_category;
  DateTime? date;
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  double old_amount = 0;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    if (widget.model != null) {
      amountController.text = widget.model!.amount.toString();
      descriptionController.text = widget.model!.description;
      type = widget.model!.type;
      date = widget.model!.date;
      amount = widget.model!.amount;
      if (type == TransactionType.income) {
        inc_category = (widget.model! as IncomeTransaction?)!.category;
        exp_category = null;
      } else {
        inc_category = null;
        exp_category = (widget.model! as ExpenseTransaction?)!.category;
        old_amount = widget.model!.amount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Color(0xFF4B4FC4),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(CupertinoIcons.back),
        ),
      ),
      body: Column(
        children: [
          TextWidget(
            text: "Amount",
            icon: Icons.money_off,
            controller: amountController,
          ),
          TypeComboBoxWidget(
            type: type,
            onChanged: (selected_type) {
              setState(() {
                type = selected_type;
                inc_category = null;
                exp_category = null;
              });
            },
          ),
          type == TransactionType.income
              ? IncomeCategoriesComboBoxWidget(
                  selectedCategory: inc_category,
                  onChanged: (value) {
                    setState(() {
                      inc_category = value;
                      exp_category = null;
                    });
                  },
                )
              : ExpenseCategoriesComboBoxWidget(
                  selectedCategory: exp_category,
                  onChanged: (value) {
                    setState(() {
                      inc_category = null;
                      exp_category = value;
                    });
                  },
                ),
          TextWidget(
            text: "Description",
            icon: Icons.description,
            controller: descriptionController,
          ),
        if (widget.model != null) Text(widget.model!.date.toString()),
          ElevatedButton(
            onPressed: isLoading
                ? () {}
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(2.sec);
                    if (amountController.text.trim().isNotEmpty &&
                        descriptionController.text.trim().isNotEmpty &&
                        type != null &&
                        (inc_category != null || exp_category != null)) {
                      if (type == TransactionType.income) {
                        if (widget.model == null) {
                          await DatabaseServices.createTransaction(
                            IncomeTransaction(
                              type: type!,
                              date: DateTime.now(),
                              amount: double.parse(amountController.text),
                              description: descriptionController.text,
                              category: inc_category,
                            ),
                            null,
                            inc_category,
                          );
                        } else {
                          if (double.tryParse(amountController.text) !=
                              old_amount) {
                            widget.user?.updateBalance(
                              old_amount,
                              double.tryParse(amountController.text)!,
                            );
                          }
                          await DatabaseServices.updateTransaction(
                            widget.model!.id!,
                            amount: double.parse(amountController.text),
                            type: type,
                            date: date,
                            description: descriptionController.text,
                            inc_category: inc_category,
                            exp_category: null,
                          );
                        }
                      } else {
                        if (widget.model == null) {
                          await DatabaseServices.createTransaction(
                            ExpenseTransaction(
                              type: type!,
                              date: DateTime.now(),
                              amount: double.parse(amountController.text),
                              description: descriptionController.text,
                              category: exp_category,
                            ),
                            exp_category,
                            null,
                          );
                        } else {
                          if (double.tryParse(amountController.text) !=
                              old_amount) {
                            widget.user?.updateBalance(
                              old_amount,
                              double.tryParse(amountController.text)!,
                            );
                          }
                          await DatabaseServices.updateTransaction(
                            widget.model!.id!,
                            amount: double.parse(amountController.text),
                            type: type,
                            date: date,
                            description: descriptionController.text,
                            inc_category: null,
                            exp_category: exp_category,
                          );
                        }
                      }
                    }
                    Navigator.of(context).pop(true);
                    setState(() {
                      isLoading = true;
                    });
                  },
            child: isLoading
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Color(0xFF5B2C8D),
                    size: 200,
                  )
                : Text("Save"),
          ),
        ],
      ),
    );
  }
}
