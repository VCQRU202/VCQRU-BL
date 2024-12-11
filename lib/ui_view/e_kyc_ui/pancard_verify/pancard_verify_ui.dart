import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/pancard_verify_provider/pancard_verify_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';

class PanCardVerifyUI extends StatefulWidget {
  const PanCardVerifyUI({super.key});

  @override
  State<PanCardVerifyUI> createState() => _PanCardVerifyUIState();
}

class _PanCardVerifyUIState extends State<PanCardVerifyUI> {
  final _formKey = GlobalKey<FormState>();
  final _panController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void dispose() {
    _panController.dispose();
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFE1D7FF), Color(0xFFFDE0E7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // Scrollable content
              Expanded(
                child: ListView(
                  children: [
                    // Back arrow
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Form container
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // PAN number text field
                            Text(
                              'Pan Card',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Pan Number",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextFormField(
                              controller: _panController,
                              maxLength: 10,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 5),
                                hintText: 'Enter your PAN number.',
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),

                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),UpperCaseTextFormatter(),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Pan number is required';
                                } else if (!RegExp(
                                        r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')
                                    .hasMatch(value)) {
                                  return 'Invalid PAN number format';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                            // Name text field
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 5),
                                hintText: 'Name',
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required';
                                } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                    .hasMatch(value)) {
                                  return 'Name can only contain alphabets';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                            // Date of Birth text field
                            Text(
                              "DOB",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextFormField(
                              controller: _dobController,
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 5),
                                hintText: 'Select your date of birth.',
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon:
                                    Icon(Icons.calendar_month, size: 20),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  _dobController.text =
                                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date of Birth is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Fixed submit button

              Consumer<PanVerificationProvider>(
                builder: (context, provider, child) {
                  return   Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, you can proceed with further actions
                            var value1 = await provider.submitPanForm(
                                _panController.text,
                              _nameController.text,
                              _dobController.text
                            );
                            if (value1 != null) {
                              var status = value1["Status"] ?? false;
                              var msg = value1["Message"] ?? AppUrl.warningMSG;
                              if (status) {
                                var data=value1["Data"];
                                var resultData = value1["Data"]["result"]["pan_status"];
                               if (resultData.toString().endsWith("VALID")) {

                               }
                              } else {
                                CustomAlert.showMessage(
                                    context, "", msg.toString(), AlertType.info);
                              }
                            } else {
                              toastRedC(AppUrl.warningMSG);
                            }

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 1),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: provider.isLoadingPan ? CircularProgressIndicator(
                          color: AppColor.white_color,
                          strokeAlign: 0,
                          strokeWidth: 4,
                        ) :Text(
                          'Submit',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ); // Default UI
                },
              ),
            ],
          )),
    );
  }
}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
