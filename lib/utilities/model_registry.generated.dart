// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY
// Generate this file by running `dart run :generate`

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wick_apps/utilities/type_converter.dart';
import 'package:wick_apps/models/tile.dart';
import 'package:wick_apps/models/paginated_response.dart';
import 'package:wick_apps/models/preferences.dart';
import 'package:wick_apps/models/dashboard_configuration.dart';
import 'package:wick_apps/models/user.dart';
import 'package:wick_apps/models/tile_option.dart';
import 'package:wick_apps/models/form_inputs/base.dart';
import 'package:wick_apps/models/form_inputs/text.dart';
import 'package:wick_apps/models/form_inputs/image.dart';
import 'package:wick_apps/models/form_inputs/dropdown_option.dart';
import 'package:wick_apps/models/form_inputs/checkbox.dart';
import 'package:wick_apps/models/form_inputs/dropdown.dart';
import 'package:wick_apps/models/form_inputs/field.dart';
import 'package:wick_apps/models/send_verification_email_response.dart';
import 'package:wick_apps/models/session_provider.dart';
import 'package:wick_apps/models/navigation_provider.dart';
import 'package:wick_apps/models/model_information.dart';
import 'package:wick_apps/models/session.dart';
import 'package:wick_apps/models/navigation_option.dart';
import 'package:wick_apps/models/sign_in_response.dart';
import 'package:wick_apps/pages/initial.dart';
import 'package:wick_apps/pages/base.dart';
import 'package:wick_apps/pages/dashboard_base.dart';
import 'package:wick_apps/pages/loading.dart';
import 'package:wick_apps/widgets/application.dart';
import 'package:wick_apps/widgets/forms/base.dart';
import 'package:wick_apps/widgets/forms/stack.dart';
import 'package:wick_apps/widgets/forms/inputs/text.dart';
import 'package:wick_apps/widgets/forms/inputs/image.dart';
import 'package:wick_apps/widgets/forms/inputs/checkbox.dart';
import 'package:wick_apps/widgets/forms/inputs/dropdown.dart';
import 'package:wick_apps/widgets/card.dart';
import 'package:wick_apps/widgets/button.dart';
import 'package:wick_apps/widgets/dialog.dart';
import 'package:wick_apps/widgets/table.dart';
import 'package:wick_apps/widgets/loading_indicator.dart';
import 'package:wick_apps/widgets/icon_button.dart';
import 'package:wick_apps/enums/brightness.dart';
import 'package:wick_apps/enums/date_format.dart';
import 'package:wick_apps/enums/color.dart';
import 'package:wick_apps/enums/text_validation.dart';
import 'package:wick_apps/enums/keyboard_type.dart';
import 'package:wick_apps/enums/image_shapes.dart';
import 'package:wick_apps/enums/file_sizes.dart';
import 'package:wick_apps/controllers/base.dart';
import 'package:wick_apps/enums/button_type.dart';
import 'package:wick_apps/enums/button_theme.dart';
import 'package:wick_apps/enums/model_attributes/tile.generated.dart';
import 'package:wick_apps/enums/model_attributes/paginated_response.generated.dart';
import 'package:wick_apps/enums/model_attributes/preferences.generated.dart';
import 'package:wick_apps/enums/model_attributes/dashboard_configuration.generated.dart';
import 'package:wick_apps/enums/model_attributes/user.generated.dart';
import 'package:wick_apps/enums/model_attributes/tile_option.generated.dart';
import 'package:wick_apps/enums/model_attributes/form_input_base.generated.dart';
import 'package:wick_apps/enums/model_attributes/form_input_text.generated.dart';
import 'package:wick_apps/enums/model_attributes/form_input_image.generated.dart';
import 'package:wick_apps/enums/model_attributes/form_input_dropdown_option.generated.dart';
import 'package:wick_apps/enums/model_attributes/form_input_checkbox.generated.dart';
import 'package:wick_apps/enums/model_attributes/form_input_dropdown.generated.dart';
import 'package:wick_apps/enums/model_attributes/form_input_field.generated.dart';
import 'package:wick_apps/enums/model_attributes/send_verification_email_response.generated.dart';
import 'package:wick_apps/enums/model_attributes/provider_session.generated.dart';
import 'package:wick_apps/enums/model_attributes/provider_navigation.generated.dart';
import 'package:wick_apps/enums/model_attributes/information.generated.dart';
import 'package:wick_apps/enums/model_attributes/session.generated.dart';
import 'package:wick_apps/enums/model_attributes/navigation_option.generated.dart';
import 'package:wick_apps/enums/model_attributes/sign_in_response.generated.dart';
import 'package:wick_apps/enums/model_attributes/page_initial.generated.dart';
import 'package:wick_apps/enums/model_attributes/page_base.generated.dart';
import 'package:wick_apps/enums/model_attributes/page_dashboard_base.generated.dart';
import 'package:wick_apps/enums/model_attributes/page_loading.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_application.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_form_base.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_form_stack.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_form_input_text.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_form_input_image.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_form_input_checkbox.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_form_input_dropdown.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_card.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_button.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_dialog.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_table.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_loading_indicator.generated.dart';
import 'package:wick_apps/enums/model_attributes/widget_icon_button.generated.dart';

