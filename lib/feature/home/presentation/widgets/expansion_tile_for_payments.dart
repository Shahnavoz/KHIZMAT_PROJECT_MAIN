import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';
import 'package:khizmat_new/generated/l10n.dart';

class ExpansionTileForPayments extends StatefulWidget {
  const ExpansionTileForPayments({
    super.key,
    required this.size,
    required this.title,
    required this.currentLocale,
    required this.index,
    required this.payments,
  });

  final AdaptiveSizes size;
  final String title;
  final Locale currentLocale;
  final int index;
  final List<Payment> payments;

  @override
  State<ExpansionTileForPayments> createState() =>
      _ExpansionTileForPaymentsState();
}

class _ExpansionTileForPaymentsState extends State<ExpansionTileForPayments> {
  Color _statusColor(String? status) {
    switch (status) {
      case 'PAID':
        return const Color(0xFF4CAF50);
      case 'OPEN':
        return const Color(0xFFFFA726);
      case 'EXPIRED':
      case 'CANCELED':
        return const Color(0xFFEF5350);
      default:
        return Colors.grey;
    }
  }

  Color _statusBgColor(String? status) {
    switch (status) {
      case 'PAID':
        return const Color(0xFFE8F5E9);
      case 'OPEN':
        return const Color(0xFFFFF3E0);
      case 'EXPIRED':
      case 'CANCELED':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  String _statusLabel(String? status) {
    switch (status) {
      case 'PAID':
        return S.of(context).paid;
      case 'OPEN':
        return S.of(context).open;
      case 'EXPIRED':
        return S.of(context).expired;
      case 'CANCELED':
        return S.of(context).canceled;
      default:
        return status ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.size.otstup15),
      decoration: BoxDecoration(
        border: Border.all(color: greyTextFBorderColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          iconColor: primaryButtonColor,
          collapsedIconColor: primaryButtonColor,
          tilePadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          children: [
            const SizedBox(height: 4),
            // ── Table ─────────────────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Table(
                border: TableBorder.all(
                  color: greyTextFBorderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(1.4), // Статус
                  1: FlexColumnWidth(1.5), // Номер инвойса
                  2: FlexColumnWidth(1.6), // Сумма платежа
                  3: FlexColumnWidth(1.4), // Дата оплаты
                },
                children: [
                  // ── Header row ──────────────────────────────────────────
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                    ),
                    children: [
                      _headerCell(S.of(context).status),
                      _headerCell(S.of(context).invoiceNumber),
                      _headerCell(S.of(context).paymentAmount),
                      _headerCell(S.of(context).paymentDate),
                    ],
                  ),
                  // ── Data rows ───────────────────────────────────────────
                  ...widget.payments.map(
                    (payment) => TableRow(
                      decoration: const BoxDecoration(color: Colors.white),
                      children: [
                        // Status badge
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: _statusBgColor(payment.status),
                              border: Border.all(
                                  color: _statusColor(payment.status),
                                  width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _statusLabel(payment.status),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _statusColor(payment.status),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // Invoice number
                        _dataCell(payment.serial ?? '—'),
                        // Amount + currency
                        _dataCell(
                          payment.amount != null
                              ? '${payment.amount} сомони'
                              : '—',
                        ),
                        // Date
                        _dataCell(payment.paid_at ?? '—'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF757575),
          ),
        ),
      );

  Widget _dataCell(String text) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 10),
        ),
      );
}
