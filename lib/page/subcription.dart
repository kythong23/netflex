import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String selectedPlan = 'Mobile+';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Choose the plan that’s right for you.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Downgrade or upgrade at any time.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            PlanOption(
              title: 'Mobile',
              price: '1.99/month',
              description:
              'Watch on any phone or tablet. Computer and TV not included.',
              resolution: 'SD',
              screens: '1',
              selected: selectedPlan == 'Mobile',
              onTap: () {
                setState(() {
                  selectedPlan = 'Mobile';
                });
              },
            ),
            SizedBox(height: 16),
            PlanOption(
              title: 'Mobile+',
              price: '2.99/month',
              description:
              'Watch on any phone, tablet or computer. TV not included.',
              resolution: 'HD',
              screens: '2',
              selected: selectedPlan == 'Mobile+',
              onTap: () {
                setState(() {
                  selectedPlan = 'Mobile+';
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}

class PlanOption extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final String resolution;
  final String screens;
  final bool selected;
  final VoidCallback onTap;

  PlanOption({
    required this.title,
    required this.price,
    required this.description,
    required this.resolution,
    required this.screens,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: selected,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Colors.blue,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(
              resolution,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 8),
            Text('Watch on $screens devices at a time'),
          ],
        ),
      ),
    );
  }
}
