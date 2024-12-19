import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';

import '../config.dart';
import '../models/inno_file_upload_item.dart';
import '../utils/common_utils.dart';
import '../utils/datetime_util.dart';
import '../utils/debug_utils.dart';
import '../utils/file_utils.dart';
import 'buttons/primary_button.dart';
import 'buttons/primary_outline_button.dart';
import 'buttons/text_button.dart';
import 'cached_image.dart';
import 'custom_ui_expanded_row.dart';
import 'custom_ui_text_fields.dart';
import 'expanded_text.dart';
import 'innovay_text.dart';
import 'right_arrow.dart';

class DataEntryBarCommonSettings {
  static double rowHeight = 60;
  static EdgeInsets outerPadding = const EdgeInsets.only(left: 1, right: 5, top: 1, bottom: 1);
  static TextStyle inputTextStyle = TextStyle(fontSize: 14, color: InnoConfig.colors.textColor);
  static TextStyle placeholderTextStyle = TextStyle(fontSize: 14, color: InnoConfig.colors.textColorLight9);
  static Color dataColor = InnoConfig.colors.textColor;
  static Color placeholderColor = InnoConfig.colors.textColorLight9;
  static Color starColor = InnoConfig.colors.deleteColor;
}

class DataEntryTextReadOnlyBar extends StatelessWidget {
  final String title;
  final String value;
  final Function()? onTap;
  final bool mandatory;

  const DataEntryTextReadOnlyBar({
    super.key,
    required this.title,
    required this.value,
    this.mandatory = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          InnovayTextButton(
            value,
            () {
              onTap?.call();
            },
            color: DataEntryBarCommonSettings.dataColor,
            fontSize: 14,
          )
        ],
      ),
    );
  }
}

class DataEntryTextBar extends StatelessWidget {
  final bool mandatory;
  final bool readOnly;
  final String title;
  final String currentUserInput;
  final TextInputType inputType;
  final String unit;
  final String selectedUnit;
  final String hintText;
  final Function(String) onUserInput;

  const DataEntryTextBar({
    super.key,
    required this.title,
    required this.currentUserInput,
    required this.onUserInput,
    this.mandatory = false,
    this.readOnly = false,
    this.inputType = TextInputType.text,
    this.unit = '',
    this.selectedUnit = '',
    this.hintText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: currentUserInput,
                  selection: TextSelection.collapsed(offset: currentUserInput.length),
                ),
              ),
              readOnly: readOnly,
              onChanged: onUserInput,
              textAlign: TextAlign.end,
              style: DataEntryBarCommonSettings.inputTextStyle,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.only(right: currentUserInput.isEmpty ? 0 : 0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: hintText.isEmpty ? '${AppLocalizations.of(context)!.pleaseEnter}$title' : '$hintText ',
                hintStyle: DataEntryBarCommonSettings.placeholderTextStyle,
              ),
              keyboardType: inputType,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class DataEntryTextAreaBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final String currentUserInput;
  final Function(String) onUserInput;

  const DataEntryTextAreaBar({
    super.key,
    required this.title,
    required this.currentUserInput,
    required this.onUserInput,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: currentUserInput,
                  selection: TextSelection.collapsed(offset: currentUserInput.length),
                ),
              ),
              style: DataEntryBarCommonSettings.inputTextStyle,
              maxLines: 20,
              minLines: 1,
              // initialValue: currentUserInput,
              onChanged: onUserInput,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: '${AppLocalizations.of(context)!.pleaseEnter}$title',
                hintStyle: DataEntryBarCommonSettings.placeholderTextStyle,
              ),
              keyboardType: TextInputType.multiline,
            ),
          ),
        ],
      ),
    );
  }
}

class DataEntryNameMobileBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final String currentNameUserInput;
  final String currentMobileUserInput;
  final Function(String) onNameUserInput;
  final Function(String) onMobileUserInput;

  const DataEntryNameMobileBar({
    super.key,
    required this.title,
    required this.currentNameUserInput,
    required this.currentMobileUserInput,
    required this.onNameUserInput,
    required this.onMobileUserInput,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: currentNameUserInput,
                  selection: TextSelection.collapsed(offset: currentNameUserInput.length),
                ),
              ),
              style: DataEntryBarCommonSettings.inputTextStyle,
              onChanged: onNameUserInput,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: '${AppLocalizations.of(context)!.pleaseEnter}${AppLocalizations.of(context)!.name}',
                hintStyle: DataEntryBarCommonSettings.placeholderTextStyle,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: currentMobileUserInput,
                  selection: TextSelection.collapsed(offset: currentMobileUserInput.length),
                ),
              ),
              onChanged: onMobileUserInput,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: '${AppLocalizations.of(context)!.pleaseEnter}${AppLocalizations.of(context)!.mobile}',
                hintStyle: DataEntryBarCommonSettings.placeholderTextStyle,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}

class DataEntryLocationBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final String selectedValue;
  final Function(String) onOptionSelected;

  const DataEntryLocationBar({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.onOptionSelected,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    var valueParts = selectedValue.split('-');
    var initialProvince = '', initialCity = '', initialDistrict = '';
    if (valueParts.isNotEmpty) {
      initialProvince = valueParts[0];
      if (valueParts.length >= 2) {
        initialCity = valueParts[1];
      } else if (valueParts.length >= 3) {
        initialDistrict = valueParts[2];
      }
    }

    var textColor =
        selectedValue.isEmpty ? DataEntryBarCommonSettings.placeholderColor : DataEntryBarCommonSettings.dataColor;
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          InnovayTextButton(
            selectedValue.isNotEmpty ? selectedValue : '${AppLocalizations.of(context)!.pleaseSelect}$title',
            () {
              Pickers.showAddressPicker(
                context,
                initProvince: initialProvince,
                initCity: initialCity,
                initTown: initialDistrict,
                addAllItem: false,
                onConfirm: (p, c, t) {
                  onOptionSelected('$p-$c-$t');
                },
              );
            },
            color: textColor,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

class DataEntrySingleSelectBar extends StatefulWidget {
  final bool mandatory;
  final String title;
  final String selectedValue;
  final bool hasNeutralOption;
  final List<dynamic> selectOptions;
  final Function(int) onOptionSelected;

  const DataEntrySingleSelectBar({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.selectOptions,
    required this.onOptionSelected,
    this.mandatory = false,
    this.hasNeutralOption = true,
  });

  @override
  State<DataEntrySingleSelectBar> createState() => _DataEntrySingleSelectBarState();
}

class _DataEntrySingleSelectBarState extends State<DataEntrySingleSelectBar> {
  final List<dynamic> _selectOptions = [];
  String _selectedValue = '';

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
    _selectOptions.addAll(widget.selectOptions);

    if (_selectOptions.isNotEmpty) {
      if (widget.hasNeutralOption) {
        _selectOptions.insert(0, AppLocalizations.of(context)!.pleaseSelect);
      }
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textColor = widget.selectedValue.isEmpty
        ? DataEntryBarCommonSettings.placeholderColor
        : DataEntryBarCommonSettings.dataColor;
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(widget.title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              _showDialog(CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  if (widget.hasNeutralOption) {
                    widget.onOptionSelected(index - 1);
                    _selectedValue = _selectOptions[index - 1];
                  } else {
                    widget.onOptionSelected(index);
                    _selectedValue = _selectOptions[index];
                  }
                  setState(() {});
                },
                children: List<Widget>.generate(_selectOptions.length, (int index) {
                  return Center(child: Text(_selectOptions[index]));
                }),
              ));
            },
            child: InnoText(
              widget.selectedValue.isNotEmpty
                  ? _selectedValue
                  : '${AppLocalizations.of(context)!.pleaseSelect}${widget.title}',
            ),
          ),
        ],
      ),
    );
  }
}

class DataEntrySingleSelectFromSettingsBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final List<dynamic> selectOptions;
  final String selectedValue;
  final Function(String) onSelectionUpdate;

  const DataEntrySingleSelectFromSettingsBar({
    super.key,
    required this.title,
    required this.selectOptions,
    required this.selectedValue,
    required this.onSelectionUpdate,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    var textValue = '${AppLocalizations.of(context)!.pleaseSelect}$title';
    if (selectedValue.isNotEmpty) {
      textValue = selectedValue;
    }
    var textColor =
        selectedValue.isEmpty ? DataEntryBarCommonSettings.placeholderColor : DataEntryBarCommonSettings.dataColor;
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: InnoText(title, color: DataEntryBarCommonSettings.dataColor)),
          const Spacer(),
          InnovayTextButton(textValue, () {
            CommonUtils.displayBottomPicker(context, title, [
              DataEntrySingleSelectFromSettingsBarContent(
                title: title,
                options: selectOptions,
                selected: selectedValue,
                onSelectionUpdate: onSelectionUpdate,
              )
            ]);
          }, fontSize: 14, color: textColor),
        ],
      ),
    );
  }
}

class DataEntrySingleSelectFromSettingsBarContent extends StatefulWidget {
  final String title;
  final List<dynamic> options;
  final String selected;
  final Function(String) onSelectionUpdate;
  final int crossAxisCount;
  final double childAspectRatio;
  final double fontSize;
  final double height;

  const DataEntrySingleSelectFromSettingsBarContent({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelectionUpdate,
    this.crossAxisCount = 3,
    this.childAspectRatio = 2.5,
    this.fontSize = 14,
    this.height = -1,
  });

  @override
  State<DataEntrySingleSelectFromSettingsBarContent> createState() =>
      _DataEntrySingleSelectFromSettingsBarContentState();
}

class _DataEntrySingleSelectFromSettingsBarContentState extends State<DataEntrySingleSelectFromSettingsBarContent> {
  final List<Map<String, dynamic>> _options = [];
  String _selected = '';
  // String _suggestionInput = '';

  @override
  void initState() {
    super.initState();
    for (var item in widget.options) {
      _options.add({
        'key': item['key'],
        'options': item['val'].split(';'),
      });
    }
  }

  void onOptionTap(int index1, int index2) {
    var optionValue = _options[index1]['options'][index2].toString();
    if (_selected == optionValue) return;

    setState(() {
      _selected = optionValue;
      widget.onSelectionUpdate(_selected);
    });
  }

  List<Widget> buildOptionWidgets() {
    var children = <Widget>[];
    for (var i = 0; i < _options.length; i++) {
      var key = _options[i]['key'];
      var currentOptions = _options[i]['options'];
      var optionWidgets = <Widget>[];
      for (var j = 0; j < currentOptions.length; j++) {
        if (_selected == currentOptions[j]) {
          optionWidgets.add(InnovayPrimaryButton(currentOptions[j], () {
            onOptionTap(i, j);
          }, fontSize: widget.fontSize));
        } else {
          optionWidgets.add(InnovayPrimaryOutlineButton(currentOptions[j], () {
            onOptionTap(i, j);
          }, fontSize: widget.fontSize));
        }
      }
      children.add(
        ExpandedRowWidget(
          children: [Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: InnoText(key))],
        ),
      );
      children.add(
        ExpandedRowWidget(
          children: [Wrap(spacing: 10, runSpacing: 10, children: optionWidgets)],
        ),
      );
    }
    children.add(SizedBox(height: MediaQuery.of(context).padding.bottom + 10));
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // width: MediaQuery.of(context).size.width,
      // height: widget.height < 0 ? MediaQuery.of(context).size.height * 0.5 : widget.height,
      child: Column(
        children: buildOptionWidgets(),
      ),
    );
  }
}

class DataEntryDateRangeBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final String currentStartDate;
  final String currentEndDate;
  final Function(String) onStartDateUpdate;
  final Function(String) onEndDateUpdate;

  const DataEntryDateRangeBar({
    super.key,
    required this.title,
    required this.currentStartDate,
    required this.currentEndDate,
    required this.onStartDateUpdate,
    required this.onEndDateUpdate,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    var startDateTextColor =
        currentStartDate.isEmpty ? DataEntryBarCommonSettings.placeholderColor : DataEntryBarCommonSettings.dataColor;

    var endDateTextColor =
        currentEndDate.isEmpty ? DataEntryBarCommonSettings.placeholderColor : DataEntryBarCommonSettings.dataColor;
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: InnoText(title, color: DataEntryBarCommonSettings.dataColor)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InnovayTextButton(
                  currentStartDate.isEmpty ? AppLocalizations.of(context)!.startDate : currentStartDate,
                  () {
                    Pickers.showDatePicker(
                      context,
                      onConfirm: (date) {
                        DebugManager.log(date.toString());
                        onStartDateUpdate('${date.year}/${date.month}/${date.day}');
                      },
                    );
                  },
                  color: startDateTextColor,
                  fontSize: 14,
                ),
                const SizedBox(width: 15),
                InnoText(AppLocalizations.of(context)!.to.toLowerCase()),
                const SizedBox(width: 15),
                InnovayTextButton(currentEndDate.isEmpty ? AppLocalizations.of(context)!.endDate : currentEndDate, () {
                  Pickers.showDatePicker(
                    context,
                    onConfirm: (date) {
                      DebugManager.log(date.toString());
                      onEndDateUpdate('${date.year}/${date.month}/${date.day}');
                    },
                  );
                }, color: endDateTextColor, fontSize: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataEntryDatetimeBar extends StatefulWidget {
  final bool mandatory;
  final String title;
  final PDuration? currentDatetime;
  final Function(PDuration) onConfirm;

  const DataEntryDatetimeBar({
    super.key,
    required this.title,
    required this.currentDatetime,
    required this.onConfirm,
    this.mandatory = false,
  });

  @override
  State<DataEntryDatetimeBar> createState() => _DataEntryDatetimeBarState();
}

class _DataEntryDatetimeBarState extends State<DataEntryDatetimeBar> {
  PDuration? _currentDatetime;

  @override
  void initState() {
    super.initState();
    _currentDatetime = widget.currentDatetime;
  }

  @override
  Widget build(BuildContext context) {
    var currentDatetimeString = '';
    if (_currentDatetime != null) {
      var t = _currentDatetime!;
      currentDatetimeString = '${t.year}-${t.month}-${t.day} ${t.hour}:${t.minute}';
    }
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(widget.title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Pickers.showDatePicker(
                context,
                mode: DateMode.YMDHM,
                selectDate: _currentDatetime,
                onConfirm: (datetime) {
                  DebugManager.log(datetime.toString());
                  setState(() {
                    _currentDatetime = datetime;
                  });
                  widget.onConfirm(datetime);
                },
              );
            },
            child: InnoText(
              _currentDatetime == null ? AppLocalizations.of(context)!.pleaseSelect : currentDatetimeString,
            ),
          ),
        ],
      ),
    );
  }
}

class DataEntryDateBar extends StatefulWidget {
  final bool mandatory;
  final String title;
  final DateTime currentDate;
  final Function(DateTime) onConfirm;

  const DataEntryDateBar({
    super.key,
    required this.title,
    required this.currentDate,
    required this.onConfirm,
    this.mandatory = false,
  });

  @override
  State<DataEntryDateBar> createState() => _DataEntryDateBarState();
}

class _DataEntryDateBarState extends State<DataEntryDateBar> {
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _currentDate = widget.currentDate;
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(widget.title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              _showDialog(
                CupertinoDatePicker(
                  initialDateTime: _currentDate,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  // This shows day of week alongside day of month
                  showDayOfWeek: true,
                  // This is called when the user changes the date.
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => _currentDate = newDate);
                  },
                ),
              );
            },
            child: InnoText(DatetimeUtils.formattedDate(_currentDate)),
          ),
        ],
      ),
    );
  }
}

// class DataEntryImagesBar extends StatelessWidget {
//   final bool mandatory;
//   final String title;
//   final int maxImageCount;
//   final List<Map<String, dynamic>> currentImageList;
//   final Function(List<Map<String, dynamic>>) onImageUploadEnded;
//
//   const DataEntryImagesBar({
//     super.key,
//     required this.title,
//     required this.maxImageCount,
//     required this.currentImageList,
//     required this.onImageUploadEnded,
//     this.mandatory = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: EdgeInsets.only(
//             left: DataEntryBarCommonSettings.outerPadding.left,
//             right: DataEntryBarCommonSettings.outerPadding.right,
//             top: 15),
//         decoration: BoxDecoration(
//           color: InnovayConfig.colors.backgroundColor,
//           border: Border(
//             bottom: BorderSide(color: InnovayConfig.colors.dividerLineColor),
//           ),
//         ),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 const SizedBox(width: 5),
//                 InnovayText('$title (可最多上传$maxImageCount张)', color: DataEntryBarCommonSettings.dataColor),
//                 const SizedBox(width: 15)
//               ]),
//               ImagesUploadManager(
//                   maxImageCount: maxImageCount,
//                   currentImageList: currentImageList,
//                   onImageUploadEnded: onImageUploadEnded)
//             ]));
//   }
// }

