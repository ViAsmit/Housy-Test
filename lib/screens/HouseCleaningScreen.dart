import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housy_test/compnents/checkBoxComponent.dart';
import 'package:housy_test/models/HouseClean/houseClean.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HouseCleaningScreen extends StatefulWidget {
  @override
  _HouseCleaningScreenState createState() => _HouseCleaningScreenState();
}

class _HouseCleaningScreenState extends State<HouseCleaningScreen> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  HouseClean model = HouseClean();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("House Cleaning"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text(''),
                    content: Column(
                      children: [
                        Text("What type of service do you need?"),
                        SizedBox(height: 10.0),
                        Container(
                          height: 450.00,
                          child: ListView.builder(
                            itemCount: model.getFirstOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckBoxComponent(
                                text: model.getFirstOptions[index].title,
                                checked: model.getFirstOptions[index].isChecked,
                                onCheck: (val) {
                                  setState(() {
                                    model.getFirstOptions[index].isChecked =
                                        val;
                                  });
                                  model.values[0] =
                                      model.getFirstOptions[index].title;
                                  print(val);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text(''),
                    content: Column(
                      children: [
                        Text("How Many Bedrooms are there"),
                        SizedBox(height: 10.0),
                        Container(
                          height: 450.00,
                          child: ListView.builder(
                            itemCount: model.getSecondOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckBoxComponent(
                                text: model.getSecondOptions[index].title,
                                checked:
                                    model.getSecondOptions[index].isChecked,
                                onCheck: (val) {
                                  setState(() {
                                    model.getSecondOptions[index].isChecked =
                                        val;
                                  });
                                  model.values[1] =
                                      model.getSecondOptions[index].title;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text(''),
                    content: Column(
                      children: [
                        Text("How Many Bathrooms are there?"),
                        SizedBox(height: 10.0),
                        Container(
                          height: 450.00,
                          child: ListView.builder(
                            itemCount: model.getThirdOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckBoxComponent(
                                text: model.getThirdOptions[index].title,
                                checked: model.getThirdOptions[index].isChecked,
                                onCheck: (val) {
                                  setState(() {
                                    model.getThirdOptions[index].isChecked =
                                        val;
                                  });
                                  model.values[2] =
                                      model.getThirdOptions[index].title;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text(''),
                    content: Column(
                      children: [
                        Text("What kind of cleaning do you need?"),
                        SizedBox(height: 10.0),
                        Container(
                          height: 450.00,
                          child: ListView.builder(
                            itemCount: model.getFourthOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckBoxComponent(
                                text: model.getFourthOptions[index].title,
                                checked:
                                    model.getFourthOptions[index].isChecked,
                                onCheck: (val) {
                                  setState(() {
                                    model.getFourthOptions[index].isChecked =
                                        val;
                                  });
                                  model.values[3] =
                                      model.getFourthOptions[index].title;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text(''),
                    content: Column(
                      children: [
                        Text("Do you need any extras?"),
                        SizedBox(height: 10.0),
                        Container(
                          height: 450.00,
                          child: ListView.builder(
                            itemCount: model.getFifthOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckBoxComponent(
                                text: model.getFifthOptions[index].title,
                                checked: model.getFifthOptions[index].isChecked,
                                onCheck: (val) {
                                  setState(() {
                                    model.getFifthOptions[index].isChecked =
                                        val;
                                  });
                                  if (val == true)
                                    model.values[4].add(
                                        model.getFifthOptions[index].title);
                                  else
                                    model.values[4].remove(
                                        model.getFifthOptions[index].title);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 4
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text(''),
                    content: Column(
                      children: [
                        Text("How often do you need the house cleaned"),
                        SizedBox(height: 10.0),
                        Container(
                          height: 450.00,
                          child: ListView.builder(
                            itemCount: model.getSixthOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckBoxComponent(
                                text: model.getSixthOptions[index].title,
                                checked: model.getSixthOptions[index].isChecked,
                                onCheck: (val) {
                                  setState(() {
                                    model.getSixthOptions[index].isChecked =
                                        val;
                                  });
                                  model.values[5] =
                                      model.getSixthOptions[index].title;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 5
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text(''),
                    content: Column(
                      children: [
                        Text("Additional Details, If Any"),
                        SizedBox(height: 10.0),
                        TextField(
                          maxLines: 8,
                          onChanged: (val) {
                            setState(() {
                              model.values[6] = val;
                            });
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 6
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text(''),
                    content: Column(
                      children: [
                        Text("When do you want this pro to start?"),
                        SizedBox(height: 10.0),
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        RaisedButton(
                          onPressed: () {
                            _selectDate(context, change: (DateTime val) {
                              model.values[7] =
                                  val.toLocal().toString().split(" ")[0];
                            });
                          },
                          child: Text("Select Date"),
                        )
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 6
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text(''),
                    content: Column(
                      children: [
                        Text("What time of day do you prefer?"),
                        SizedBox(height: 10.0),
                        Container(
                          height: 450.00,
                          child: ListView.builder(
                            itemCount: model.getSeventhOptions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CheckBoxComponent(
                                text: model.getSeventhOptions[index].title,
                                checked:
                                    model.getSeventhOptions[index].isChecked,
                                onCheck: (val) {
                                  setState(() {
                                    model.getSeventhOptions[index].isChecked =
                                        val;
                                  });
                                  if (val == true)
                                    model.values[8].add(
                                        model.getSeventhOptions[index].title);
                                  else
                                    model.values[8].remove(
                                        model.getSeventhOptions[index].title);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 7
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context, {required Function change}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(picked);
        change(picked);
      });
    }
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 8 ? setState(() => _currentStep += 1) : getData();
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  void getData() async {
    print(model.values);
  }
}
