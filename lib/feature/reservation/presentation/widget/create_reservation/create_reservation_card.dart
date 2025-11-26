// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';

class CreateReservationCard extends StatefulWidget {
  const CreateReservationCard({super.key});

  @override
  State<CreateReservationCard> createState() => _CreateReservationCardState();
}

class _CreateReservationCardState extends State<CreateReservationCard> {
  // List<dynamic> _places = [];
  // dynamic _selectedPlace;

  // List<dynamic> _roomTypes = [];
  // dynamic _selectedRoomType;

  // List<dynamic> _users = [];
  // dynamic _selectedUser;

  // List<dynamic> _salesEmployees = [];
  // dynamic _selectedSalesEmployee;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadPlaces();
  //   _loadRoomTypes();
  //   _loadUsers();
  //   _loadSalesEmployees();
  // }

  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColorManager.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add your form fields and widgets here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