class WickUtilityModelRegistry {
  static final Map<Type, Type> attributes = {
    WickModelTile: WickEnumModelAttributeTile,
    WickModelPaginatedResponse: WickEnumModelAttributePaginatedResponse,
    WickModelPreferences: WickEnumModelAttributePreferences,
    WickModelDashboardConfiguration: WickEnumModelAttributeDashboardConfiguration,
    WickModelUser: WickEnumModelAttributeUser,
    WickModelTileOption: WickEnumModelAttributeTileOption,
    WickModelFormInputBase: WickEnumModelAttributeFormInputBase,
    WickModelFormInputText: WickEnumModelAttributeFormInputText,
    WickModelFormInputImage: WickEnumModelAttributeFormInputImage,
    WickModelFormInputDropdownOption: WickEnumModelAttributeFormInputDropdownOption,
    WickModelFormInputCheckbox: WickEnumModelAttributeFormInputCheckbox,
    WickModelFormInputDropdown: WickEnumModelAttributeFormInputDropdown,
    WickModelFormInputField: WickEnumModelAttributeFormInputField,
    WickModelSendVerificationEmailResponse: WickEnumModelAttributeSendVerificationEmailResponse,
    WickModelWickProviderSession: WickEnumModelAttributeProviderSession,
    WickModelWickProviderNavigation: WickEnumModelAttributeProviderNavigation,
    WickModelModelInformation: WickEnumModelAttributeInformation,
    WickModelSession: WickEnumModelAttributeSession,
    WickModelNavigationOption: WickEnumModelAttributeNavigationOption,
    WickModelSignInResponse: WickEnumModelAttributeSignInResponse,
    WickPageInitial: WickEnumModelAttributePageInitial,
    WickPageBase: WickEnumModelAttributePageBase,
    WickPageDashboardBase: WickEnumModelAttributePageDashboardBase,
    WickPageLoading: WickEnumModelAttributePageLoading,
    WickWidgetApplication: WickEnumModelAttributeWidgetApplication,
    WickWidgetFormBase: WickEnumModelAttributeWidgetFormBase,
    WickWidgetFormStack: WickEnumModelAttributeWidgetFormStack,
    WickWidgetFormInputText: WickEnumModelAttributeWidgetFormInputText,
    WickWidgetFormInputImage: WickEnumModelAttributeWidgetFormInputImage,
    WickWidgetFormInputCheckbox: WickEnumModelAttributeWidgetFormInputCheckbox,
    WickWidgetFormInputDropdown: WickEnumModelAttributeWidgetFormInputDropdown,
    WickWidgetCard: WickEnumModelAttributeWidgetCard,
    WickWidgetButton: WickEnumModelAttributeWidgetButton,
    WickWidgetDialog: WickEnumModelAttributeWidgetDialog,
    WickWidgetTable: WickEnumModelAttributeWidgetTable,
    WickWidgetLoadingIndicator: WickEnumModelAttributeWidgetLoadingIndicator,
    WickWidgetIconButton: WickEnumModelAttributeWidgetIconButton,
  };

