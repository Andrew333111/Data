import 'package:flutter/material.dart';

class DataWarga extends StatefulWidget {
  @override
  _DataWargaState createState() => _DataWargaState();
}

class _DataWargaState extends State<DataWarga> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _wargaList = [
    {"nama": "Bagas", "nomorHP": "08123456789"},
    {"nama": "Budi", "nomorHP": "087654321"},
  ];

  List<Map<String, String>> _searchResult = [];

  @override
  void initState() {
    _searchResult.addAll(_wargaList);
    super.initState();
  }

  void _searchWarga(String query) {
    _searchResult.clear();
    if (query.isEmpty) {
      setState(() {
        _searchResult.addAll(_wargaList);
      });
    } else {
      setState(() {
        _searchResult.addAll(_wargaList.where((warga) =>
            warga['nama']!.toLowerCase().contains(query.toLowerCase())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Warga'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: _searchWarga,
              decoration: InputDecoration(
                hintText: 'Cari nama warga...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResult[index]['nama']!),
                  subtitle: Text(_searchResult[index]['nomorHP']!),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddWargaDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddWargaDialog() {
    String _nama = '';
    String _nomorHP = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Data Warga'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  _nama = value;
                },
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  _nomorHP = value;
                },
                decoration: InputDecoration(labelText: 'Nomor HP'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (_nama.isNotEmpty && _nomorHP.isNotEmpty) {
                  setState(() {
                    _wargaList.add({"nama": _nama, "nomorHP": _nomorHP});
                    _searchResult.add({"nama": _nama, "nomorHP": _nomorHP});
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }
}
