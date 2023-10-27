import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:gafatcash/global.dart';
import 'package:gafatcash/startup/dashboard/chart.dart';

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
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                height: 500,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                decoration: BoxDecoration(
                  color: Global.borderColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text('Transaction Statistics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    SizedBox(height: Global.defaultPadding,),
                    Chart(),
                    Container(
                      padding: EdgeInsets.all(Global.defaultPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Global.primaryColor.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(Global.defaultPadding),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(CupertinoIcons.money_dollar_circle_fill),
                          ),
                          Expanded(child: Text("Confirmed Transaction"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}