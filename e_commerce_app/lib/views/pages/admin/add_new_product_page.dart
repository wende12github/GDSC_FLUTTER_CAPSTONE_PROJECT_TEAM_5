import 'package:flutter/material.dart';
import 'package:gdsc_captone_project/services/email_password_auth/signout.dart';
import 'package:gdsc_captone_project/views/shared/fonts/google_font.dart';
import 'package:file_picker/file_picker.dart';


void main() {
  runApp(const AdminPage());
}

class AdminPage extends StateFulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _MyAppState();
}

class _MyAppState extends State<AdminPage> {
  _MyAppState() {
    _selectedSize = sizeOptions[0];
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedSize = "";
  List<String> sizeOptions = ['small', 'medium', 'large'];

  Future<void> _uploadFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        sizeOptions = result.paths.map((path) => path!).toList();
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async => await EmailPasswordSignout.signOut(context),
            icon: const Icon(Icons.logout_outlined),
            color: Theme.of(context).colorScheme.inversePrimary,
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
                child: Text(
                  'Add New Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: .4),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: OutlinedButton.icon(
                    onPressed: _uploadFile,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 74, 37, 161)),
                    ),
                    icon: const Icon(Icons.upload_outlined),
                    label: const Text(
                      'Upload Product Picture',
                      style: TextStyle(color: Color.fromARGB(255, 74, 35, 161)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Text(
                  'Product Name',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'eg. Nike',
                      prefixIcon: Icon(Icons.verified_user_outlined),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 0, 0),
                    child: Text(
                      'Product Price',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'eg. \$300',
                      prefixIcon: Icon(Icons.verified_user_outlined),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 0, 0),
                    child: Text(
                      'Product Description',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText:
                          "eg. Lorem ipsum dolor sit omet,\nconsectetur adipiscing elit",
                      prefixIcon: Icon(Icons.verified_user_outlined),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 0, 0),
                    child: Text(
                      'Product Size',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedSize,
                    hint: const Text(
                      'Select Size',
                    ),
                    items: sizeOptions.map((String size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSize = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                    ),
                    dropdownColor: Colors.deepPurple.shade50,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.verified_user_outlined),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                String productName = _nameController.text;
                double productPrice = double.parse(_priceController.text);
                String productDescription = _descriptionController.text;

                print('Product Name: $productName');
                print('Product Price: $productPrice');
                print('Product Description: $productDescription');
                print('Selected Size: $_selectedSize');
                print('Selected Files: $sizeOptions');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 74, 37, 161),
              ),
              child: const Text(
                'Add Product',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
    );
  }
}
