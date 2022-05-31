// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_course/Pages/MaintenancePage/maintenancepage.dart';

enum VehMaintanceSubServices { nearbyMechanic, requestMechanic, towTruck }

VehMaintanceSubServices? selectedSubService;

class VehMaintenanceSection extends StatefulWidget {
  const VehMaintenanceSection({Key? key}) : super(key: key);

  @override
  _VehMaintenanceSectionState createState() => _VehMaintenanceSectionState();
}

class _VehMaintenanceSectionState extends State<VehMaintenanceSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: vehicleMaintenance(context, null, null),
    );
  }
}
