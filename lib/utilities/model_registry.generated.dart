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
import 'package:wick_apps/widgets/navigation_drawer.dart';
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
import 'package:wick_apps/enums/model_attributes/widget_navigation_drawer.generated.dart';
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
    WickWidgetNavigationDrawer: WickEnumModelAttributeWidgetNavigationDrawer,
    WickWidgetCard: WickEnumModelAttributeWidgetCard,
    WickWidgetButton: WickEnumModelAttributeWidgetButton,
    WickWidgetDialog: WickEnumModelAttributeWidgetDialog,
    WickWidgetTable: WickEnumModelAttributeWidgetTable,
    WickWidgetLoadingIndicator: WickEnumModelAttributeWidgetLoadingIndicator,
    WickWidgetIconButton: WickEnumModelAttributeWidgetIconButton,
  };

  static final Map<Type, Function(Map<String, dynamic>)> constructors = {
    WickModelTile: (attributes) => WickModelTile(
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      icon: WickUtilityTypeConverter.convert<IconData>(attributes['icon']),
      content: WickUtilityTypeConverter.convert<List<Widget>>(attributes['content']),
      activeByDefault: WickUtilityTypeConverter.convert<bool>(attributes['activeByDefault'])
    ),
    WickModelPaginatedResponse: (attributes) => WickModelPaginatedResponse(
      instances: WickUtilityTypeConverter.convert<List<dynamic>>(attributes['instances']),
      totalInstances: WickUtilityTypeConverter.convert<int>(attributes['totalInstances'])
    ),
    WickModelPreferences: (attributes) => WickModelPreferences(
      userId: WickUtilityTypeConverter.convert<int>(attributes['userId']),
      brightness: WickUtilityTypeConverter.convert<WickEnumBrightness>(attributes['brightness']),
      dateFormat: WickUtilityTypeConverter.convert<WickEnumDateFormat>(attributes['dateFormat']),
      primaryColor: WickUtilityTypeConverter.convert<WickEnumColor>(attributes['primaryColor'])
    ),
    WickModelDashboardConfiguration: (attributes) => WickModelDashboardConfiguration(
      id: WickUtilityTypeConverter.convert<int>(attributes['id']),
      userId: WickUtilityTypeConverter.convert<int>(attributes['userId']),
      dashboard: WickUtilityTypeConverter.convert<String>(attributes['dashboard']),
      configuration: WickUtilityTypeConverter.convert<String>(attributes['configuration'])
    ),
    WickModelUser: (attributes) => WickModelUser(
      id: WickUtilityTypeConverter.convert<int>(attributes['id']),
      email: WickUtilityTypeConverter.convert<String>(attributes['email']),
      picture: WickUtilityTypeConverter.convert<String?>(attributes['picture']),
      firstName: WickUtilityTypeConverter.convert<String?>(attributes['firstName']),
      lastName: WickUtilityTypeConverter.convert<String?>(attributes['lastName']),
      birthday: WickUtilityTypeConverter.convert<DateTime?>(attributes['birthday'])
    ),
    WickModelTileOption: (attributes) => WickModelTileOption(
      active: WickUtilityTypeConverter.convert<bool>(attributes['active']),
      name: WickUtilityTypeConverter.convert<String>(attributes['name'])
    ),
    WickModelFormInputText: (attributes) => WickModelFormInputText(
      validations: WickUtilityTypeConverter.convert<List<WickEnumTextValidation>>(attributes['validations']),
      keyboardType: WickUtilityTypeConverter.convert<WickEnumKeyboardType>(attributes['keyboardType']),
      isSecret: WickUtilityTypeConverter.convert<bool>(attributes['isSecret']),
      multipleLines: WickUtilityTypeConverter.convert<bool>(attributes['multipleLines']),
      defaultValue: WickUtilityTypeConverter.convert<String?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.convert<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.convert<String?>(attributes['helpText'])
    ),
    WickModelFormInputImage: (attributes) => WickModelFormInputImage(
      shape: WickUtilityTypeConverter.convert<WickEnumImageShape>(attributes['shape']),
      maxSize: WickUtilityTypeConverter.convert<WickEnumFileSize>(attributes['maxSize']),
      defaultValue: WickUtilityTypeConverter.convert<Uint8List?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.convert<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.convert<String?>(attributes['helpText'])
    ),
    WickModelFormInputDropdownOption: (attributes) => WickModelFormInputDropdownOption(
      value: WickUtilityTypeConverter.convert<String?>(attributes['value']),
      label: WickUtilityTypeConverter.convert<String>(attributes['label']),
      icon: WickUtilityTypeConverter.convert<IconData?>(attributes['icon'])
    ),
    WickModelFormInputCheckbox: (attributes) => WickModelFormInputCheckbox(
      displayName: WickUtilityTypeConverter.convert<bool>(attributes['displayName']),
      defaultValue: WickUtilityTypeConverter.convert<bool?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.convert<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.convert<String?>(attributes['helpText'])
    ),
    WickModelFormInputDropdown: (attributes) => WickModelFormInputDropdown(
      options: WickUtilityTypeConverter.convert<List<WickModelFormInputDropdownOption>>(attributes['options']),
      defaultValue: WickUtilityTypeConverter.convert<String?>(attributes['defaultValue']),
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      autoFill: WickUtilityTypeConverter.convert<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.convert<String?>(attributes['helpText'])
    ),
    WickModelFormInputField: (attributes) => WickModelFormInputField(
      fieldName: WickUtilityTypeConverter.convert<String>(attributes['fieldName']),
      defaultValue: WickUtilityTypeConverter.convert<dynamic>(attributes['defaultValue']),
      autoFill: WickUtilityTypeConverter.convert<bool>(attributes['autoFill']),
      helpText: WickUtilityTypeConverter.convert<String?>(attributes['helpText'])
    ),
    WickModelSendVerificationEmailResponse: (attributes) => WickModelSendVerificationEmailResponse(
      sessionId: WickUtilityTypeConverter.convert<int>(attributes['sessionId'])
    ),
    WickModelWickProviderSession: (attributes) => WickModelWickProviderSession(
      token: WickUtilityTypeConverter.convert<String>(attributes['token'])
    ),
    WickModelWickProviderNavigation: (attributes) => WickModelWickProviderNavigation(
      lastRoute: WickUtilityTypeConverter.convert<String>(attributes['lastRoute'])
    ),
    WickModelModelInformation: (attributes) => WickModelModelInformation(
      className: WickUtilityTypeConverter.convert<String>(attributes['className']),
      importPath: WickUtilityTypeConverter.convert<String>(attributes['importPath']),
      attributes: WickUtilityTypeConverter.convert<Map<String, String>>(attributes['attributes'])
    ),
    WickModelSession: (attributes) => WickModelSession(
      id: WickUtilityTypeConverter.convert<int>(attributes['id']),
      userId: WickUtilityTypeConverter.convert<int>(attributes['userId']),
      code: WickUtilityTypeConverter.convert<String>(attributes['code']),
      successfulAttempts: WickUtilityTypeConverter.convert<int>(attributes['successfulAttempts']),
      failedAttempts: WickUtilityTypeConverter.convert<int>(attributes['failedAttempts']),
      started: WickUtilityTypeConverter.convert<DateTime>(attributes['started']),
      expires: WickUtilityTypeConverter.convert<DateTime>(attributes['expires']),
      device: WickUtilityTypeConverter.convert<String>(attributes['device']),
      location: WickUtilityTypeConverter.convert<String>(attributes['location'])
    ),
    WickModelNavigationOption: (attributes) => WickModelNavigationOption(
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      route: WickUtilityTypeConverter.convert<String>(attributes['route']),
      icon: WickUtilityTypeConverter.convert<IconData>(attributes['icon']),
      destination: WickUtilityTypeConverter.convert<Widget>(attributes['destination']),
      isMain: WickUtilityTypeConverter.convert<bool>(attributes['isMain'])
    ),
    WickModelSignInResponse: (attributes) => WickModelSignInResponse(
      sessionToken: WickUtilityTypeConverter.convert<String>(attributes['sessionToken'])
    ),
    WickPageInitial: (attributes) => WickPageInitial(
      homeRoute: WickUtilityTypeConverter.convert<String>(attributes['homeRoute']),
      isAuthenticated: WickUtilityTypeConverter.convert<bool>(attributes['isAuthenticated'])
    ),
    WickPageBase: (attributes) => WickPageBase(
      title: WickUtilityTypeConverter.convert<String>(attributes['title']),
      alignment: WickUtilityTypeConverter.convert<Alignment>(attributes['alignment']),
      content: WickUtilityTypeConverter.convert<List<Widget>>(attributes['content']),
      additionalActionButtons: WickUtilityTypeConverter.convert<List<Widget>>(attributes['additionalActionButtons']),
      displayMainNavigation: WickUtilityTypeConverter.convert<bool>(attributes['displayMainNavigation']),
      icon: WickUtilityTypeConverter.convert<IconData?>(attributes['icon']),
      availableDrawerRoutes: WickUtilityTypeConverter.convert<List<String>>(attributes['availableDrawerRoutes'])
    ),
    WickPageDashboardBase: (attributes) => WickPageDashboardBase(
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      tiles: WickUtilityTypeConverter.convert<List<WickModelTile>>(attributes['tiles']),
      icon: WickUtilityTypeConverter.convert<IconData?>(attributes['icon']),
      availableDrawerRoutes: WickUtilityTypeConverter.convert<List<String>>(attributes['availableDrawerRoutes'])
    ),
    WickPageLoading: (attributes) => WickPageLoading(
      action: WickUtilityTypeConverter.convert<String?>(attributes['action'])
    ),
    WickWidgetApplication: (attributes) => WickWidgetApplication(
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      navigationOptions: WickUtilityTypeConverter.convert<List<WickModelNavigationOption>>(attributes['navigationOptions']),
      homeRoute: WickUtilityTypeConverter.convert<String>(attributes['homeRoute']),
      defaultPrimaryColor: WickUtilityTypeConverter.convert<WickEnumColor>(attributes['defaultPrimaryColor'])
    ),
    WickWidgetFormBase: (attributes) => WickWidgetFormBase(
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      inputs: WickUtilityTypeConverter.convert<List<WickModelFormInputBase>>(attributes['inputs']),
      submitButtonText: WickUtilityTypeConverter.convert<String>(attributes['submitButtonText']),
      autoSubmit: WickUtilityTypeConverter.convert<bool>(attributes['autoSubmit']),
      autoFocus: WickUtilityTypeConverter.convert<bool>(attributes['autoFocus']),
      debounce: WickUtilityTypeConverter.convert<Duration>(attributes['debounce']),
      onSubmit: WickUtilityTypeConverter.convert<Function(Map<String, dynamic>)>(attributes['onSubmit'])
    ),
    WickWidgetFormStack: (attributes) => WickWidgetFormStack(
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      inputs: WickUtilityTypeConverter.convert<List<WickModelFormInputField>>(attributes['inputs']),
      controller: WickUtilityTypeConverter.convert<WickControllerBase<dynamic>>(attributes['controller']),
      primaryKey: WickUtilityTypeConverter.convert<int?>(attributes['primaryKey']),
      submitButtonText: WickUtilityTypeConverter.convert<String>(attributes['submitButtonText']),
      autoSubmit: WickUtilityTypeConverter.convert<bool>(attributes['autoSubmit']),
      autoFocus: WickUtilityTypeConverter.convert<bool>(attributes['autoFocus']),
      debounce: WickUtilityTypeConverter.convert<Duration>(attributes['debounce'])
    ),
    WickWidgetFormInputText: (attributes) => WickWidgetFormInputText(
      input: WickUtilityTypeConverter.convert<WickModelFormInputText>(attributes['input']),
      onChanged: WickUtilityTypeConverter.convert<Function(String?)>(attributes['onChanged']),
      onEnterPressed: WickUtilityTypeConverter.convert<Function()>(attributes['onEnterPressed']),
      focusNode: WickUtilityTypeConverter.convert<FocusNode?>(attributes['focusNode'])
    ),
    WickWidgetFormInputImage: (attributes) => WickWidgetFormInputImage(
      input: WickUtilityTypeConverter.convert<WickModelFormInputImage>(attributes['input']),
      onChanged: WickUtilityTypeConverter.convert<Function(String?)>(attributes['onChanged'])
    ),
    WickWidgetFormInputCheckbox: (attributes) => WickWidgetFormInputCheckbox(
      input: WickUtilityTypeConverter.convert<WickModelFormInputCheckbox>(attributes['input']),
      onChanged: WickUtilityTypeConverter.convert<Function(String?)>(attributes['onChanged'])
    ),
    WickWidgetFormInputDropdown: (attributes) => WickWidgetFormInputDropdown(
      input: WickUtilityTypeConverter.convert<WickModelFormInputDropdown>(attributes['input']),
      onChanged: WickUtilityTypeConverter.convert<Function(String?)>(attributes['onChanged'])
    ),
    WickWidgetNavigationDrawer: (attributes) => WickWidgetNavigationDrawer(
      availableRoutes: WickUtilityTypeConverter.convert<List<String>>(attributes['availableRoutes'])
    ),
    WickWidgetCard: (attributes) => WickWidgetCard(
      icon: WickUtilityTypeConverter.convert<IconData>(attributes['icon']),
      title: WickUtilityTypeConverter.convert<String>(attributes['title']),
      content: WickUtilityTypeConverter.convert<List<Widget>>(attributes['content']),
      isWide: WickUtilityTypeConverter.convert<bool>(attributes['isWide'])
    ),
    WickWidgetButton: (attributes) => WickWidgetButton(
      onPressed: WickUtilityTypeConverter.convert<Function()>(attributes['onPressed']),
      message: WickUtilityTypeConverter.convert<String>(attributes['message']),
      icon: WickUtilityTypeConverter.convert<IconData?>(attributes['icon']),
      type: WickUtilityTypeConverter.convert<WickEnumButtonType>(attributes['type']),
      theme: WickUtilityTypeConverter.convert<WickEnumButtonTheme>(attributes['theme']),
      isWide: WickUtilityTypeConverter.convert<bool>(attributes['isWide'])
    ),
    WickWidgetDialog: (attributes) => WickWidgetDialog(
      icon: WickUtilityTypeConverter.convert<IconData>(attributes['icon']),
      title: WickUtilityTypeConverter.convert<String>(attributes['title']),
      content: WickUtilityTypeConverter.convert<List<Widget>>(attributes['content']),
      displayActions: WickUtilityTypeConverter.convert<bool>(attributes['displayActions']),
      okayMessage: WickUtilityTypeConverter.convert<String>(attributes['okayMessage']),
      displayCancel: WickUtilityTypeConverter.convert<bool>(attributes['displayCancel'])
    ),
    WickWidgetTable: (attributes) => WickWidgetTable(
      data: WickUtilityTypeConverter.convert<List<dynamic>>(attributes['data']),
      displayHeader: WickUtilityTypeConverter.convert<bool>(attributes['displayHeader']),
      canReorderRows: WickUtilityTypeConverter.convert<bool>(attributes['canReorderRows']),
      editableColumnKeys: WickUtilityTypeConverter.convert<List<String>>(attributes['editableColumnKeys'])
    ),
    WickWidgetLoadingIndicator: (attributes) => WickWidgetLoadingIndicator(
      action: WickUtilityTypeConverter.convert<String?>(attributes['action'])
    ),
    WickWidgetIconButton: (attributes) => WickWidgetIconButton(
      name: WickUtilityTypeConverter.convert<String>(attributes['name']),
      icon: WickUtilityTypeConverter.convert<IconData>(attributes['icon']),
      onPressed: WickUtilityTypeConverter.convert<void Function()>(attributes['onPressed'])
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
      'availableDrawerRoutes': (model) => (model as WickPageBase).availableDrawerRoutes
    },
    WickPageDashboardBase: {
      'name': (model) => (model as WickPageDashboardBase).name,
      'tiles': (model) => (model as WickPageDashboardBase).tiles,
      'icon': (model) => (model as WickPageDashboardBase).icon,
      'availableDrawerRoutes': (model) => (model as WickPageDashboardBase).availableDrawerRoutes
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
    WickWidgetNavigationDrawer: {
      'availableRoutes': (model) => (model as WickWidgetNavigationDrawer).availableRoutes
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
