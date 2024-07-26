import 'package:flutter/material.dart';
import 'package:netflex/Services/paypal_checkout_service.dart';
import '../data/Subcription.dart';
import '../config/api_service.dart';
import './home.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedPlan = 0;
  Subcription basic = Subcription(subId: 2, subName: 'aaaa', subdesc: 'aaaaa', subPrice: 20);
  Subcription premium = Subcription(subId: 2, subName: 'aaaa', subdesc: 'aaaaa', subPrice: 20);

  getList() async{
    basic = await fetchSubcriptionById(0);
    premium= await fetchSubcriptionById(1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getList();
  }

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
      body: FutureBuilder(
          future: getList(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return(premium.subName!.isEmpty)? const CircularProgressIndicator():
             Container(); // Hiển thị tiến trình chờ
            }else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
            } else {
              return  Padding(
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
                      title: basic.subName!,
                      price: '${basic.subPrice}\$/month',
                      description: basic.subdesc!,
                      resolution: 'SD',
                      screens: '1',
                      selected: selectedPlan == 0,
                      onTap: () {
                        setState(() {
                          selectedPlan = 0;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    PlanOption(
                      title: premium.subName!,
                      price: '${premium.subPrice}\$/month',
                      description: premium.subdesc!,
                      resolution: 'HD',
                      screens: '2',
                      selected: selectedPlan == 1,
                      onTap: () {
                        setState(() {
                          selectedPlan = 1;
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
                              onTap: () {
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () async {
                                      if(selectedPlan == 0){
                                        CheckoutPaypal.Checkout(context, basic);
                                      }
                                      if(selectedPlan == 1){
                                        CheckoutPaypal.Checkout(context, premium);
                                      }
                                    },
                                    child: Text(
                                    'Continue',
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ))
                                  ,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                ),
              );
            }
          })
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
