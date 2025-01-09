import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/registration_ui/success_msg_register.dart';

import '../../providers_of_app/registration_provider/registration_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/shared_preferences.dart';
import '../e_kyc_ui/e_kyc_main_ui.dart';
import '../mobile_enter/mobile_enter_screen.dart';

class RegistrationFormPage extends StatefulWidget {
  String mobile;

  RegistrationFormPage({required this.mobile});

  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<RegistrationFormPage> {
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {};
    Provider.of<RegistrationFormProvider>(context, listen: false)
        .updateFormData1('MobileNo', widget.mobile);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegistrationFormProvider>(context, listen: false)
          .fetchFormFields();
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
    final formProvider =
        Provider.of<RegistrationFormProvider>(context); // listen to provider
    final splashProvider =
        Provider.of<SplashScreenProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        // Clear form data before navigating back
        final provider =
            Provider.of<RegistrationFormProvider>(context, listen: false);
        provider.resetState(); // Ensure this method clears all form data
        return true; // Allow navigation back
      },
      child: Scaffold(body: Consumer<RegistrationFormProvider>(
          builder: (context, valustate, child) {
        if (valustate.isLoadingForm) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text("Please Wait"),
              CircularProgressIndicator(),
            ],
          ));
        } else {
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
          } else {
            return Container(
              decoration: BoxDecoration(
                color: splashProvider.color_bg,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 30),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MobileEnterScreen()));
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // background image and bottom contents
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                  color: Colors.white),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                            color: splashProvider.color_bg,
                                          )),
                                      Expanded(flex: 5, child: Container()),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Card(
                                      elevation: 2.0,
                                      // Controls the elevation
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50), // Ensures circular shape
                                      ),
                                      child: Container(
                                        height: 80.0,
                                        // Height of the circular container
                                        width: 80.0,
                                        // Width of the circular container
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // Ensures the container is circular
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                splashProvider.logoUrlF),
                                            // Replace with your image URL
                                            fit: BoxFit
                                                .cover, // Adjust fit to cover the entire circle
                                          ),
                                          color: Colors.grey
                                              .shade200, // Optional background color while the image loads
                                        ),
                                        child:
                                            splashProvider.logoUrlF.isNotEmpty
                                                ? null
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(), // Loader while the image is being fetched
                                                  ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
                                          color: Colors.white),
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Form(
                                          key: formProvider.formKey,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                child: Text(
                                                  "Register Account",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    "Sign up quickly and start earning rewards today!",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ...formProvider.formFields
                                                  .map((field) {
                                                Widget fieldWidget;
                                                switch (field['type']) {
                                                  case 'text':fieldWidget = field['isPassword'] == true
                                                        ? buildPasswordField(field, formProvider)
                                                        : buildTextField(field, formProvider);
                                                    break;
                                                  // case 'dropdown':fieldWidget = buildDropdown1(
                                                  //       field, formProvider,context);
                                                  //   break;
                                                  case 'dropdown':fieldWidget = buildDropdown(
                                                      field, formProvider);
                                                  break;
                                                  case 'radio':
                                                    fieldWidget = buildRadioButton(field,
                                                            formProvider);
                                                    break;
                                                  case 'DOB':
                                                    fieldWidget = buildDateField(field, formProvider);
                                                    break;
                                                  default:
                                                    fieldWidget =
                                                        SizedBox.shrink();
                                                }
                                                // Add a margin between each field
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 16.0),
                                                  // Add margin below each field
                                                  child: fieldWidget,
                                                );
                                              }).toList(),
                                              SizedBox(height: 20),
                                              Consumer<
                                                  RegistrationFormProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return Container(
                                                    width: double.infinity,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          if (formProvider.formKey.currentState!.validate()) {}
                                                          String requestData = "";
                                                          for (var field in provider.formFields) {
                                                            String label = field['label'];
                                                            bool isMandatory = !(field['optional'] ?? true);
                                                            String? fieldValue = provider.formData[label]?.toString();
                                                            // Skip validation for "mobile" field
                                                            if (label == "MobileNo") {
                                                              continue;
                                                            }
                                                            if (isMandatory && (provider.formData[label] == null ||
                                                                provider.formData[label].toString().isEmpty)) {
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(content: Text('Please fill the mandatory field')),
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
                                                            String
                                                                formattedData = provider.formFields.map((field) {
                                                              String label = field['label'];
                                                              //String value = provider.formData[label]?.toString() ?? "";
                                                              String value;

                                                              if (label == "MobileNo") {
                                                                // Default value for "mobile" label
                                                                value = provider.formData[label]?.toString().isNotEmpty == true
                                                                    ? provider.formData[label].toString() : widget.mobile;
                                                              } else {
                                                                // Regular processing for other labels
                                                                value = provider.formData[label]?.toString() ?? "";
                                                              }
                                                              return "$label=$value";
                                                            }).join("<@>");
                                                            requestData = formattedData;
                                                            // Log or show the formatted data for debugging
                                                            print("Formatted Data: $formattedData");
                                                          }
                                                          var value1 = await provider.submitForm(requestData);
                                                          if (value1 != null) {
                                                            var status = value1["success"] ?? false;
                                                            var msg = value1["message"] ?? AppUrl.warningMSG;
                                                            if (status) {
                                                              var data = value1["data"];
                                                              if(data!=null){
                                                                var userId = value1["data"]["userId"] ?? "";
                                                                var mId = value1["data"]["m_Consumerid"] ?? "";
                                                                var mob = value1["data"]["mobileNo"] ?? "";
                                                                var UserName = value1["data"]["consumerName"] ?? "";
                                                                bool isKYCRequir = value1["data"]["kycstatus"]??false;
                                                                if (userId.toString().isNotEmpty && mId.toString().isNotEmpty && mob
                                                                    .toString().isNotEmpty) {
                                                                  await SharedPrefHelper().save("User_ID", userId);
                                                                  await SharedPrefHelper().save("Verify", true);
                                                                  await SharedPrefHelper().save("Name", UserName);
                                                                  await SharedPrefHelper().save("M_Consumerid", mId.toString());
                                                                  await SharedPrefHelper().save("MobileNumber", mob);
                                                                  provider.resetState();
                                                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                                                      builder: (context)=>SuccessMsgSuccessfully(msg:msg ,isKycRequir:isKYCRequir,)));
                                                                  // toastRedC(msg);
                                                                } else {
                                                                  CustomAlert.showMessage(
                                                                      context,
                                                                      "",
                                                                      msg.toString(),
                                                                      AlertType.info);
                                                                }
                                                              }else {
                                                                CustomAlert
                                                                    .showMessage(context,
                                                                    "",
                                                                    msg.toString(),
                                                                    AlertType.info);
                                                              }
                                                            } else {
                                                              CustomAlert
                                                                  .showMessage(context,
                                                                      "",
                                                                      msg.toString(),
                                                                      AlertType.info);
                                                            }
                                                          } else {
                                                            toastRedC(AppUrl.warningMSG);
                                                          }
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          padding: EdgeInsets.symmetric(vertical: 1),
                                                          backgroundColor: splashProvider.color_bg,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: provider.isLoadingPan ? CircularProgressIndicator(
                                                                color: AppColor.white_color,
                                                                strokeAlign: 0,
                                                                strokeWidth: 4,
                                                              )
                                                            : Text('Submit', style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.white),
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
                                              SizedBox(height: 20),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            );
          }
        }
      })),
    );
  }

  Widget buildTextField(
      Map<String, dynamic> field, RegistrationFormProvider provider) {
    if (!_controllers.containsKey(field['label'])) {
      _controllers[field['label']] = TextEditingController(
        text: provider.formData[field['label']] ?? field['value'] ?? '',
      );
    }

    TextEditingController controller = _controllers[field['label']]!;

    // Update the controller value when the provider updates
    controller.text = provider.formData[field['label']] ?? '';
    bool isMandatory = field['optional'] ?? false;
// Make the field read-only if the label is "Mobile"
    bool isReadOnly = field['label'] == 'MobileNo';
    if (isReadOnly) {
      controller.text = widget.mobile; // Set the mobile value
    }
    bool isPinCodeField = field['label'].toString().endsWith("PinCode");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field['label1'],
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        TextFormField(
          controller: controller,
          keyboardType: isPinCodeField
              ? TextInputType.number // Show numeric keyboard for PinCode
              : TextInputType.text,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            hintText: field['hint'],
            contentPadding: EdgeInsets.only(left: 9, top: 5, bottom: 5),
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
            if (field['label'].toString().endsWith("MobileNo"))
              LengthLimitingTextInputFormatter(10), // Limit to 10 digits
            if (field['label'].toString().endsWith("PinCode"))
              LengthLimitingTextInputFormatter(6), // Limit to 6 digits

            // Allow digits only for Mobile and Pincode fields
            if (field['label'].toString().endsWith("MobileNo") ||
                field['label'].toString().endsWith("PinCode"))
              FilteringTextInputFormatter.digitsOnly,

            // Allow only alphabetic characters and spaces for Name fields
            if (field['label'].toString().endsWith("Name"))
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            // Only digits allowed for Pincode
            // Add more conditions as needed for other fields
          ],
          validator: (value) {
            if ((value == null || value.isEmpty) && !field['optional']) {
              return 'Please enter ${field['label1']}';
            }
            // if ((value == null || value.isEmpty) && !field['optional']) {
            //   return 'Please enter ${field['label']}';
            // }
            if (field['label'].toString().endsWith("Email")) {
              final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!regex.hasMatch(value!)) {
                return 'Invalid ${field['label1']} format';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget buildPasswordField(
      Map<String, dynamic> field, RegistrationFormProvider provider) {
    bool isMandatory = field['optional'] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1'],
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        TextFormField(
          obscureText: !provider.isPasswordVisible,
          decoration: InputDecoration(
            // labelText: field['label'],
            hintText: field['hint'],
            contentPadding: EdgeInsets.only(left: 9, top: 5, bottom: 5),
            hintStyle: TextStyle(fontSize: 14),
            suffixIcon: IconButton(
              icon: Icon(
                provider.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: provider.togglePasswordVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded border
            ),
          ),
          onChanged: (value) => provider.updateFormData(field['label'], value),
          validator: (value) {
            if ((value == null || value.isEmpty) && !field['optional']) {
              return 'Please enter ${field['label1']}';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget buildDropdown(
      Map<String, dynamic> field, RegistrationFormProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1'],
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: field['hint'],
            hintStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.only(left: 9, top: 5, bottom: 5),
            labelStyle: TextStyle(fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded border
            ),
          ),
          items: (field['options'] as List<dynamic>).map(
                (option) => DropdownMenuItem(
                  value: option.toString(),
                  child: Text(option.toString()),
                ),
              )
              .toList(),
          onChanged: (value) => provider.updateFormData(field['label'], value),
          validator: (value) {
            if (value == null && !field['optional']) {
              return 'Please select ${field['label1']}';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget buildDropdown1(
      Map<String, dynamic> field, RegistrationFormProvider provider, BuildContext context) {
    final dropdownProvider = Provider.of<RegistrationFormProvider>(context);
    dropdownProvider.selectedValue = dropdownProvider.selectedValue.isNotEmpty
        ? dropdownProvider.selectedValue
        : field['hint'] ?? 'Select ${field['label']}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Dropdown Button
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(5),
                topRight: const Radius.circular(5),
                bottomLeft: Radius.circular(dropdownProvider.isExpanded ? 0 : 5),
                bottomRight: Radius.circular(dropdownProvider.isExpanded ? 0 : 5),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus(); // Close keyboard
                    dropdownProvider.toggleDropdown(); // Toggle dropdown state
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          dropdownProvider.selectedValue,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Icon(
                        dropdownProvider.isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Dropdown Options
          if (dropdownProvider.isExpanded)
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: (field['options'] as List<dynamic>).map((e) {
                return InkWell(
                  onTap: () {
                    dropdownProvider.selectValue(e.toString()); // Update selected value
                    provider.updateFormData(field['label'], e.toString()); // Update provider form data
                  },
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: dropdownProvider.selectedValue == e.toString()
                          ? Colors.grey
                          : Colors.grey.shade300,
                    ),
                    child: Center(
                      child: Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 14,
                          color: dropdownProvider.selectedValue == e.toString()
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
        ],
      ),
    );
  }

  Widget buildDropdown2(
      Map<String, dynamic> field, RegistrationFormProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field['label1'],
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            provider.updateFormData(field['label'], value);
          },
          itemBuilder: (BuildContext context) {
            return (field['options'] as List<dynamic>).map<PopupMenuEntry<String>>(
                  (option) {
                return PopupMenuItem<String>(
                  value: option.toString(),
                  child: Text(option.toString()),
                );
              },
            ).toList();
          },
          child: Container(
            padding: EdgeInsets.only(left: 9, top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  field['hint'] ?? 'Select ${field['label1']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRadioButton(
      Map<String, dynamic> field, RegistrationFormProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1']),
        SizedBox(height: 8.0),
        // Optional: Add some spacing between label and radio buttons
        Row(
          children: (field['options'] as List<dynamic>).map((option) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              // Adds spacing between radio buttons
              child: Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: provider.formData[field['label']],
                    onChanged: (value) =>
                        provider.updateFormData(field['label'], value),
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

  Widget buildDateField(
      Map<String, dynamic> field, RegistrationFormProvider provider) {
    TextEditingController controller = TextEditingController(
      text: provider.formData[field['label']] ?? '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1'],
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            // labelText: field['label'],

            hintText: field['hint'],
            contentPadding: EdgeInsets.only(left: 9, top: 5, bottom: 5),
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

  // // Submit form handler (you can add your logic here)
  // Future<void> handleSubmit(
  //     BuildContext context, RegistrationFormProvider provider) async {
  //   String requestData = "";
  //   for (var field in provider.formFields) {
  //     String label = field['label'];
  //     bool isMandatory = !(field['optional'] ?? true);
  //     String? fieldValue = provider.formData[label]?.toString();
  //
  //     if (isMandatory &&
  //         (provider.formData[label] == null ||
  //             provider.formData[label].toString().isEmpty)) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please fill in the mandatory field: $label')),
  //       );
  //       return;
  //     }
  //     // If the field has a regex and the value doesn't match, show error
  //     // if (field['regex'] != null && fieldValue != null && !RegExp(field['regex']).hasMatch(fieldValue)) {
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //     SnackBar(content: Text('Invalid value for $label')),
  //     //   );
  //     //   return; // Stop further execution if the value is invalid
  //     // }
  //     String formattedData = provider.formFields.map((field) {
  //       String label = field['label'];
  //       String value = provider.formData[label]?.toString() ?? "Not Provided";
  //       return "$label=$value";
  //     }).join("<@>");
  //     requestData = formattedData;
  //     // Log or show the formatted data for debugging
  //     print("Formatted Data: $formattedData");
  //   }
  //   var value1 = await provider.submitForm(requestData);
  //   if (value1 != null) {
  //     var status = value1["Status"] ?? false;
  //     var msg = value1["Message"] ?? AppUrl.warningMSG;
  //     if (status) {
  //       var data = value1["Data"];
  //       var userId = value1["Data"]["UserId"] ?? "";
  //       var mId = value1["Data"]["M_Consumerid"] ?? "";
  //       var mob = value1["Data"]["MobileNo"] ?? "";
  //       if (userId.toString().isNotEmpty &&
  //           mId.toString().isNotEmpty &&
  //           mob.toString().isNotEmpty) {
  //         await SharedPrefHelper().save("User_ID", userId);
  //         await SharedPrefHelper().save("M_Consumerid", mId);
  //         await SharedPrefHelper().save("MobileNumber", mob);
  //         provider.resetState();
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (context) => KycMainScreen()));
  //         toastRedC(msg);
  //       } else {
  //         CustomAlert.showMessage(context, "", msg.toString(), AlertType.info);
  //       }
  //     } else {
  //       CustomAlert.showMessage(context, "", msg.toString(), AlertType.info);
  //     }
  //   } else {
  //     toastRedC(AppUrl.warningMSG);
  //   }
  //   // // showDialog(
  //   // //   context: context,
  //   // //   builder: (context) {
  //   // //     return AlertDialog(
  //   // //       title: Text('Submitted Data'),
  //   // //       content: SingleChildScrollView(
  //   // //         child: Column(
  //   // //           crossAxisAlignment: CrossAxisAlignment.start,
  //   // //           children: provider.formFields.map((field) {
  //   // //             String label = field['label'];
  //   // //             // Ensure we show data in the order of formFields
  //   // //             return Text('${label}: ${provider.formData[label] ?? 'Not Provided'}');
  //   // //           }).toList(),
  //   // //         ),
  //   // //       ),
  //   // //       actions: [
  //   // //         TextButton(
  //   // //           onPressed: () {
  //   // //             Navigator.of(context).pop();
  //   // //             //provider.clearFormData(); // Clear form data after submission
  //   // //           },
  //   // //           child: Text('OK'),
  //   // //         ),
  //   // //       ],
  //   // //     );
  //   // //   },
  //   // // );
  // }
}