class DataEntryFilesBar extends StatefulWidget {
  final bool mandatory;
  final String title;
  final String tip;
  final int maxFileCount;
  final List<Map<String, dynamic>> currentFileList;
  final Function(List<Map<String, dynamic>>) onFileUploadEnded;

  const DataEntryFilesBar({
    super.key,
    required this.title,
    required this.maxFileCount,
    required this.currentFileList,
    required this.onFileUploadEnded,
    this.tip = '',
    this.mandatory = false,
  });

  @override
  State<DataEntryFilesBar> createState() => DataEntryFilesBarState();
}

class DataEntryFilesBarState extends State<DataEntryFilesBar> {
  List<Map<String, dynamic>> _files = [];
  String _tip = '';

  @override
  void initState() {
    super.initState();
    _tip = widget.tip;
    if (_tip.isEmpty) {
      _tip = AppLocalizations.of(context)!.canUploadNumberFiles(widget.maxFileCount);
    }
    _files = widget.currentFileList;
  }

  void onFileTap(int index) {
    var fileUrl = _files[index]['url'];
    // DebugManager.log(_filelist[index]['url']);
    CommonUtils.navigateToFilePreview(context, fileUrl);
  }

  void onAddFileTap() {
    FileUtils.pickFiles(widget.maxFileCount, (List<dynamic> pickedImageList) {
      // DebugManager.log('pick images success');
      // for (var i = 0; i < pickedImageList.length; i++) {
      //   DebugManager.log(pickedImageList[i]['path']);
      // }
      // DebugManager.log(pickedImageList.toString());
      for (var i = 0; i < pickedImageList.length; i++) {
        pickedImageList[i]['isUploading'] = false;
        pickedImageList[i]['isUploaded'] = false;
        pickedImageList[i]['url'] = '';
      }
      setState(() {
        _files = [..._files, ...pickedImageList];
        uploadFiles();
      });
    });
  }

  void uploadFiles() async {
    for (var i = 0; i < _files.length; i++) {
      if (_files[i]['isUploaded']) {
        continue;
      }
      if (_files[i]['isUploading']) {
        // Some file is uploading, do nothing
        return;
      }

      // found the first file to upload, do the upload request and return;
      var pathComponents = _files[i]['path'].split('/');
      DebugManager.unimplemented();

      int imageIndex = i;
      setState(() {
        _files[imageIndex]['isUploading'] = false;
        _files[imageIndex]['isUploaded'] = true;
        _files[imageIndex]['url'] = '';
        uploadFiles();
      });
      return;
    }
    DebugManager.log('All upload completed');
    widget.onFileUploadEnded(_files);
  }

  void onDeleteButtonTap(int index) {
    CommonUtils.displayCustomDialog(
      context,
      AppLocalizations.of(context)!.deleteConfirmationTitle,
      [],
      const Icon(Icons.cancel_outlined),
      const Icon(CupertinoIcons.delete),
      null,
      () {
        setState(() {
          _files.removeAt(index);
        });
      },
      () => null,
      true,
    );
  }

  Widget buildDeleteButton(int index) {
    bool isUploaded = _files[index]['isUploaded'];
    if (!isUploaded) {
      return const SizedBox(width: 40);
    }
    return SizedBox(
        width: 40,
        child: GestureDetector(
            child: Container(
                padding: const EdgeInsets.all(5),
                child: Icon(Icons.remove_circle_outline, size: 24, color: DataEntryBarCommonSettings.placeholderColor)),
            onTap: () {
              onDeleteButtonTap(index);
            }));
  }

