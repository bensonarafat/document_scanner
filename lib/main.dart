import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DocumentScanner documentScanner;
  DocumentScannerOptions options = DocumentScannerOptions(
    mode: ScannerMode.filter, // to control the feature sets in the flow
    isGalleryImport: false, // importing from the photo gallery
    pageLimit: 1, // setting a limit to the number of pages scanned
  );

  List<String>? documents;

  @override
  void initState() {
    documentScanner = DocumentScanner(options: options);
    super.initState();
  }

  @override
  void dispose() {
    documentScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Document Scanner'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.document_scanner_outlined,
                size: 250,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: startScan,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Start Scan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startScan() async {
    try {
      documents = await documentScanner.scanDocument();
      print('documents: $documents');
    } catch (e) {
      print('Error: $e');
    }
  }
}
