import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class SubmissionForm extends StatefulWidget {
  @override
  _SubmissionFormState createState() => _SubmissionFormState();
}

class _SubmissionFormState extends State<SubmissionForm> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? courseTitle;
  String? supervisorName;
  String? studentRollNo;
  String? semester;
  String? programName;
  File? file;
  bool isCheckboxChecked = false;
  bool isSubmitting = false;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<bool> _canSubmit(String rollNo) async {
    final startOfDay = DateTime.now().subtract(Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond,
    ));

    final submissions = await FirebaseFirestore.instance
        .collection('submissions')
        .where('studentRollNo', isEqualTo: rollNo)
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .get();

    return submissions.docs.length < 2;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && file != null && isCheckboxChecked) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Expanded(child: Text("Submitting assignment...")),
              ],
            ),
          );
        },
      );

      setState(() {
        isSubmitting = true;
      });

      if (await _canSubmit(studentRollNo!)) {
        try {
          // Upload file to Firebase Storage
          String fileName = file!.path.split('/').last;
          Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
          UploadTask uploadTask = storageRef.putFile(file!);
          TaskSnapshot taskSnapshot = await uploadTask;
          String fileURL = await taskSnapshot.ref.getDownloadURL();

          // Save form data to Firestore
          await FirebaseFirestore.instance.collection('submissions').add({
            'name': name,
            'courseTitle': courseTitle,
            'supervisorName': supervisorName,
            'studentRollNo': studentRollNo,
            'semester': semester,
            'programName': programName,
            'fileURL': fileURL,
            'timestamp': FieldValue.serverTimestamp(),
          });

          Navigator.of(context).pop(); // Close the loading dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Form Submitted Successfully!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        } catch (e) {
          Navigator.of(context).pop(); // Close the loading dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Failed to submit form: $e"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        Navigator.of(context).pop(); // Close the loading dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Submission Limit Reached"),
              content: Text("You can only submit twice per day."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }

      setState(() {
        isSubmitting = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields, upload a file, and check the box')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Submission Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Course Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your course title';
                  }
                  return null;
                },
                onSaved: (value) {
                  courseTitle = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Supervisor Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your supervisor\'s name';
                  }
                  return null;
                },
                onSaved: (value) {
                  supervisorName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Student Roll Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your roll number';
                  }
                  return null;
                },
                onSaved: (value) {
                  studentRollNo = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Semester'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your semester';
                  }
                  return null;
                },
                onSaved: (value) {
                  semester = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Program Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your program name';
                  }
                  return null;
                },
                onSaved: (value) {
                  programName = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Pick File'),
              ),
              if (file != null) Text('Selected file: ${file!.path}'),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text('I confirm to submit this assignment'),
                value: isCheckboxChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isCheckboxChecked = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCheckboxChecked ? Colors.deepPurple : Colors.grey,
                ),
                child: Text(isSubmitting ? 'Submitting...' : 'Submit',
                style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