  static final Map<Type, Function(Map<String, dynamic>)> constructors = {
    WickModelTile: (attributes) => WickModelTile(
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      icon: WickUtilityTypeConverter.toType<IconData>(attributes['icon']),
      content: WickUtilityTypeConverter.toType<List<Widget>>(attributes['content']),
      activeByDefault: WickUtilityTypeConverter.toType<bool>(attributes['activeByDefault'])
    ),
    WickModelPaginatedResponse: (attributes) => WickModelPaginatedResponse(
      instances: WickUtilityTypeConverter.toType<List<dynamic>>(attributes['instances']),
      totalInstances: WickUtilityTypeConverter.toType<int>(attributes['totalInstances'])
    ),
    WickModelPreferences: (attributes) => WickModelPreferences(
      userId: WickUtilityTypeConverter.toType<int>(attributes['userId']),
      brightness: WickUtilityTypeConverter.toType<WickEnumBrightness>(attributes['brightness']),
      dateFormat: WickUtilityTypeConverter.toType<WickEnumDateFormat>(attributes['dateFormat']),
      primaryColor: WickUtilityTypeConverter.toType<WickEnumColor>(attributes['primaryColor'])
    ),
    WickModelDashboardConfiguration: (attributes) => WickModelDashboardConfiguration(
      id: WickUtilityTypeConverter.toType<int>(attributes['id']),
      userId: WickUtilityTypeConverter.toType<int>(attributes['userId']),
      dashboard: WickUtilityTypeConverter.toType<String>(attributes['dashboard']),
      configuration: WickUtilityTypeConverter.toType<String>(attributes['configuration'])
    ),
    WickModelUser: (attributes) => WickModelUser(
      id: WickUtilityTypeConverter.toType<int>(attributes['id']),
      email: WickUtilityTypeConverter.toType<String>(attributes['email']),
      picture: WickUtilityTypeConverter.toType<String?>(attributes['picture']),
      firstName: WickUtilityTypeConverter.toType<String?>(attributes['firstName']),
      lastName: WickUtilityTypeConverter.toType<String?>(attributes['lastName']),
      birthday: WickUtilityTypeConverter.toType<DateTime?>(attributes['birthday'])
    ),
    WickModelTileOption: (attributes) => WickModelTileOption(
      active: WickUtilityTypeConverter.toType<bool>(attributes['active']),
      name: WickUtilityTypeConverter.toType<String>(attributes['name'])
    ),
    WickModelFormInputText: (attributes) => WickModelFormInputText(
      validations: WickUtilityTypeConverter.toType<List<WickEnumTextValidation>>(attributes['validations']),
      keyboardType: WickUtilityTypeConverter.toType<WickEnumKeyboardType>(attributes['keyboardType']),
      isSecret: WickUtilityTypeConverter.toType<bool>(attributes['isSecret']),
      multipleLines: WickUtilityTypeConverter.toType<bool>(attributes['multipleLines']),
      defaultValue: WickUtilityTypeConverter.toType<String?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.toType<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.toType<String?>(attributes['helpText'])
    ),
    WickModelFormInputImage: (attributes) => WickModelFormInputImage(
      shape: WickUtilityTypeConverter.toType<WickEnumImageShape>(attributes['shape']),
      maxSize: WickUtilityTypeConverter.toType<WickEnumFileSize>(attributes['maxSize']),
      defaultValue: WickUtilityTypeConverter.toType<Uint8List?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.toType<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.toType<String?>(attributes['helpText'])
    ),
    WickModelFormInputDropdownOption: (attributes) => WickModelFormInputDropdownOption(
      value: WickUtilityTypeConverter.toType<String?>(attributes['value']),
      label: WickUtilityTypeConverter.toType<String>(attributes['label']),
      icon: WickUtilityTypeConverter.toType<IconData?>(attributes['icon'])
    ),
    WickModelFormInputCheckbox: (attributes) => WickModelFormInputCheckbox(
      displayName: WickUtilityTypeConverter.toType<bool>(attributes['displayName']),
      defaultValue: WickUtilityTypeConverter.toType<bool?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.toType<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.toType<String?>(attributes['helpText'])
    ),
    WickModelFormInputDropdown: (attributes) => WickModelFormInputDropdown(
      options: WickUtilityTypeConverter.toType<List<WickModelFormInputDropdownOption>>(attributes['options']),
      defaultValue: WickUtilityTypeConverter.toType<String?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.toType<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.toType<String?>(attributes['helpText'])
    ),
    WickModelFormInputField: (attributes) => WickModelFormInputField(
      fieldName: WickUtilityTypeConverter.toType<String>(attributes['fieldName']),
      defaultValue: WickUtilityTypeConverter.toType<dynamic>(attributes['defaultValue']),
      autoFill: WickUtilityTypeConverter.toType<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.toType<String?>(attributes['helpText'])
    ),
    WickModelSendVerificationEmailResponse: (attributes) => WickModelSendVerificationEmailResponse(
      sessionId: WickUtilityTypeConverter.toType<int>(attributes['sessionId'])
    ),
    WickModelWickProviderSession: (attributes) => WickModelWickProviderSession(
      token: WickUtilityTypeConverter.toType<String>(attributes['token'])
    ),
    WickModelWickProviderNavigation: (attributes) => WickModelWickProviderNavigation(
      lastRoute: WickUtilityTypeConverter.toType<String>(attributes['lastRoute'])
    ),
    WickModelModelInformation: (attributes) => WickModelModelInformation(
      className: WickUtilityTypeConverter.toType<String>(attributes['className']),
      importPath: WickUtilityTypeConverter.toType<String>(attributes['importPath']),
      attributes: WickUtilityTypeConverter.toType<Map<String, String>>(attributes['attributes'])
    ),
    WickModelSession: (attributes) => WickModelSession(
      id: WickUtilityTypeConverter.toType<int>(attributes['id']),
      userId: WickUtilityTypeConverter.toType<int>(attributes['userId']),
      code: WickUtilityTypeConverter.toType<String>(attributes['code']),
      successfulAttempts: WickUtilityTypeConverter.toType<int>(attributes['successfulAttempts']),
      failedAttempts: WickUtilityTypeConverter.toType<int>(attributes['failedAttempts']),
      started: WickUtilityTypeConverter.toType<DateTime>(attributes['started']),
      expires: WickUtilityTypeConverter.toType<DateTime>(attributes['expires']),
      device: WickUtilityTypeConverter.toType<String>(attributes['device']),
      location: WickUtilityTypeConverter.toType<String>(attributes['location'])
    ),
    WickModelNavigationOption: (attributes) => WickModelNavigationOption(
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      route: WickUtilityTypeConverter.toType<String>(attributes['route']),
      icon: WickUtilityTypeConverter.toType<IconData>(attributes['icon']),
      destination: WickUtilityTypeConverter.toType<Widget>(attributes['destination']),
      isMain: WickUtilityTypeConverter.toType<bool>(attributes['isMain'])
    ),
    WickModelSignInResponse: (attributes) => WickModelSignInResponse(
      sessionToken: WickUtilityTypeConverter.toType<String>(attributes['sessionToken'])
    ),
    WickPageInitial: (attributes) => WickPageInitial(
      homeRoute: WickUtilityTypeConverter.toType<String>(attributes['homeRoute']),
      isAuthenticated: WickUtilityTypeConverter.toType<bool>(attributes['isAuthenticated'])
    ),
    WickPageBase: (attributes) => WickPageBase(
      title: WickUtilityTypeConverter.toType<String>(attributes['title']),
      alignment: WickUtilityTypeConverter.toType<Alignment>(attributes['alignment']),
      content: WickUtilityTypeConverter.toType<List<Widget>>(attributes['content']),
      additionalActionButtons: WickUtilityTypeConverter.toType<List<Widget>>(attributes['additionalActionButtons']),
      displayMainNavigation: WickUtilityTypeConverter.toType<bool>(attributes['displayMainNavigation']),
      icon: WickUtilityTypeConverter.toType<IconData?>(attributes['icon']),
      drawer: WickUtilityTypeConverter.toType<Widget?>(attributes['drawer'])
    ),
    WickPageDashboardBase: (attributes) => WickPageDashboardBase(
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      tiles: WickUtilityTypeConverter.toType<List<WickModelTile>>(attributes['tiles']),
      icon: WickUtilityTypeConverter.toType<IconData?>(attributes['icon']),
      drawer: WickUtilityTypeConverter.toType<Widget?>(attributes['drawer'])
    ),
    WickPageLoading: (attributes) => WickPageLoading(
      action: WickUtilityTypeConverter.toType<String?>(attributes['action'])
    ),
    WickWidgetApplication: (attributes) => WickWidgetApplication(
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      navigationOptions: WickUtilityTypeConverter.toType<List<WickModelNavigationOption>>(attributes['navigationOptions']),
      homeRoute: WickUtilityTypeConverter.toType<String>(attributes['homeRoute']),
      defaultPrimaryColor: WickUtilityTypeConverter.toType<WickEnumColor>(attributes['defaultPrimaryColor'])
    ),
    WickWidgetFormBase: (attributes) => WickWidgetFormBase(
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      inputs: WickUtilityTypeConverter.toType<List<WickModelFormInputBase>>(attributes['inputs']),
      submitButtonText: WickUtilityTypeConverter.toType<String>(attributes['submitButtonText']),
      autoSubmit: WickUtilityTypeConverter.toType<bool>(attributes['autoSubmit']),
      autoFocus: WickUtilityTypeConverter.toType<bool>(attributes['autoFocus']),
      debounce: WickUtilityTypeConverter.toType<Duration>(attributes['debounce']),
      onSubmit: WickUtilityTypeConverter.toType<Function(Map<String, dynamic>)>(attributes['onSubmit'])
    ),
    WickWidgetFormStack: (attributes) => WickWidgetFormStack(
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      inputs: WickUtilityTypeConverter.toType<List<WickModelFormInputField>>(attributes['inputs']),
      controller: WickUtilityTypeConverter.toType<WickControllerBase<dynamic>>(attributes['controller']),
      primaryKey: WickUtilityTypeConverter.toType<int?>(attributes['primaryKey']),
      submitButtonText: WickUtilityTypeConverter.toType<String>(attributes['submitButtonText']),
      autoSubmit: WickUtilityTypeConverter.toType<bool>(attributes['autoSubmit']),
      autoFocus: WickUtilityTypeConverter.toType<bool>(attributes['autoFocus']),
      debounce: WickUtilityTypeConverter.toType<Duration>(attributes['debounce'])
    ),
    WickWidgetFormInputText: (attributes) => WickWidgetFormInputText(
      input: WickUtilityTypeConverter.toType<WickModelFormInputText>(attributes['input']),
      onChanged: WickUtilityTypeConverter.toType<Function(String?)>(attributes['onChanged']),
      onEnterPressed: WickUtilityTypeConverter.toType<Function()>(attributes['onEnterPressed']),
      focusNode: WickUtilityTypeConverter.toType<FocusNode?>(attributes['focusNode'])
    ),
    WickWidgetFormInputImage: (attributes) => WickWidgetFormInputImage(
      input: WickUtilityTypeConverter.toType<WickModelFormInputImage>(attributes['input']),
      onChanged: WickUtilityTypeConverter.toType<Function(String?)>(attributes['onChanged'])
    ),
    WickWidgetFormInputCheckbox: (attributes) => WickWidgetFormInputCheckbox(
      input: WickUtilityTypeConverter.toType<WickModelFormInputCheckbox>(attributes['input']),
      onChanged: WickUtilityTypeConverter.toType<Function(String?)>(attributes['onChanged'])
    ),
    WickWidgetFormInputDropdown: (attributes) => WickWidgetFormInputDropdown(
      input: WickUtilityTypeConverter.toType<WickModelFormInputDropdown>(attributes['input']),
      onChanged: WickUtilityTypeConverter.toType<Function(String?)>(attributes['onChanged'])
    ),
    WickWidgetCard: (attributes) => WickWidgetCard(
      icon: WickUtilityTypeConverter.toType<IconData>(attributes['icon']),
      title: WickUtilityTypeConverter.toType<String>(attributes['title']),
      content: WickUtilityTypeConverter.toType<List<Widget>>(attributes['content']),
      isWide: WickUtilityTypeConverter.toType<bool>(attributes['isWide'])
    ),
    WickWidgetButton: (attributes) => WickWidgetButton(
      onPressed: WickUtilityTypeConverter.toType<Function()>(attributes['onPressed']),
      message: WickUtilityTypeConverter.toType<String>(attributes['message']),
      icon: WickUtilityTypeConverter.toType<IconData?>(attributes['icon']),
      type: WickUtilityTypeConverter.toType<WickEnumButtonType>(attributes['type']),
      theme: WickUtilityTypeConverter.toType<WickEnumButtonTheme>(attributes['theme']),
      isWide: WickUtilityTypeConverter.toType<bool>(attributes['isWide'])
    ),
    WickWidgetDialog: (attributes) => WickWidgetDialog(
      icon: WickUtilityTypeConverter.toType<IconData>(attributes['icon']),
      title: WickUtilityTypeConverter.toType<String>(attributes['title']),
      content: WickUtilityTypeConverter.toType<List<Widget>>(attributes['content']),
      displayActions: WickUtilityTypeConverter.toType<bool>(attributes['displayActions']),
      okayMessage: WickUtilityTypeConverter.toType<String>(attributes['okayMessage']),
      displayCancel: WickUtilityTypeConverter.toType<bool>(attributes['displayCancel'])
    ),
    WickWidgetTable: (attributes) => WickWidgetTable(
      data: WickUtilityTypeConverter.toType<List<dynamic>>(attributes['data']),
      displayHeader: WickUtilityTypeConverter.toType<bool>(attributes['displayHeader']),
      canReorderRows: WickUtilityTypeConverter.toType<bool>(attributes['canReorderRows']),
      editableColumnKeys: WickUtilityTypeConverter.toType<List<String>>(attributes['editableColumnKeys'])
    ),
    WickWidgetLoadingIndicator: (attributes) => WickWidgetLoadingIndicator(
      action: WickUtilityTypeConverter.toType<String?>(attributes['action'])
    ),
    WickWidgetIconButton: (attributes) => WickWidgetIconButton(
      name: WickUtilityTypeConverter.toType<String>(attributes['name']),
      icon: WickUtilityTypeConverter.toType<IconData>(attributes['icon']),
      onPressed: WickUtilityTypeConverter.toType<void Function()>(attributes['onPressed'])
    ),
  };

