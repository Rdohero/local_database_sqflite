import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locak_database_sqflite/database_instance.dart';
import 'package:locak_database_sqflite/model/product_model.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel? productModel;
  const UpdateScreen({super.key, this.productModel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    nameController.text = widget.productModel!.name ?? '';
    categoryController.text = widget.productModel!.category ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit"),),
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
                await databaseInstance.update(widget.productModel!.id!, {
                  'name' : nameController.text,
                  'category' : categoryController.text,
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
