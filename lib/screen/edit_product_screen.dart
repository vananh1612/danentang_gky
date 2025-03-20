import 'dart:io';
import 'package:flutter/material.dart';
import '../service/product_service.dart';
import '../service/image_service.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ProductService _productService = ProductService();
  final ImageService _imageService = ImageService();

  String? _imageUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    setState(() {
      isLoading = true;
    });

    try {
      Product? product = await _productService.getProductById(widget.productId);
      if (product != null) {
        setState(() {
          nameController.text = product.idsanpham;
          typeController.text = product.loaisp;
          priceController.text = product.gia.toString();
          _imageUrl = product.hinhanh;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload hình thành công'),
            duration: Duration(seconds: 1), // Chỉ hiển thị trong 1 giây
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi tải sản phẩm: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _uploadImage() async {
    final url = await _imageService.uploadImage();
    if (url != null) {
      setState(() {
        _imageUrl = url;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload hình thành công')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload thất bại')),
      );
    }
  }

  Future<void> _updateProduct() async {
    setState(() {
      isLoading = true;
    });

    try {
      Product updatedProduct = Product(
        id: widget.productId,
        idsanpham: nameController.text,
        loaisp: typeController.text,
        gia: double.tryParse(priceController.text) ?? 0,
        hinhanh: _imageUrl ?? "",
      );

      await _productService.updateProduct(updatedProduct, context);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Cập nhật sản phẩm thành công!")),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chỉnh sửa sản phẩm")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Tên sản phẩm",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.shopping_cart),
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
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.category),
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
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.attach_money),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _uploadImage,
                    icon: Icon(Icons.image),
                    label: Text('Chọn ảnh'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8BB2F8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                          onPressed: _updateProduct,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            textStyle: TextStyle(fontSize: 16),
                          ),
                          child: Text("Cập nhật sản phẩm"),
                        ),
                ],
              ),
            ),
    );
  }
}