  static final Map<Type, Map<String, Function(dynamic)>> attributeGetters = {
    WickModelTile: {
      'name': (model) => (model as WickModelTile).name,
      'icon': (model) => (model as WickModelTile).icon,
      'content': (model) => (model as WickModelTile).content,
      'activeByDefault': (model) => (model as WickModelTile).activeByDefault
    },
    WickModelPaginatedResponse: {
      'instances': (model) => (model as WickModelPaginatedResponse).instances,
      'totalInstances': (model) => (model as WickModelPaginatedResponse).totalInstances
    },
    WickModelPreferences: {
      'userId': (model) => (model as WickModelPreferences).userId,
      'brightness': (model) => (model as WickModelPreferences).brightness,
      'dateFormat': (model) => (model as WickModelPreferences).dateFormat,
      'primaryColor': (model) => (model as WickModelPreferences).primaryColor
    },
    WickModelDashboardConfiguration: {
      'id': (model) => (model as WickModelDashboardConfiguration).id,
      'userId': (model) => (model as WickModelDashboardConfiguration).userId,
      'dashboard': (model) => (model as WickModelDashboardConfiguration).dashboard,
      'configuration': (model) => (model as WickModelDashboardConfiguration).configuration
    },
    WickModelUser: {
      'id': (model) => (model as WickModelUser).id,
      'email': (model) => (model as WickModelUser).email,
      'picture': (model) => (model as WickModelUser).picture,
      'firstName': (model) => (model as WickModelUser).firstName,
      'lastName': (model) => (model as WickModelUser).lastName,
      'birthday': (model) => (model as WickModelUser).birthday
    },
    WickModelTileOption: {
      'active': (model) => (model as WickModelTileOption).active,
      'name': (model) => (model as WickModelTileOption).name
    },
    WickModelFormInputText: {
      'validations': (model) => (model as WickModelFormInputText).validations,
      'keyboardType': (model) => (model as WickModelFormInputText).keyboardType,
      'isSecret': (model) => (model as WickModelFormInputText).isSecret,
      'multipleLines': (model) => (model as WickModelFormInputText).multipleLines,
      'defaultValue': (model) => (model as WickModelFormInputText).defaultValue,
      'name': (model) => (model as WickModelFormInputText).name,
      'autoFill': (model) => (model as WickModelFormInputText).autoFill,
      'helpText': (model) => (model as WickModelFormInputText).helpText
    },
    WickModelFormInputImage: {
      'shape': (model) => (model as WickModelFormInputImage).shape,
      'maxSize': (model) => (model as WickModelFormInputImage).maxSize,
      'defaultValue': (model) => (model as WickModelFormInputImage).defaultValue,
      'name': (model) => (model as WickModelFormInputImage).name,
      'autoFill': (model) => (model as WickModelFormInputImage).autoFill,
      'helpText': (model) => (model as WickModelFormInputImage).helpText
    },
    WickModelFormInputDropdownOption: {
      'value': (model) => (model as WickModelFormInputDropdownOption).value,
      'label': (model) => (model as WickModelFormInputDropdownOption).label,
      'icon': (model) => (model as WickModelFormInputDropdownOption).icon
    },
    WickModelFormInputCheckbox: {
      'displayName': (model) => (model as WickModelFormInputCheckbox).displayName,
      'defaultValue': (model) => (model as WickModelFormInputCheckbox).defaultValue,
      'name': (model) => (model as WickModelFormInputCheckbox).name,
      'autoFill': (model) => (model as WickModelFormInputCheckbox).autoFill,
      'helpText': (model) => (model as WickModelFormInputCheckbox).helpText
    },
    WickModelFormInputDropdown: {
      'options': (model) => (model as WickModelFormInputDropdown).options,
      'defaultValue': (model) => (model as WickModelFormInputDropdown).defaultValue,
      'name': (model) => (model as WickModelFormInputDropdown).name,
      'autoFill': (model) => (model as WickModelFormInputDropdown).autoFill,
      'helpText': (model) => (model as WickModelFormInputDropdown).helpText
    },
    WickModelFormInputField: {
      'fieldName': (model) => (model as WickModelFormInputField).fieldName,
      'defaultValue': (model) => (model as WickModelFormInputField).defaultValue,
      'name': (model) => (model as WickModelFormInputField).name,
      'autoFill': (model) => (model as WickModelFormInputField).autoFill,
      'helpText': (model) => (model as WickModelFormInputField).helpText
    },
    WickModelSendVerificationEmailResponse: {
      'sessionId': (model) => (model as WickModelSendVerificationEmailResponse).sessionId
    },
    WickModelWickProviderSession: {
      'token': (model) => (model as WickModelWickProviderSession).token
    },
    WickModelWickProviderNavigation: {
      'lastRoute': (model) => (model as WickModelWickProviderNavigation).lastRoute
    },
    WickModelModelInformation: {
      'className': (model) => (model as WickModelModelInformation).className,
      'importPath': (model) => (model as WickModelModelInformation).importPath,
      'attributes': (model) => (model as WickModelModelInformation).attributes
    },
    WickModelSession: {
      'id': (model) => (model as WickModelSession).id,
      'userId': (model) => (model as WickModelSession).userId,
      'code': (model) => (model as WickModelSession).code,
      'successfulAttempts': (model) => (model as WickModelSession).successfulAttempts,
      'failedAttempts': (model) => (model as WickModelSession).failedAttempts,
      'started': (model) => (model as WickModelSession).started,
      'expires': (model) => (model as WickModelSession).expires,
      'device': (model) => (model as WickModelSession).device,
      'location': (model) => (model as WickModelSession).location
    },
    WickModelNavigationOption: {
      'name': (model) => (model as WickModelNavigationOption).name,
      'route': (model) => (model as WickModelNavigationOption).route,
      'icon': (model) => (model as WickModelNavigationOption).icon,
      'destination': (model) => (model as WickModelNavigationOption).destination,
      'isMain': (model) => (model as WickModelNavigationOption).isMain
    },
    WickModelSignInResponse: {
      'sessionToken': (model) => (model as WickModelSignInResponse).sessionToken
    },
    WickPageInitial: {
      'homeRoute': (model) => (model as WickPageInitial).homeRoute,
      'isAuthenticated': (model) => (model as WickPageInitial).isAuthenticated
    },
    WickPageBase: {
      'title': (model) => (model as WickPageBase).title,
      'alignment': (model) => (model as WickPageBase).alignment,
      'content': (model) => (model as WickPageBase).content,
      'additionalActionButtons': (model) => (model as WickPageBase).additionalActionButtons,
      'displayMainNavigation': (model) => (model as WickPageBase).displayMainNavigation,
      'icon': (model) => (model as WickPageBase).icon,
      'drawer': (model) => (model as WickPageBase).drawer
    },
    WickPageDashboardBase: {
      'name': (model) => (model as WickPageDashboardBase).name,
      'tiles': (model) => (model as WickPageDashboardBase).tiles,
      'icon': (model) => (model as WickPageDashboardBase).icon,
      'drawer': (model) => (model as WickPageDashboardBase).drawer
    },
    WickPageLoading: {
      'action': (model) => (model as WickPageLoading).action
    },
    WickWidgetApplication: {
      'name': (model) => (model as WickWidgetApplication).name,
      'navigationOptions': (model) => (model as WickWidgetApplication).navigationOptions,
      'homeRoute': (model) => (model as WickWidgetApplication).homeRoute,
      'defaultPrimaryColor': (model) => (model as WickWidgetApplication).defaultPrimaryColor
    },
    WickWidgetFormBase: {
      'name': (model) => (model as WickWidgetFormBase).name,
      'inputs': (model) => (model as WickWidgetFormBase).inputs,
      'submitButtonText': (model) => (model as WickWidgetFormBase).submitButtonText,
      'autoSubmit': (model) => (model as WickWidgetFormBase).autoSubmit,
      'autoFocus': (model) => (model as WickWidgetFormBase).autoFocus,
      'debounce': (model) => (model as WickWidgetFormBase).debounce,
      'onSubmit': (model) => (model as WickWidgetFormBase).onSubmit
    },
    WickWidgetFormStack: {
      'name': (model) => (model as WickWidgetFormStack).name,
      'inputs': (model) => (model as WickWidgetFormStack).inputs,
      'controller': (model) => (model as WickWidgetFormStack).controller,
      'primaryKey': (model) => (model as WickWidgetFormStack).primaryKey,
      'submitButtonText': (model) => (model as WickWidgetFormStack).submitButtonText,
      'autoSubmit': (model) => (model as WickWidgetFormStack).autoSubmit,
      'autoFocus': (model) => (model as WickWidgetFormStack).autoFocus,
      'debounce': (model) => (model as WickWidgetFormStack).debounce
    },
    WickWidgetFormInputText: {
      'input': (model) => (model as WickWidgetFormInputText).input,
      'onChanged': (model) => (model as WickWidgetFormInputText).onChanged,
      'onEnterPressed': (model) => (model as WickWidgetFormInputText).onEnterPressed,
      'focusNode': (model) => (model as WickWidgetFormInputText).focusNode
    },
    WickWidgetFormInputImage: {
      'input': (model) => (model as WickWidgetFormInputImage).input,
      'onChanged': (model) => (model as WickWidgetFormInputImage).onChanged
    },
    WickWidgetFormInputCheckbox: {
      'input': (model) => (model as WickWidgetFormInputCheckbox).input,
      'onChanged': (model) => (model as WickWidgetFormInputCheckbox).onChanged
    },
    WickWidgetFormInputDropdown: {
      'input': (model) => (model as WickWidgetFormInputDropdown).input,
      'onChanged': (model) => (model as WickWidgetFormInputDropdown).onChanged
    },
    WickWidgetCard: {
      'icon': (model) => (model as WickWidgetCard).icon,
      'title': (model) => (model as WickWidgetCard).title,
      'content': (model) => (model as WickWidgetCard).content,
      'isWide': (model) => (model as WickWidgetCard).isWide
    },
    WickWidgetButton: {
      'onPressed': (model) => (model as WickWidgetButton).onPressed,
      'message': (model) => (model as WickWidgetButton).message,
      'icon': (model) => (model as WickWidgetButton).icon,
      'type': (model) => (model as WickWidgetButton).type,
      'theme': (model) => (model as WickWidgetButton).theme,
      'isWide': (model) => (model as WickWidgetButton).isWide
    },
    WickWidgetDialog: {
      'icon': (model) => (model as WickWidgetDialog).icon,
      'title': (model) => (model as WickWidgetDialog).title,
      'content': (model) => (model as WickWidgetDialog).content,
      'displayActions': (model) => (model as WickWidgetDialog).displayActions,
      'okayMessage': (model) => (model as WickWidgetDialog).okayMessage,
      'displayCancel': (model) => (model as WickWidgetDialog).displayCancel
    },
    WickWidgetTable: {
      'data': (model) => (model as WickWidgetTable).data,
      'displayHeader': (model) => (model as WickWidgetTable).displayHeader,
      'canReorderRows': (model) => (model as WickWidgetTable).canReorderRows,
      'editableColumnKeys': (model) => (model as WickWidgetTable).editableColumnKeys
    },
    WickWidgetLoadingIndicator: {
      'action': (model) => (model as WickWidgetLoadingIndicator).action
    },
    WickWidgetIconButton: {
      'name': (model) => (model as WickWidgetIconButton).name,
      'icon': (model) => (model as WickWidgetIconButton).icon,
      'onPressed': (model) => (model as WickWidgetIconButton).onPressed
    },
  };
}
