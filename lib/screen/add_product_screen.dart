import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giua_ky/image_picker_widget.dart';
import 'package:giua_ky/models/product.dart';
import '../service/product_service.dart';
import '../service/image_service.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final ProductService _productService = ProductService();
  final ImageService _imageService = ImageService();
  String? _imageUrl; // Lưu trữ URL của ảnh đã tải lên

  bool isLoading = false;

  // Phương thức này được sử dụng để tải ảnh lên
  Future<void> _uploadImage() async {
    final url = await _imageService.uploadImage(); // Tải ảnh lên
    if (url != null) {
      setState(() {
        _imageUrl = url; // Lưu URL của ảnh đã tải lên
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload hình thành công'),
          duration: Duration(seconds: 1), // Chỉ hiển thị trong 1 giây
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload thất bại')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thêm sản phẩm")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: "Tên sản phẩm",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.shopping_bag),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                labelText: "Loại sản phẩm",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.shopping_bag),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: "Giá sản phẩm",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.attach_money),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Nút ElevatedButton.icon để tải ảnh lên
            ElevatedButton.icon(
              onPressed: _uploadImage,
              icon: const Icon(Icons.image),
              label: const Text('Thêm ảnh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8BB2F8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Hiển thị ảnh đã tải lên (nếu có)
            if (_imageUrl != null)
              Image.network(
                _imageUrl!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await _productService.addProduct(
                          Product(
                            id: idController.text.trim(),
                            idsanpham: idController.text.trim(),
                            loaisp: typeController.text.trim(),
                            gia: double.parse(priceController.text.trim()),
                            hinhanh:
                                _imageUrl ?? "", // Sử dụng URL ảnh đã tải lên
                          ),
                          context,
                        );
                        idController.clear();
                        typeController.clear();
                        priceController.clear();
                        imageUrlController.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Lỗi: ${e.toString()}")),
                        );
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text("Thêm sản phẩm"),
                  ),
          ],
        ),
      ),
    );
  }
}
