import 'package:flutter/material.dart';
import 'package:malappuram/model/client.dart';
import 'package:malappuram/viewmodels/client_models.dart';
import 'package:malappuram/views/clients/client_form.dart';
import 'package:provider/provider.dart';

class ClientList extends StatefulWidget {
  const ClientList({Key? key}) : super(key: key);

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  int currentPage = 0;
  int itemsPerPage = 10;
  String searchQuery = '';

  List<Client> get filteredData {
    if (searchQuery.isEmpty) {
      return Provider.of<ClientViewModelProvider>(context, listen: false)
          .clients;
    }
    return Provider.of<ClientViewModelProvider>(context, listen: false)
        .clients
        .where((item) =>
            item.clientName!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  List<Client> get currentItems {
    if (filteredData.isEmpty) return [];
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return filteredData.sublist(
      startIndex,
      endIndex > filteredData.length ? filteredData.length : endIndex,
    );
  }

  int get totalPages => (filteredData.length / itemsPerPage).ceil();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientViewModelProvider>().fetchClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ClientViewModelProvider>().fetchClients();
            },
          ),
        ],
      ),
      body: Consumer<ClientViewModelProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.clients.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }
          // if (filteredData.isEmpty) {
          //   return const Center(
          //     child: Text(
          //       'No clients found.',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //   );
          // }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 500,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search by Client Name',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                            currentPage = 0;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Container(
                        width: 200,
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ClientForm()),
                              );
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              height: 38,
                              child: Center(
                                child: Text(
                                  "Add New Client",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final columnWidth = constraints.maxWidth / 8;
                      return SingleChildScrollView(
                        child: DataTable(
                          columnSpacing:
                              0, // Ensure no extra spacing between columns
                          columns: [
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text(
                                      'LOGO',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))),
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text('CLIENT ID',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))),
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text('CLIENT NAME',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))),
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text('PHONE NUMBER',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))),
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text('EMAIL ADRESS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))),
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text('LOCATION',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))),
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text('ADRESS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))),
                            DataColumn(
                                label: SizedBox(
                                    width: columnWidth,
                                    child: const Text('STATUS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center))),
                          ],
                          rows: currentItems.map((client) {
                            return DataRow(
                              cells: [
                                DataCell(Center(child: const CircleAvatar())),
                                DataCell(
                                    Center(child: Text(client.clientId ?? ""))),
                                DataCell(Center(
                                    child: Text(client.clientName ?? ""))),
                                DataCell(Center(
                                    child: Text(client.phoneNumber ?? ""))),
                                DataCell(Center(
                                    child: Text(client.emailAddress ?? ""))),
                                DataCell(
                                    Center(child: Text(client.location ?? ""))),
                                DataCell(
                                    Center(child: Text(client.address ?? ""))),
                                DataCell(
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 31,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: client.status == "Active"
                                            ? Color.fromARGB(255, 59, 207, 121)
                                            : const Color.fromARGB(
                                                255, 165, 159, 160),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        client.status ?? "",
                                        style: TextStyle(
                                          color: client.status == "Active"
                                              ? Colors.white
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Pagination Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: Text('Showing'),
                        ),
                        Container(
                          height: 38,
                          width: 90,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: DropdownButton<int>(
                            underline: const SizedBox(),
                            elevation: 30,
                            value: itemsPerPage,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  itemsPerPage = value;
                                  currentPage = 0;
                                });
                              }
                            },
                            items: [10, 25, 50, 100].map((e) {
                              return DropdownMenuItem<int>(
                                value: e,
                                child: Text(
                                  '$e',
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'items per page',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Page ${currentPage + 1} of $totalPages',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: currentPage < totalPages - 1
                              ? () {
                                  setState(() {
                                    currentPage++;
                                  });
                                }
                              : null,
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: currentPage > 0
                              ? () {
                                  setState(() {
                                    currentPage--;
                                  });
                                }
                              : null,
                          child: const Text('End'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
