import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentFormPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  // Controller untuk mengambil input teks
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();

  // Variabel untuk status On/Off mahasiswa aktif
  bool _isActive = false;

  // Variabel untuk menyimpan data yang akan ditampilkan setelah tombol ditekan
  String _submittedName = '';
  String _submittedSemester = '';
  String _submittedStatus = '';

  // Fungsi untuk menyimpan dan menampilkan data
  void _submitData() {
    setState(() {
      _submittedName = _nameController.text;
      _submittedSemester = _semesterController.text;
      _submittedStatus = _isActive ? 'Aktif' : 'Tidak Aktif';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _semesterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Mahasiswa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Nama Mahasiswa
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Mahasiswa',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),

            // Input Semester
            TextField(
              controller: _semesterController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Semester',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol On/Off Mahasiswa Aktif (Switch List Tile)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SwitchListTile(
                title: const Text('Status Mahasiswa Aktif'),
                subtitle: Text(_isActive ? 'Status: Aktif (ON)' : 'Status: Tidak Aktif (OFF)'),
                value: _isActive,
                onChanged: (bool value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            ElevatedButton(
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'SIMPAN & TAMPILKAN',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),

            // Bagian untuk menampilkan hasil input
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            const Text(
              'Pratinjau Data Mahasiswa:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama     : ${_submittedName.isEmpty ? '-' : _submittedName}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Semester : ${_submittedSemester.isEmpty ? '-' : _submittedSemester}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Status   : ', style: TextStyle(fontSize: 16)),
                        Text(
                          _submittedStatus.isEmpty ? '-' : _submittedStatus,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _submittedStatus == 'Aktif' ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}