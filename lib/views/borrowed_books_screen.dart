import 'package:flutter/material.dart';

import '../viewmodels/library_view_model.dart';
import 'shared.dart';
import 'loan_card.dart';

class BorrowedBooksScreen extends StatelessWidget {
  const BorrowedBooksScreen({super.key, required this.viewModel});

  final LibraryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final loans = viewModel.loans.reversed.toList(); // terbaru di atas

        return Scaffold(
          appBar: AppBar(title: const Text('Pinjaman')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FineSummaryCard(
                totalFine: viewModel.totalFine,
                activeCount: viewModel.activeLoans.length,
                overdueCount: viewModel.overdueLoans.length,
                today: viewModel.today,
              ),
              const SizedBox(height: 16),
              if (loans.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('Belum ada peminjaman.')),
                )
              else
                for (final loan in loans)
                  LoanCard(
                    loan: loan,
                    bookTitle: viewModel.bookById(loan.bookId).title,
                    status: viewModel.getOverdueStatus(loan),
                    fine: viewModel.calculateFine(loan),
                    onReturn: () => showResultSnackBar(
                      context,
                      viewModel.returnBook(loan.id),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}