//////////////////////////////////////////////////////////////////////////////////////////
// ,-.  ,--.  ,-.  ,  , ,---.  ,-.  ;-.     ,-. .  . ,-.  ,--.       Copyright (c) 2021 //
// |  \ |    (   ` | /    |   /   \ |  )   /    |  | |  ) |            Simon Schneegans //
// |  | |-    `-.  |<     |   |   | |-'    |    |  | |-<  |-   Released under the GPLv3 //
// |  / |    .   ) | \    |   \   / |      \    |  | |  ) |       or later. See LICENSE //
// `-'  `--'  `-'  '  `   '    `-'  '       `-' `--` `-'  `--'        file for details. //
//////////////////////////////////////////////////////////////////////////////////////////

'use strict';

const {Gio, Gtk, Gdk} = imports.gi;

const ExtensionUtils = imports.misc.extensionUtils;
const Me             = imports.misc.extensionUtils.getCurrentExtension();
const utils          = Me.imports.utils;

//////////////////////////////////////////////////////////////////////////////////////////
// For now, the preferences dialog of this extension is very simple. In the future, if  //
// we might consider to improve its layout...                                           //
//////////////////////////////////////////////////////////////////////////////////////////

var PreferencesDialog = class PreferencesDialog {
  // ------------------------------------------------------------ constructor / destructor

  constructor() {
    // Load all of our resources.
    this._resources = Gio.Resource.load(Me.path + '/resources/desktop-cube.gresource');
    Gio.resources_register(this._resources);

    // Load the user interface file.
    this._builder = new Gtk.Builder();
    this._builder.add_from_resource(`/ui/settings.ui`);

    // This is our top-level widget which we will return later.
    this._widget = this._builder.get_object('settings-widget');

    // Store a reference to the settings object.
    this._settings = ExtensionUtils.getSettings();

    // Bind all properties.
    this._bindAdjustment('workpace-separation');
    this._bindAdjustment('depth-separation');
    this._bindAdjustment('horizontal-stretch');
    this._bindSwitch('last-first-gap');
    this._bindAdjustment('active-workpace-opacity');
    this._bindAdjustment('inactive-workpace-opacity');
    this._bindAdjustment('overview-transition-time');
    this._bindAdjustment('appgrid-transition-time');
    this._bindAdjustment('workspace-transition-time');
    this._bindSwitch('unfold-to-desktop');

    // Add a menu to the title bar of the preferences dialog.
    this._widget.connect('realize', (widget) => {
      const window = widget.get_root();

      // Show the version number in the title bar.
      window.set_title(`Desktop Cube ${Me.metadata.version}`);

      // Add the menu.
      const menu = this._builder.get_object('menu-button');
      window.get_titlebar().pack_end(menu);

      // Populate the actions.
      const group = Gio.SimpleActionGroup.new();

      const addAction = (name, uri) => {
        const action = Gio.SimpleAction.new(name, null);
        action.connect('activate', () => Gtk.show_uri(null, uri, Gdk.CURRENT_TIME));
        group.add_action(action);
      };

      addAction('homepage', 'https://github.com/Schneegans/Desktop-Cube');
      addAction('bugs', 'https://github.com/Schneegans/Desktop-Cube/issues');
      addAction(
          'donate-paypal',
          'https://www.paypal.com/donate/?hosted_button_id=3F7UFL8KLVPXE');
      addAction('donate-github', 'https://github.com/sponsors/Schneegans');

      window.insert_action_group('prefs', group);
    });


    // As we do not have something like a destructor, we just listen for the destroy
    // signal of our main widget.
    this._widget.connect('destroy', () => {
      // Unregister our resources.
      Gio.resources_unregister(this._resources);
    });
  }

  // -------------------------------------------------------------------- public interface

  // Returns the widget used for the settings of this extension.
  getWidget() {
    return this._widget;
  }

  // ----------------------------------------------------------------------- private stuff

  // Connects a Gtk.Adjustment (or anything else which has a 'value' property) to a
  // settings key. It also binds the corresponding reset button.
  _bindAdjustment(settingsKey) {
    this._bind(settingsKey, 'value');
  }

  // Connects a Gtk.Switch (or anything else which has an 'active' property) to a settings
  // key. It also binds the corresponding reset button.
  _bindSwitch(settingsKey) {
    this._bind(settingsKey, 'active');
  }

  // Connects any widget's property to a settings key. The widget must have the same ID as
  // the settings key. It also binds the corresponding reset button.
  _bind(settingsKey, property) {
    this._settings.bind(
        settingsKey, this._builder.get_object(settingsKey), property,
        Gio.SettingsBindFlags.DEFAULT);

    const resetButton = this._builder.get_object('reset-' + settingsKey);
    resetButton.connect('clicked', () => {
      this._settings.reset(settingsKey);
    });
  }
}

// Nothing to do for now...
function init() {}

// This function is called when the preferences window is created to build and return a
// Gtk widget. We create a new instance of the PreferencesDialog class each time this
// method is called. This way we can actually open multiple settings windows and interact
// with all of them properly.
function buildPrefsWidget() {
  var dialog = new PreferencesDialog();
  return dialog.getWidget();
}
