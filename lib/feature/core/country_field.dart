import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

class CountryField extends FormField<String> {
  CountryField({
    super.key,
    FormFieldValidator<String>? validator,
    void Function(String?)? onSaved,
    String? initialValue,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(
          validator: validator ??
              (value) {
                if (value == null) {
                  _requestLocationPermission();
                  return 'Please select a country';
                }
                return null;
              },
          onSaved: onSaved,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> state) {
            return GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: state.context,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    state.didChange(country.name);
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: state.hasError ? Colors.red : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 24,
                          color: Colors.grey.shade600,
                        ),
                        const Gap(10),
                        Text(
                          state.value ?? 'Select Country',
                          style: Theme.of(state.context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontSize: 18,
                                color: state.value == null
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 5),
                      child: Text(
                        state.errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            );
          },
        );

  static Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      // You can show a dialog guiding the user to enable it from settings.
      debugPrint("Location permission denied.");
    } else {
      debugPrint("Location permission granted.");
    }
  }
}
