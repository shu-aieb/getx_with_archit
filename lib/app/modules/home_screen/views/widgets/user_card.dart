import 'dart:math';

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
          backgroundColor: Colors.blue.shade100,
          child: Text(
            user.name != null
                ? user.name!.isNotEmpty
                      ? user.name!
                            .substring(0, min(3, user.name!.length))
                            .toUpperCase()
                      : '?'
                : '...',
            style: GoogleFonts.playwritePe(
              fontWeight: FontWeight.bold,
              fontSize: 8,
              color: Colors.blue.shade700,
            ),
          ),
        ),
        title: Text(
          user.name.toString(),
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.playwritePe(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.blue.shade800,
          ),
        ),
        subtitle: Text(
          user.email.toString(),
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300),
        ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          user.name!.isNotEmpty
                              ? user.name!
                                    .substring(0, min(3, user.name!.length))
                                    .toUpperCase()
                              : '?',
                          style: GoogleFonts.playwritePe(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name!.toString(),
                            style: GoogleFonts.playwritePe(
                              color: Colors.blue.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user.email!.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Divider(color: Colors.grey.shade300, thickness: 2),
                  const SizedBox(height: 10),
                  _segmentHeading('Address : '),
                  const SizedBox(height: 8),
                  userAddressTable(),
                  const SizedBox(height: 15),
                  Divider(color: Colors.grey.shade300, thickness: 2),
                  const SizedBox(height: 10),
                  _segmentHeading('Contact Information : '),
                  const SizedBox(height: 8),
                  _contactInformationTable([
                    ['Phone :', user.phone ?? ''],
                    ['Email :', user.email ?? ''],
                  ]),
                  const SizedBox(height: 15),
                  Divider(color: Colors.grey.shade300, thickness: 2),
                  const SizedBox(height: 10),
                  _segmentHeading('Company : '),
                  const SizedBox(height: 8),
                  _contactInformationTable([
                    ['Name :', user.company!.name ?? ''],
                    ['Catch Phrase :', user.company!.catchPhrase ?? ''],
                    ['Bs :', user.company!.bs ?? ''],
                  ]),
                  const SizedBox(height: 15),
                  Divider(color: Colors.grey.shade300, thickness: 2),
                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'Close',
                      style: GoogleFonts.padauk(color: Colors.white),
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

  Widget _contactInformationTable(List<List<String>> info) {
    return Table(
      border: TableBorder.all(color: Colors.blue.shade700),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(1.0),
      },
      children: [
        //_buildAddressRow('Phone', user.phone ?? '', false),
        ...info.asMap().entries.map((i) {
          int index = i.key;
          List<String> value = i.value;
          return _buildAddressRow(value[0], value[1], index % 2 != 0);
        }),
        //_buildAddressRow('Website', user.website ?? '', true),
      ],
    );
  }

  Widget userAddressTable() {
    Address? address = user.address;
    return address == null
        ? const Expanded(child: Text('No Address Found'))
        : Table(
            border: TableBorder.all(color: Colors.blue.shade700),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(1.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildAddressRow('Street : ', address.street ?? '', false),
              _buildAddressRow('Suite : ', address.suite ?? '', true),
              _buildAddressRow('City : ', address.city ?? '', false),
              _buildAddressRow('Zip Code : ', address.zipcode ?? '', true),
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.fill,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      color: Colors.blue.shade300,
                      child: Text('Geo : ', style: tableCellTextStyle()),
                    ),
                  ),
                  TableCell(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue.shade200,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  child: Text(
                                    'Lat',
                                    style: tableCellTextStyle(),
                                  ),
                                ),
                              ),

                              Container(
                                color: Colors.blue.shade700,
                                width: 1,
                                height: 25,
                              ),
                              Expanded(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  child: Text(
                                    address.geo!.lat ?? '',
                                    style: tableCellTextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.blue.shade700,
                          height: 1,
                          width: double.infinity,
                        ),

                        //
                        Container(
                          color: Colors.blue.shade100,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  child: Text(
                                    'Lng',
                                    style: tableCellTextStyle(),
                                  ),
                                ),
                              ),

                              Container(
                                color: Colors.blue.shade700,
                                width: 1,
                                height: 25,
                              ),
                              Expanded(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  child: Text(
                                    address.geo!.lng ?? '',
                                    style: tableCellTextStyle(),
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
          );
  }

  TableRow _buildAddressRow(String label, String value, bool isLight) {
    final color = isLight ? Colors.white : Colors.blue.shade300;
    return TableRow(
      children: [
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: color,
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: tableCellTextStyle(),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: color,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: tableCellTextStyle().copyWith(fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle tableCellTextStyle() {
    return GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500);
  }

  Text _segmentHeading(String label) {
    return Text(
      label,
      style: GoogleFonts.deliusSwashCaps(
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade900,
        fontSize: 18,
      ),
    );
  }
}
