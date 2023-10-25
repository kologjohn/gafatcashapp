import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:gafatcash/global.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Global.backgroundColor,
      appBar: AppBar(
        title: const Text('Gafatcash'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Transfer Money',
            icon: Icons.file_copy,
            children: [
              AdminMenuItem(
                title: 'Sender Details',
                route: '/senderDetails',
              ),
              AdminMenuItem(
                title: 'Recipient Details',
                route: '/recipientDetails',
              ),
              AdminMenuItem(
                title: 'Confirmation',
                children: [
                  AdminMenuItem(
                    title: 'Mobile Money Confirmation',
                    route: '/mobileMoneyConfirmation',
                  ),
                  AdminMenuItem(
                    title: 'Bank Confirmation',
                    route: '/bankConfirmation',
                  ),
                ],
              ),
            ],
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Global.borderColor,
          child: const Center(
            child: Text(
              'header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Global.borderColor,
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}