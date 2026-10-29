import 'package:flutter/material.dart';

import '../models/book.dart';
import '../viewmodels/display_status.dart';
import 'shared.dart';

/// Kartu satu salinan fisik buku.
class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.status,
    required this.onBorrow,
  });

  final Book book;
  final DisplayStatus status;
  final VoidCallback onBorrow;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Salinan ${book.id}', style: text.titleSmall),
                  const SizedBox(height: 4),
                  Text('Harga ganti ${formatRupiah(book.replacementPrice)}',
                      style: text.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatusChip(status: status),
                const SizedBox(height: 8),
                FilledButton(onPressed: onBorrow, child: const Text('Pinjam')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}