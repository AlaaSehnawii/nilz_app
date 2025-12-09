import 'package:flutter/material.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field/searchable_dropdown.dart';

class UnitBookingDialog {
  final dynamic selectedClient;
  final dynamic selectedSalesman;
  final String coupon;
  final bool breakfast;

  UnitBookingDialog({
    required this.selectedClient,
    required this.selectedSalesman,
    required this.coupon,
    required this.breakfast,
  });
}

Future<UnitBookingDialog?> showUnitBookingDialog({
  required BuildContext context,
  required List<dynamic> clients,
  required List<dynamic> salesmen,
  required String Function(dynamic) nameBuilder,
}) {
  final TextEditingController couponCtrl = TextEditingController();
  dynamic selectedClient;
  dynamic selectedSalesman;
  bool breakfast = false;

  return showDialog<UnitBookingDialog>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "Reservation Options",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CLIENT DROPDOWN
                  SearchableDropdown<dynamic>(
                    titleText: "choose_user",
                    items: clients,
                    selectedItem: selectedClient,
                    labelBuilder: nameBuilder,
                    filterFn: (item, query) {
                      final name = nameBuilder(item).toLowerCase();
                      return name.contains(query.toLowerCase());
                    },
                    onChanged: (v) => setState(() => selectedClient = v),
                  ),

                  const SizedBox(height: 14),

                  // SALESMAN DROPDOWN
                  SearchableDropdown<dynamic>(
                    titleText: "sales_man",
                    items: salesmen,
                    selectedItem: selectedSalesman,
                    labelBuilder: nameBuilder,
                    filterFn: (item, query) {
                      final name = nameBuilder(item).toLowerCase();
                      return name.contains(query.toLowerCase());
                    },
                    onChanged: (v) => setState(() => selectedSalesman = v),
                  ),

                  const SizedBox(height: 14),

                  // COUPON FIELD
                  TextField(
                    controller: couponCtrl,
                    decoration: const InputDecoration(
                      labelText: "Coupon Code",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // BREAKFAST SWITCH
                  SwitchListTile(
                    title: const Text("Include Breakfast"),
                    value: breakfast,
                    onChanged: (v) => setState(() => breakfast = v),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    UnitBookingDialog(
                      selectedClient: selectedClient,
                      selectedSalesman: selectedSalesman,
                      coupon: couponCtrl.text.trim(),
                      breakfast: breakfast,
                    ),
                  );
                },
                child: const Text("Continue"),
              ),
            ],
          );
        },
      );
    },
  );
}
