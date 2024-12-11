import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/registration_provider/registration_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/shared_preferences.dart';
import '../e_kyc_ui/e_kyc_main_ui.dart';
class RegistrationFormPage extends StatefulWidget {
  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<RegistrationFormPage> {
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegistrationFormProvider>(context, listen: false).fetchFormFields();
    });
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<RegistrationFormProvider>(context); // listen to provider

    return WillPopScope(
      onWillPop: () async {
        // Clear form data before navigating back
        final provider = Provider.of<RegistrationFormProvider>(context, listen: false);
        provider.resetState(); // Ensure this method clears all form data
        return true; // Allow navigation back
      },
      child: Scaffold(
        appBar: AppBar(title: Text('')),
        body:Consumer<RegistrationFormProvider>(builder: (context,valustate,child){
          if(valustate.isLoadingForm){
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text("Please Wait"),
                    CircularProgressIndicator(),
                  ],
                ));
          }else{
            if (valustate.hasErrorForm) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(' ${valustate.errorMessageForm}'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        valustate.retryFetchfetchFormFields();
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }else{
              return Form(
                  key: formProvider.formKey,
                  child:ListView(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    children: [
                      Text("Register Account",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      Text("Signing up is quick, easy, and secure!",style: TextStyle(fontSize: 16,),),
                      SizedBox(height: 10,),
                      ...formProvider.formFields.map((field) {
                        Widget fieldWidget;
                        switch (field['type']) {
                          case 'text':
                            fieldWidget = field['isPassword'] == true
                                ? buildPasswordField(field, formProvider)
                                : buildTextField(field, formProvider);
                            break;
                          case 'dropdown':
                            fieldWidget = buildDropdown(field, formProvider);
                            break;
                          case 'radio':
                            fieldWidget = buildRadioButton(field, formProvider);
                            break;
                          case 'DOB':
                            fieldWidget = buildDateField(field, formProvider);
                            break;
                          default:
                            fieldWidget = SizedBox.shrink();
                        }
                        // Add a margin between each field
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.0), // Add margin below each field
                          child: fieldWidget,
                        );
                      }).toList(),
                      SizedBox(height: 20),
                      Consumer<RegistrationFormProvider>(
                        builder: (context, provider, child) {
                          return    Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  String requestData="";
                                  for (var field in provider.formFields) {
                                    String label = field['label'];
                                    bool isMandatory = !(field['optional'] ?? true);
                                    String? fieldValue = provider.formData[label]?.toString();

                                    if (isMandatory && (provider.formData[label] == null || provider.formData[label].toString().isEmpty)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Please fill in the mandatory field: $label')),
                                      );
                                      return;
                                    }
                                    // If the field has a regex and the value doesn't match, show error
                                    // if (field['regex'] != null && fieldValue != null && !RegExp(field['regex']).hasMatch(fieldValue)) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //     SnackBar(content: Text('Invalid value for $label')),
                                    //   );
                                    //   return; // Stop further execution if the value is invalid
                                    // }
                                    String formattedData = provider.formFields.map((field) {
                                      String label = field['label'];
                                      String value = provider.formData[label]?.toString() ?? "Not Provided";
                                      return "$label=$value";
                                    }).join("<@>");
                                    requestData=formattedData;
                                    // Log or show the formatted data for debugging
                                    print("Formatted Data: $formattedData");

                                  }
                                  var value1=await provider.submitForm(requestData);
                                  if (value1 != null) {
                                    var status = value1["Status"] ?? false;
                                    var msg = value1["Message"] ?? AppUrl.warningMSG;
                                    if (status) {
                                      var data=value1["Data"];
                                      var userId = value1["Data"]["UserId"]??"";
                                      var mId = value1["Data"]["M_Consumerid"]??"";
                                      var mob = value1["Data"]["MobileNo"]??"";
                                      if(userId.toString().isNotEmpty&&mId.toString().isNotEmpty&&mob.toString().isNotEmpty){
                                        await SharedPrefHelper().save("User_ID", userId);
                                        await SharedPrefHelper().save("M_Consumerid", mId);
                                        await SharedPrefHelper().save("MobileNumber", mob);
                                        provider.resetState();
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context)=>KycMainScreen()));
                                        toastRedC(msg);
                                      } else {
                                        CustomAlert.showMessage(
                                            context, "", msg.toString(), AlertType.info);
                                      }

                                    } else {
                                      CustomAlert.showMessage(
                                          context, "", msg.toString(), AlertType.info);
                                    }
                                  } else {
                                    toastRedC(AppUrl.warningMSG);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  backgroundColor: AppColor.app_btn_color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child:  provider.isLoadingPan? CircularProgressIndicator(
                                  color: AppColor.white_color,
                                  strokeAlign: 0,
                                  strokeWidth: 4,
                                )
                                    :Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ); // Default UI
                        },
                      ),
                      // ElevatedButton(
                      //   onPressed: () => handleSubmit(context, formProvider),
                      //   child: Text('Submit'),
                      // ),
                    ],
                  )

              );
            }
          }})
      ),
    );
  }




  Widget buildTextField(Map<String, dynamic> field, RegistrationFormProvider provider) {
    if (!_controllers.containsKey(field['label'])) {
      _controllers[field['label']] = TextEditingController(
        text: provider.formData[field['label']] ?? field['value'] ?? '',
      );
    }

    TextEditingController controller = _controllers[field['label']]!;

    // Update the controller value when the provider updates
    controller.text = provider.formData[field['label']] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label'],textAlign: TextAlign.start,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
        TextFormField(
          controller: controller,

          decoration: InputDecoration(
            hintText: field['hint'],
            contentPadding: EdgeInsets.only(left: 9,top: 5,bottom: 5),
            hintStyle: TextStyle(fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) async {
            provider.updateFormData(field['label'], value);
            if (field['label'] == 'PinCode' && value.length == 6) {
              // Trigger Pincode API call when the pincode is fully entered
              await provider.fetchLocationDetails(value);
            }
          },
          inputFormatters: [
            if (field['label'].toString().endsWith("Email"))
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            if (field['label'].toString().endsWith("Mobile"))
              LengthLimitingTextInputFormatter(10), // Limit to 10 digits
            if (field['label'].toString().endsWith("PinCode"))
              LengthLimitingTextInputFormatter(6), // Limit to 6 digits

            // Allow digits only for Mobile and Pincode fields
            if (field['label'].toString().endsWith("Mobile") || field['label'].toString().endsWith("PinCode"))
              FilteringTextInputFormatter.digitsOnly,

            // Allow only alphabetic characters and spaces for Name fields
            if (field['label'].toString().endsWith("Name"))
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            // Only digits allowed for Pincode
            // Add more conditions as needed for other fields
          ],
          validator: (value) {
            if ((value == null || value.isEmpty) && !field['optional']) {
              return 'Please enter ${field['label']}';
            }
            return null;
          },
        ),
      ],
    );
  }
  Widget buildPasswordField(Map<String, dynamic> field, RegistrationFormProvider provider) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label'],textAlign: TextAlign.start,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
        TextFormField(
          obscureText: !provider.isPasswordVisible,
          decoration: InputDecoration(
            // labelText: field['label'],
            hintText: field['hint'],
            contentPadding: EdgeInsets.only(left: 9,top: 5,bottom: 5),
            hintStyle: TextStyle(fontSize: 14),
            suffixIcon: IconButton(
              icon: Icon(
                provider.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: provider.togglePasswordVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded border
            ),
          ),
          onChanged: (value) => provider.updateFormData(field['label'], value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${field['label']}';
            }
            return null;
          },
        ),
      ],
    );
  }


  Widget buildDropdown(Map<String, dynamic> field, RegistrationFormProvider provider) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: field['hint'],
        contentPadding: EdgeInsets.only(left: 9,top: 5,bottom: 5),
        labelStyle: TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Add rounded border
        ),
      ),
      items: (field['options'] as List<dynamic>)
          .map(
            (option) => DropdownMenuItem(
          value: option.toString(),
          child: Text(option.toString()),
        ),
      )
          .toList(),
      onChanged: (value) => provider.updateFormData(field['label'], value),
      validator: (value) {
        if (value == null && !field['optional']) {
          return 'Please select ${field['label']}';
        }
        return null;
      },
    );
  }


  Widget buildRadioButton(Map<String, dynamic> field, RegistrationFormProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label']),
        SizedBox(height: 8.0), // Optional: Add some spacing between label and radio buttons
        Row(
          children: (field['options'] as List<dynamic>).map((option) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0), // Adds spacing between radio buttons
              child: Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: provider.formData[field['label']],
                    onChanged: (value) => provider.updateFormData(field['label'], value),
                    activeColor: Colors.blue, // Customize active color
                  ),
                  Text(option),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }


  Widget buildDateField(Map<String, dynamic> field, RegistrationFormProvider provider) {
    TextEditingController controller = TextEditingController(
      text: provider.formData[field['label']] ?? '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label'],textAlign: TextAlign.start,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            // labelText: field['label'],

            hintText: field['hint'],
            contentPadding: EdgeInsets.only(left: 9,top: 5,bottom: 5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded border
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {
              String formattedDate = "${pickedDate.toLocal()}".split(' ')[0];
              provider.updateFormData(field['label'], formattedDate);
              controller.text = formattedDate;
            }
          },
          validator: (value) {
            if (!field['optional'] && (value == null || value.isEmpty)) {
              return 'Please enter ${field['label']}';
            }
            // Add the age validation logic here (reuse above age validation)
            return null;
          },
        ),
      ],
    );
  }



  // Submit form handler (you can add your logic here)
  Future<void> handleSubmit(BuildContext context, RegistrationFormProvider provider) async {

    String requestData="";
    for (var field in provider.formFields) {
      String label = field['label'];
      bool isMandatory = !(field['optional'] ?? true);
      String? fieldValue = provider.formData[label]?.toString();

      if (isMandatory && (provider.formData[label] == null || provider.formData[label].toString().isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in the mandatory field: $label')),
        );
        return;
      }
      // If the field has a regex and the value doesn't match, show error
      // if (field['regex'] != null && fieldValue != null && !RegExp(field['regex']).hasMatch(fieldValue)) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Invalid value for $label')),
      //   );
      //   return; // Stop further execution if the value is invalid
      // }
      String formattedData = provider.formFields.map((field) {
        String label = field['label'];
        String value = provider.formData[label]?.toString() ?? "Not Provided";
        return "$label=$value";
      }).join("<@>");
    requestData=formattedData;
      // Log or show the formatted data for debugging
      print("Formatted Data: $formattedData");

    }
    var value1=await provider.submitForm(requestData);
    if (value1 != null) {
      var status = value1["Status"] ?? false;
      var msg = value1["Message"] ?? AppUrl.warningMSG;
      if (status) {
        var data=value1["Data"];
        var userId = value1["Data"]["UserId"]??"";
        var mId = value1["Data"]["M_Consumerid"]??"";
        var mob = value1["Data"]["MobileNo"]??"";
        if(userId.toString().isNotEmpty&&mId.toString().isNotEmpty&&mob.toString().isNotEmpty){
          await SharedPrefHelper().save("User_ID", userId);
          await SharedPrefHelper().save("M_Consumerid", mId);
          await SharedPrefHelper().save("MobileNumber", mob);
          provider.resetState();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>KycMainScreen()));
        toastRedC(msg);
        } else {
          CustomAlert.showMessage(
              context, "", msg.toString(), AlertType.info);
        }

      } else {
        CustomAlert.showMessage(
            context, "", msg.toString(), AlertType.info);
      }
    } else {
      toastRedC(AppUrl.warningMSG);
    }
    // // showDialog(
    // //   context: context,
    // //   builder: (context) {
    // //     return AlertDialog(
    // //       title: Text('Submitted Data'),
    // //       content: SingleChildScrollView(
    // //         child: Column(
    // //           crossAxisAlignment: CrossAxisAlignment.start,
    // //           children: provider.formFields.map((field) {
    // //             String label = field['label'];
    // //             // Ensure we show data in the order of formFields
    // //             return Text('${label}: ${provider.formData[label] ?? 'Not Provided'}');
    // //           }).toList(),
    // //         ),
    // //       ),
    // //       actions: [
    // //         TextButton(
    // //           onPressed: () {
    // //             Navigator.of(context).pop();
    // //             //provider.clearFormData(); // Clear form data after submission
    // //           },
    // //           child: Text('OK'),
    // //         ),
    // //       ],
    // //     );
    // //   },
    // // );

  }
}