import 'package:flutter/material.dart';
import 'package:getx_with_archit/app/data/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.user,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.yellow[200],
          child: Text(
            user.name!.isNotEmpty ? user.name![0].toUpperCase() : '?',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          user.name.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(user.email.toString()),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        onTap: onTap,
      ),
    );
  }
}

class UserDetailsSheet extends StatelessWidget {
  final UserModel user;

  const UserDetailsSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              color: Colors.blue[500],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.brown[100],
                    child: Text(
                      user.name!.isNotEmpty ? user.name![0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name!.toString(),
                    style: GoogleFonts.playwritePe(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email!.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Address : ',
                    style: GoogleFonts.mochiyPopOne(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  userAddressTable(),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userAddressTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(1.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                color: Colors.lightBlueAccent.shade400,
                child: Text('Street : '),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                color: Colors.lightBlueAccent.shade400,
                child: Text(
                  user.address!.street ?? '',
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                color: Colors.white,
                child: Text('Suite : '),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                color: Colors.white,
                child: Text(
                  user.address!.suite ?? '',
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                color: Colors.lightBlueAccent.shade400,
                child: Text(
                  'City : ',
                  overflow: TextOverflow.ellipsis,
                  style: tableCellTextStyle(),
                ),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                color: Colors.lightBlueAccent.shade400,
                child: Text(
                  user.address!.street ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: tableCellTextStyle(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextStyle tableCellTextStyle() {
    return GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600);
  }
}
