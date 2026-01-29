import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_archit/app/data/models/user_model.dart';
import 'package:getx_with_archit/app/modules/home_screen/controller/home_controller.dart';
import 'package:getx_with_archit/app/modules/home_screen/views/widgets/user_card.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
        backgroundColor: Colors.pink.shade500,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.hasError.value) {
                return Center(child: Text(controller.errorMessage.value));
              }
              if (controller.users.isEmpty) {
                return const Center(child: Text('No Users Found'));
              }
              return ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return UserCard(
                    user: user,
                    onDelete: () => _showDeleteDialog(context, user),
                    onTap: () => _showUserDetails(context, user),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => UserDetailsSheet(user: user),
    );
  }

  void _showDeleteDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name} ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteUser(user.id!.toInt());
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
