import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/profile_provider/edit_profile_provider.dart';
import '../../providers_of_app/profile_provider/profile_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_text.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
class EditProfileFormPage extends StatefulWidget {

  EditProfileFormPage();

  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<EditProfileFormPage> {
  late Map<String, TextEditingController> _controllers;
  String imageProfileUrl = "";

  @override
  void initState() {
    super.initState();
    _controllers = {};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EditProfileProvider>(context, listen: false).fetchFormFields();
    });
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
  void dialogProfile(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container()),
                    Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () {
                                 // getImgCamera();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20,left: 15),
                              child: Text("Camera",style: TextStyle(fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                            )
                          ],
                        )
                    ),


                    Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: IconButton(
                                icon: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () {
                                  //_imageFromGallery();
                                 // getImg();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20,left: 15),
                              child: Text("Gallery",style: TextStyle(fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                            )
                          ],
                        )
                    ),

                    Flexible(
                        flex: 1,
                        child: Container()),
                  ],
                )
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<EditProfileProvider>(context); // listen to provider
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        // Clear form data before navigating back
        final provider = Provider.of<EditProfileProvider>(context, listen: false);
        provider.resetState(); // Ensure this method clears all form data
        return true; // Allow navigation back
      },
      child: Scaffold(
          // appBar: AppBar(title: Text('')),
          body:Consumer<EditProfileProvider>(builder: (context,valustate,child){
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
                    child:Column(
                      children: [
                        Container(
                          width: 360,
                          height: 166,
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 16,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            gradient: SweepGradient(
                              center: Alignment(0.11, 0.76),
                              startAngle: -0.78,
                              endAngle: -0.11,
                              colors: [
                                splashProvider.color_bg,
                                splashProvider.color_bg
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x1E000000),
                                blurRadius: 16,
                                offset: Offset(0, 12),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Consumer<DashboardProvider>(
                              builder: (context, valustate, child) {
                                if (valustate.isloading_profile) {
                                  return Center(
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          margin: EdgeInsets.only(top: 10),
                                          child: CircularProgressIndicator()));
                                } else {
                                  if (valustate.hasError_profile) {
                                    return Container(
                                      width: double.infinity,
                                      margin:
                                      EdgeInsets.only(top: 15, left: 10, right: 10),

                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('${valustate.errorMessage_profile}'),
                                            ElevatedButton(
                                              onPressed: () {
                                                valustate.retryProfile();
                                              },
                                              child: Text('Retry'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 30,),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.arrow_back, color: Colors.white),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Edit Profile",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Container(
                                              width: 48,
                                              height: 48,
                                              margin: EdgeInsets.only(left: 10),
                                              decoration: ShapeDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment(0.00, -1.00),
                                                  end: Alignment(0, 1),
                                                  colors: [Colors.black.withOpacity(0), Colors.black],
                                                ),
                                                shape: OvalBorder(
                                                  side: BorderSide(width: 2, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(valustate.profile?.consumerName.toString().split(' ')[0]??"",style: TextStyle(fontSize: 18,color: Colors.white),),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      text: "KYC : ${_getKYCStatusText(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0)}",
                                                      color: _getKYCStatusColor(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                                      fontSize: 12,
                                                    ),
                                                    SizedBox(width: 4), // Spacing between text and icon
                                                    Icon(
                                                      _getKYCStatusIcon(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                                      color: _getKYCStatusColor1(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Spacer(),

                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                }
                              }),
                        ),
                       Expanded(
                           child: SingleChildScrollView(
                           child: Container(
                           margin: EdgeInsets.only(bottom: 16.0,left: 16,right: 16,top: 15),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(5)),
                               color: Colors.white),
                           child: Column(
                             children: [
                               SizedBox(height: 15,),
                               SizedBox(
                                 width: 90,
                                 height: 90,
                                 child: Center(
                                   child: Stack(
                                     children: <Widget>[
                                       CircleAvatar(
                                           radius: 120,
                                           child:imageProfileUrl.isEmpty?CircleAvatar(
                                             radius: 42,
                                             backgroundImage: AssetImage('assets/profile_photo_demo.jpg'),
                                             backgroundColor:Colors.grey,
                                           ): ClipOval(
                                             child: Image.network(
                                               "",
                                               width: 120,
                                               height: 120,
                                               fit: BoxFit.fill,
                                               loadingBuilder:
                                                   (BuildContext context,
                                                   Widget child,
                                                   ImageChunkEvent?
                                                   loadingProgress) {
                                                 if (loadingProgress == null)
                                                   return child;
                                                 return Center(
                                                   child:
                                                   CircularProgressIndicator(
                                                     value: loadingProgress
                                                         .expectedTotalBytes !=
                                                         null
                                                         ? loadingProgress
                                                         .cumulativeBytesLoaded /
                                                         loadingProgress
                                                             .expectedTotalBytes!
                                                         : null,
                                                   ),
                                                 );
                                               },
                                             ),
                                           )),
                                       //Container//Container
                                       Positioned(
                                         top: 65,
                                         left: 65,
                                         child: GestureDetector(
                                           onTap: () {
                                             dialogProfile(context);
                                           },
                                           child:Material(
                                             elevation: 4.0,  // Set the elevation (higher value = more shadow)
                                             shape: CircleBorder(),  // Ensures the container remains circular
                                             child: Container(
                                               height: 25,
                                               width: 25,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Colors.white,
                                               ),
                                               child: Icon(
                                                 Icons.edit,
                                                 color: Colors.black54,
                                                 size: 15,
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                       //Container
                                     ], //<Widget>[]
                                   ), //Stack
                                 ), //Center
                               ),
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
                                   padding: EdgeInsets.only(bottom: 16.0,left: 16,right: 16), // Add margin below each field
                                   child: fieldWidget,
                                 );
                               }).toList(),
                               SizedBox(height: 20),
                               Consumer<EditProfileProvider>(
                                 builder: (context, provider, child) {
                                   return    Container(
                                     width: double.infinity,
                                     color: Colors.white,
                                     child: Padding(
                                       padding: const EdgeInsets.only(left: 8,right: 8),
                                       child: ElevatedButton(
                                         onPressed: () async {
                                           if (formProvider.formKey.currentState!.validate()) {

                                           }
                                           String requestData="";
                                           for (var field in provider.formFields) {
                                             String label = field['label'];
                                             bool isMandatory = !(field['optional'] ?? true);
                                             String? fieldValue = provider.formData[label]?.toString();
                                             // Skip validation for "mobile" field
                                             if (label == "Mobile") {
                                               continue;
                                             }
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
                                               //String value = provider.formData[label]?.toString() ?? "";
                                               String value;

                                               // Regular processing for other labels
                                               value = provider.formData[label]?.toString() ?? "";

                                               return "$label=$value";
                                             }).join("<@>");
                                             requestData=formattedData;
                                             // Log or show the formatted data for debugging
                                             print("Formatted Data: $formattedData");

                                           }
                                           var value1=await provider.submitForm(requestData);
                                           if (value1 != null) {
                                             var status = value1["success"] ?? false;
                                             var msg = value1["message"] ?? AppUrl.warningMSG;
                                             if (status) {
                                               toastRedC(msg);
                                               Provider.of<ProfileProvider>(context, listen: false).getProfileDetail();
                                               Navigator.pop(context);
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
                             ],
                           ),
                         ),
                       ))
                      ],
                    )

                );
              }
            }})
      ),
    );
  }

  String _getKYCStatusText(int? status) {
    switch (status) {
      case 0:
        return "Pending";
      case 1:
        return "Verified";
      case 2:
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  Color _getKYCStatusColor(int? status) {
    switch (status) {
      case 0:
        return Colors.orange; // Pending - Orange color
      case 1:
        return Colors.white; // Verified - Green color
      case 2:
        return Colors.white; // Rejected - Red color
      default:
        return Colors.grey; // Unknown - Grey color
    }
  }
  Color _getKYCStatusColor1(int? status) {
    switch (status) {
      case 0:
        return Colors.orange; // Pending - Orange color
      case 1:
        return Colors.green; // Verified - Green color
      case 2:
        return Colors.white; // Rejected - Red color
      default:
        return Colors.grey; // Unknown - Grey color
    }
  }
  IconData _getKYCStatusIcon(int? status) {
    switch (status) {
      case 0:
        return Icons.error; // Pending
      case 1:
        return Icons.verified; // Verified
      case 2:
        return Icons.cancel; // Rejected
      default:
        return Icons.help_outline; // Unknown
    }
  }

  Widget buildTextField(Map<String, dynamic> field, EditProfileProvider provider) {
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
    // Detect if the field is PinCode for numeric keyboard
    bool isPinCodeField = field['label'].toString().endsWith("PinCode");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1'],textAlign: TextAlign.start,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
        TextFormField(
          controller: controller,
          readOnly: isReadOnly,
          keyboardType: isPinCodeField
              ? TextInputType.number // Show numeric keyboard for PinCode
              : TextInputType.text,
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
            // if ((value == null || value.isEmpty) && !field['optional']) {
            //   return 'Please enter ${field['label']}';
            // }
            return null;
          },
        ),
      ],
    );
  }
  Widget buildPasswordField(Map<String, dynamic> field, EditProfileProvider provider) {
    bool isMandatory = field['optional'] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label'],textAlign: TextAlign.start,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
        TextFormField(
          obscureText: !provider.isPasswordVisible,
          decoration: InputDecoration(
            labelText: field['label'],
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
            if ((value == null || value.isEmpty) && !field['optional']) {
              return 'Please enter ${field['label']}';
            }
            return null;
          },
        ),
      ],
    );
  }


  Widget buildDropdown(Map<String, dynamic> field, EditProfileProvider provider) {
    String? selectedValue = field['options']
        ?.map((e) => e.toString().trim().toLowerCase()) // Normalize options
        .contains(field['value']?.toString().trim().toLowerCase()) // Normalize value
        ? field['value']
        : null;
    print("----dropdown value---${selectedValue}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1'],
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: field['hint'],
            contentPadding: EdgeInsets.only(left: 9,top: 5,bottom: 5),
            labelStyle: TextStyle(fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded border
            ),
          ),
          value: selectedValue,
          items: (field['options'] as List<dynamic>)
              .map(
                (option) => DropdownMenuItem(
              value: option.toString(),
              child: Text(option.toString()),
            ),
          )
              .toList(),
          onChanged: selectedValue != null
              ? null // Disabled when pre-selected value exists
              : (value) {
            provider.updateFormData(field['label'], value); // Update value
            field['value'] = value; // Update internal value
          },
          validator: (value) {
            if (value == null && !field['optional']) {
              return 'Please select ${field['label']}';
            }
            return null;
          },
        ),
      ],
    );
  }


  Widget buildRadioButton(Map<String, dynamic> field, EditProfileProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1']),
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


  Widget buildDateField(Map<String, dynamic> field, EditProfileProvider provider) {
    TextEditingController controller = TextEditingController(
      text: provider.formData[field['label']] ?? '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label1'],textAlign: TextAlign.start,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
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
}