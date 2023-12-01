import 'package:flutter/material.dart';
import 'package:form_app/utils/form_validators.dart';
import 'package:form_app/widgets/elevated_button_widget.dart';
import 'package:form_app/widgets/text_field_widget.dart';
import 'package:form_app/services/service.dart';

class ContactFormScreen extends StatelessWidget {
  const ContactFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
      ),
      body: const ContactForm(),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  ContactFormState createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _isButtonDisabled = true;
  String _resultMessage = '';
  String _buttonText = 'Send';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              buildTextField(
                controller: _nameController,
                labelText: 'Name',
                validator: FormValidators.validateName,
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 40.0),
              buildTextField(
                controller: _emailController,
                labelText: 'Email',
                validator: FormValidators.validateEmail,
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 40.0),
              buildTextField(
                controller: _messageController,
                labelText: 'Message',
                validator: FormValidators.validateMessage,
                onChanged: (value) => _validateForm(),
              ),
              const SizedBox(height: 55.0),
              buildSubmitButton(
                isButtonDisabled: _isButtonDisabled,
                onPressed: _submitForm,
                buttonText: _buttonText,
              ),
              const SizedBox(height: 10.0),
              Text(_resultMessage,
                  style: TextStyle(
                    color: _resultMessage.startsWith('Error')
                        ? Colors.red
                        : Colors.green,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _isValidEmail(_emailController.text) &&
        _messageController.text.isNotEmpty;
  }

  void _validateForm() {
    if (_form.currentState!.validate() && _isValid()) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  Future<void> _submitForm() async {
    if (_form.currentState!.validate() && _isValid()) {
      setState(() {
        _buttonText = 'Please, wait...';
      });

      try {
        final resultMessage = await FormService.submitForm(
          name: _nameController.text,
          email: _emailController.text,
          message: _messageController.text,
        );

        setState(() {
          _resultMessage = resultMessage;
          _buttonText = 'Send';
        });
      } catch (error) {
        setState(() {
          _resultMessage = 'Error: $error';
          _buttonText = '';
        });
      }
    }
  }
}