  Widget buildAddButton(int index) {
    if (index < _files.length - 1) {
      return const SizedBox(width: 40);
    }
    return SizedBox(
      width: 40,
      child: GestureDetector(
        onTap: onAddFileTap,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Icon(Icons.add_circle_outline, size: 24, color: DataEntryBarCommonSettings.placeholderColor),
        ),
      ),
    );
  }

  List<Widget> buildFileList() {
    List<Widget> widgetList = [];
    for (var i = 0; i < _files.length; i++) {
      List<String> filePathComponents = _files[i]['path'].split('/');
      String fileName = filePathComponents[filePathComponents.length - 1];
      bool isUploaded = _files[i]['isUploaded'];
      widgetList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            ExpandedText(
              '${i + 1}.$fileName${!isUploaded ? AppLocalizations.of(context)!.uploading : ''}',
              color: DataEntryBarCommonSettings.placeholderColor,
            ),
            const SizedBox(width: 10),
            InnovayTextButton(
              AppLocalizations.of(context)!.preview,
              () {
                onFileTap(i);
              },
              fontSize: 14,
            ),
            const SizedBox(width: 10),
            buildDeleteButton(i),
            buildAddButton(i),
          ],
        ),
      );
    }
    // if (_filelist.length < widget.maxFileCount) {
    //   widgetList.add(InnovayTextButton('添加文件', onAddFileTap, fontSize: 14));
    // }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DataEntryBarCommonSettings.outerPadding.left, vertical: 15),
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.mandatory) InnoText('*', color: DataEntryBarCommonSettings.starColor),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 15),
                child: InnoText(widget.title, color: DataEntryBarCommonSettings.dataColor),
              ),
              const Spacer(),
              if (_files.isEmpty)
                InnovayTextButton(_tip, onAddFileTap, color: DataEntryBarCommonSettings.placeholderColor, fontSize: 14),
            ],
          ),
          SizedBox(height: _files.isEmpty ? 0 : 5),
          Column(children: buildFileList()),
        ],
      ),
    );
  }
}

class DataEntryDisplayBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final String content;
  final Function() onTap;

  const DataEntryDisplayBar({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: DataEntryBarCommonSettings.rowHeight,
        padding: DataEntryBarCommonSettings.outerPadding,
        decoration: BoxDecoration(
          color: InnoConfig.colors.backgroundColor,
          border: Border(
            bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            InnoText(title, color: DataEntryBarCommonSettings.dataColor),
            const SizedBox(width: 15),
            ExpandedText(
              content,
              textAlign: TextAlign.right,
              style: DataEntryBarCommonSettings.placeholderTextStyle,
            ),
            // put an empty textfield here to keep paddings consistent with other data display bars
            const SizedBox(width: 0, child: TextField()),
            InnovayRightArrow(onTap: onTap),
          ],
        ),
      ),
    );
  }
}

class DataEntrySingleImageDisplayBar extends StatelessWidget {
  final String title;
  final String imageUrl;

