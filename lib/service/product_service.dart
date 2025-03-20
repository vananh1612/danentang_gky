import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giua_ky/models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection("MyProducts");

  // Thêm sản phẩm vào Firestore
  Future<void> addProduct(Product product, BuildContext context) async {
    try {
      await _productsCollection.doc(product.id).set(product.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sản phẩm đã được thêm thành công!")),
      );
      Navigator.pushNamed(context, '/list');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi thêm sản phẩm: $e")),
      );
    }
  }

  // Lấy sản phẩm theo ID
  Future<Product?> getProductById(String productId) async {
    try {
      DocumentSnapshot doc = await _productsCollection.doc(productId).get();
      if (!doc.exists) return null;
      return Product.fromFirestore(doc);
    } catch (e) {
      throw Exception("Lỗi khi lấy sản phẩm: $e");
    }
  }

  // Cập nhật sản phẩm
  Future<void> updateProduct(Product product, BuildContext context) async {
    try {
      await _productsCollection.doc(product.id).update(product.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sản phẩm đã được cập nhật thành công!")),
      );
      Navigator.pushNamed(context, '/list');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi cập nhật sản phẩm: $e")),
      );
    }
  }

  // Xóa sản phẩm
  Future<void> deleteProduct(String id, BuildContext context) async {
    try {
      await _productsCollection.doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sản phẩm đã được xóa thành công!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi xóa sản phẩm: $e")),
      );
    }
  }

  // Lấy danh sách tất cả sản phẩm
  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot querySnapshot = await _productsCollection.get();
      return querySnapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception("Lỗi khi lấy danh sách sản phẩm: $e");
    }
  }

  // Tìm kiếm sản phẩm theo tên
  Future<List<Product>> searchProducts(String key) async {
    try {
      QuerySnapshot querySnapshot = await _productsCollection
          .where("idsanpham", isGreaterThanOrEqualTo: key)
          .where("idsanpham", isLessThanOrEqualTo: key + '\uf8ff')
          .get();
      return querySnapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception("Lỗi khi tìm kiếm sản phẩm: $e");
    }
  }
}
