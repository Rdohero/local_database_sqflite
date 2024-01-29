import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locak_database_sqflite/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama Product"),
            TextField(
              controller: nameController,
            ),
            const SizedBox(height: 15,),
            const Text("Category"),
            TextField(
              controller: categoryController,
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.insert({
                    'name' : nameController.text,
                    'category' : categoryController.text,
                    'created_at' : DateTime.now().toString(),
                    'updated_at' : DateTime.now().toString(),
                  });
                  Get.back();
                  setState(() {
                  });
                },
                child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
