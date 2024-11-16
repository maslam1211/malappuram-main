import 'package:flutter/material.dart';
import 'package:malappuram/model/client.dart';
import 'package:malappuram/viewmodels/client_models.dart';
import 'package:provider/provider.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({super.key});

  @override
  _ClientFormState createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  final _formKey = GlobalKey<FormState>();
  String clientName = "";
  String phoneNumber = "";
  String emailAddress = "";
  String location = "";
  String address = "";
  String status = "";
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: const Text(
                    "ADD NEW CLIENT",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    50.0,
                  ),
                  child: Divider(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0, bottom: 15),
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.download_for_offline_outlined,
                                size: 140,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Drop logo here',
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 90.0),
                          child: Center(
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Status",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 106),
                                    child: Switch(
                                      value: isActive,
                                      onChanged: (value) {
                                        setState(() {
                                          isActive = value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        width:
                            16), 
                    
                    Expanded(
                      child: Column(
                        children: [
                          _buildTextField(
                            label: "       Client Name",
                            onSaved: (value) => clientName = value!,
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Name is required';
                              }
                              if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                                return 'Name can only contain letters and spaces';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            label: "       Phone Number",
                            onSaved: (value) => phoneNumber = value!,
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Phone number is required';
                              }
                              if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                                return 'Enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            label: "       Email Address",
                            onSaved: (value) => emailAddress = value!,
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            label: "       Location",
                            onSaved: (value) => location = value!,
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Location is required';
                              }
                              if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                                return 'Location can only contain letters and spaces';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AddressTextField(
                            onSaved: (value) => address = value!,
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Address is required';
                              }
                              if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                                return 'Address can only contain letters and spaces';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 78.0),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 88, 81, 80)),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              side:
                                                  BorderSide(color: Colors.grey)))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 58.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.red),
                                        shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                side: BorderSide(
                                                    color: Colors.red)))),
                                    onPressed: () {
                                      print("isActive $isActive");
                                      _formKey.currentState!.save();
                                      if (_formKey.currentState!.validate()) {
                                        final client = Client(
                                          clientId: "",
                                          clientName: clientName,
                                          phoneNumber: phoneNumber,
                                          emailAddress: emailAddress,
                                          location: location,
                                          address: address,
                                          status:
                                              isActive ? "Active" : "Inactive",
                                        );
                                        print("client ${client.status}");
                                        Provider.of<ClientViewModelProvider>(
                                                context,
                                                listen: false)
                                            .addClient(client);

                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      FormFieldSetter<String>? onSaved,
      int maxLines = 1,
      String? Function(String? value)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onSaved,
        validator: validator,
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final FormFieldSetter<String>? onSaved;

  const AddressTextField({
    Key? key,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 10.0), 
      child: TextFormField(
        maxLines: 10, 
        keyboardType:
            TextInputType.multiline, 
        decoration: InputDecoration(
          labelText: "Address", 
          
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), 
        ),
        onSaved: onSaved,
        validator: validator ??
            (value) =>
                null, 
      ),
    );
  }
}