  const DataEntrySingleImageDisplayBar({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          // put an empty textfield here to keep paddings consistent with other data display bars
          const SizedBox(width: 0, child: TextField()),
          GestureDetector(
            onTap: () {
              CommonUtils.displayImageFullScreenBottomSheet(context, [imageUrl], 0);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: InnovayCachedImage(imageUrl, width: 100, height: 50, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

class DataEntrySingleImageUploadBar extends StatefulWidget {
  final String title;
  final String imageUrl;
  final Function(String) onImageUpdated;

  const DataEntrySingleImageUploadBar({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onImageUpdated,
  });

  @override
  State<DataEntrySingleImageUploadBar> createState() => _DataEntrySingleImageUploadBarState();
}

class _DataEntrySingleImageUploadBarState extends State<DataEntrySingleImageUploadBar> {
  String _imageUrl = '';
  int _uploadProgress = 0;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl;
  }

  void _onTap() {
    // CommonUtils.displayImageFullScreenBottomSheet(context, [_imageUrl], 0);
    FileUtils.pickImagesFromGallery(1, (List<InnoFileUploadItem> uploadItems) {
      uploadItems[0].uploadToCloud(
          (document) {
            _imageUrl = document['fileUrl'].toString();
            widget.onImageUpdated(_imageUrl);
            _uploadProgress = 0;
            setState(() {});
          },
          useChunkUpload: true,
          progressCallback: (progress) {
            _uploadProgress = progress;
            setState(() {});
          });
      _uploadProgress = 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(widget.title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          // put an empty text field here to keep paddings consistent with other data display bars
          const SizedBox(width: 0, child: TextField()),
          GestureDetector(
            onTap: _onTap,
            child: Container(
              width: 110,
              height: 60,
              color: InnoConfig.colors.backgroundColor,
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    InnovayCachedImage(_imageUrl, width: 100, height: 50, fit: BoxFit.cover),
                    if (_uploadProgress != 0)
                      Container(
                        color: Colors.black.withOpacity(0.8),
                        child: Center(child: InnoText('$_uploadProgress%', color: Colors.white)),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataEntryMultiSelectBar extends StatelessWidget {
  final bool mandatory;
  final String title;
  final List<dynamic> selectOptions;
  final List<String> selectedValues;
  final Function(List<String>) onSelectionUpdate;

  const DataEntryMultiSelectBar({
    super.key,
    required this.title,
    required this.selectOptions,
    required this.selectedValues,
    required this.onSelectionUpdate,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> options = [];
    for (var i = 0; i < selectOptions.length; i++) {
      options.add(selectOptions[i].toString());
    }
    var textValue = '${AppLocalizations.of(context)!.pleaseSelect}$title';
    if (selectedValues.isNotEmpty) {
      textValue = selectedValues[0];
      if (textValue.length > 5) {
        textValue = textValue.substring(0, 5);
      }
      if (selectedValues.length == 1) {
        textValue = '${AppLocalizations.of(context)!.selected}$textValue';
      } else {
        textValue = '${AppLocalizations.of(context)!.selected}$textValue...(${selectedValues.length})';
      }
    }
    var textColor =
        selectedValues.isEmpty ? DataEntryBarCommonSettings.placeholderColor : DataEntryBarCommonSettings.dataColor;
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          InnovayTextButton(
            textValue,
            () {
              CommonUtils.displayBottomPicker(context, title, [
                DataEntryMultiSelectBarContentWidget(
                  options: options,
                  selected: selectedValues,
                  onSelectionUpdate: onSelectionUpdate,
                )
              ]);
            },
            fontSize: 14,
            color: textColor,
          ),
        ],
      ),
    );
  }
}

class DataEntryMultiSelectBarContentWidget extends StatefulWidget {
  final List<dynamic> options;
  final List<String> selected;
  final Function(List<String>) onSelectionUpdate;
  final int crossAxisCount;
  final double childAspectRatio;
  final double fontSize;
  final double height;

  const DataEntryMultiSelectBarContentWidget({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelectionUpdate,
    this.crossAxisCount = 3,
    this.childAspectRatio = 2.5,
    this.fontSize = 14,
    this.height = -1,
  });

  @override
  State<DataEntryMultiSelectBarContentWidget> createState() => DataEntryMultiSelectBarContentWidgetState();
}

class DataEntryMultiSelectBarContentWidgetState extends State<DataEntryMultiSelectBarContentWidget> {
  final List<String> _selected = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.selected.length; i++) {
      _selected.add(widget.selected[i]);
    }
  }

  void onOptionTap(int index) {
    setState(() {
      if (_selected.contains(widget.options[index])) {
        _selected.remove(widget.options[index]);
      } else {
        _selected.add(widget.options[index]);
      }
      widget.onSelectionUpdate(_selected);
    });
  }

  List<Widget> buildOptionWidgets() {
    List<Widget> children = [];
    for (var i = 0; i < widget.options.length; i++) {
      if (_selected.contains(widget.options[i])) {
        children.add(InnovayPrimaryButton(widget.options[i], () {
          onOptionTap(i);
        }, fontSize: widget.fontSize));
      } else {
        children.add(
          InnovayPrimaryOutlineButton(widget.options[i], () {
            onOptionTap(i);
          }, fontSize: widget.fontSize),
        );
      }
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // width: MediaQuery.of(context).size.width,
      height: widget.height < 0 ? MediaQuery.of(context).size.height * 0.5 : widget.height,
      child: GridView.count(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: widget.childAspectRatio,
        children: buildOptionWidgets(),
      ),
    );
  }
}

class DataEntryPhoneListBar extends StatefulWidget {
  final bool mandatory;
  final String title;
  final String initialPhoneList;
  final Function(String) onUserInput;

  const DataEntryPhoneListBar({
    super.key,
    required this.title,
    required this.initialPhoneList,
    required this.onUserInput,
    this.mandatory = false,
  });

  @override
  State<DataEntryPhoneListBar> createState() => DataEntryPhoneListBarState();
}

class DataEntryPhoneListBarState extends State<DataEntryPhoneListBar> {
  List<String> _phoneList = [];

  @override
  void initState() {
    super.initState();
    _phoneList = widget.initialPhoneList.split(';');
    if (_phoneList.isEmpty) {
      _phoneList.add('');
    }
  }

  void onAddPhoneTap() {
    setState(() {
      _phoneList.add('');
      callWidgetOnUserInput();
    });
  }

  void onRemovePhoneTap(int index) {
    setState(() {
      _phoneList.removeAt(index);
      if (_phoneList.isEmpty) {
        _phoneList.add('');
      }
      callWidgetOnUserInput();
    });
  }

  void callWidgetOnUserInput() {
    var filteredPhoneList = [];
    for (var item in _phoneList) {
      if (item.isNotEmpty) {
        filteredPhoneList.add(item);
      }
    }
    widget.onUserInput(filteredPhoneList.join(';'));
  }

  Widget buildPhoneInput(int index) {
    return Row(key: Key('$index-${_phoneList[index]}'), children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          // decoration: BoxDecoration(
          //     border: Border(bottom: BorderSide(color: InnovayConfig.colors.dividerLineColor))),
          child: CustomTextFieldWidget(
            initialValue: _phoneList[index],
            textInputType: TextInputType.number,
            textAlign: TextAlign.end,
            textFieldStyle: 'noBorders',
            hintText: '${AppLocalizations.of(context)!.pleaseEnter}${AppLocalizations.of(context)!.mobile}',
            fontSize: 14,
            onChange: (val) {
              _phoneList[index] = val;
              callWidgetOnUserInput();
            },
          ),
        ),
      ),
      SizedBox(
        width: 40,
        child: GestureDetector(
          onTap: () {
            onRemovePhoneTap(index);
          },
          child: Icon(
            Icons.remove_circle_outline,
            color: DataEntryBarCommonSettings.placeholderColor,
          ),
        ),
      ),
      SizedBox(
        width: 40,
        child: index == _phoneList.length - 1
            ? GestureDetector(
                onTap: () {
                  onAddPhoneTap();
                },
                child: Icon(
                  Icons.add_circle_outline,
                  color: DataEntryBarCommonSettings.placeholderColor,
                ),
              )
            : const SizedBox.shrink(),
      ),
    ]);
  }

  Widget buildPhoneInputList() {
    var children = <Widget>[];
    for (var i = 0; i < _phoneList.length; i++) {
      children.add(buildPhoneInput(i));
    }
    return Column(children: children);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: DataEntryBarCommonSettings.outerPadding,
      padding: EdgeInsets.symmetric(
        horizontal: DataEntryBarCommonSettings.outerPadding.left,
        vertical: DataEntryBarCommonSettings.outerPadding.top + 10,
      ),
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(widget.title, color: DataEntryBarCommonSettings.dataColor),
          ),
          Expanded(
            child: buildPhoneInputList(),
          ),
        ],
      ),
    );
  }
}

class DataEntrySwitchBar extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onValueChanged;
  final Color? color;

  const DataEntrySwitchBar({
    super.key,
    required this.title,
    required this.value,
    required this.onValueChanged,
    this.color = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DataEntryBarCommonSettings.rowHeight,
      padding: DataEntryBarCommonSettings.outerPadding,
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColor,
        border: Border(
          bottom: BorderSide(color: InnoConfig.colors.dividerLineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: InnoText(title, color: DataEntryBarCommonSettings.dataColor),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            onChanged: onValueChanged,
            activeColor: color,
          ),
        ],
      ),
    );
  }
}
