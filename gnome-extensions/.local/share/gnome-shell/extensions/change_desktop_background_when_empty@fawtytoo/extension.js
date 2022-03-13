const GLib = imports.gi.GLib;
const Gio = imports.gi.Gio;
const Main = imports.ui.main;
const Shell = imports.gi.Shell;
const Config = imports.misc.config;
const Version = parseInt(Config.PACKAGE_VERSION.split('.')[0]);
const ShowAppsButton = Version == 3 ? Main.overview.viewSelector._showAppsButton : Main.overview.dash.showAppsButton;
const Meta = imports.gi.Meta;

const acceptedWindowTypes = [ Meta.WindowType.NORMAL, Meta.WindowType.DIALOG, Meta.WindowType.MODAL_DIALOG ];

let _signal = [];
let _settings;

let _manager, _workspace, _tracker;

function windowAccepted(window)
{
    if (window.is_hidden() || acceptedWindowTypes.indexOf(window.get_window_type()) == -1)
        return false;

    return true;
}

function nextBackground()
{
    if (_workspace.list_windows().filter(window => windowAccepted(window)).length > 0)
        return;

    // sometimes, you just don't want it to change
    if (Main.overview.visible)
        return;

    let filename = _settings.get_string("picture-uri").replace(/^file:\/\/\//, '/');
    let path = filename.substr(0, filename.lastIndexOf('/') + 1);
    if (GLib.file_test(filename, GLib.FileTest.IS_DIR))
        path = filename;

    let dir = Gio.File.new_for_path(path);
    const children = dir.enumerate_children('standard::name,standard::type', Gio.FileQueryInfoFlags.NONE, null);

    let info, files = [];
    while ((info = children.next_file(null)))
        if (info.get_file_type() == Gio.FileType.REGULAR && !info.get_is_hidden())
            files.push(dir.get_child(info.get_name()).get_parse_name());

    if (files.length < 2) // not much point continuing
        return;

    files.sort((a, b) => a.localeCompare(b));

    let index = files.indexOf(filename);
    if (index == -1)
    {
        if ((index = files.findIndex(element => element.localeCompare(filename) == 1)) == -1)
            index = 0;
    }
    else
        index = (index + 1 >= files.length) ? 0 : index + 1;

    _settings.set_string("picture-uri", "file://" + files[index]);
}

function windowRemoved(workspace, window)
{
    if (workspace != _workspace)
        return;

    if (!windowAccepted(window))
        return;

    nextBackground();
}

function disconnectWindowSignals()
{
    _workspace.disconnect(_signal['window-removed']);
}

function getWorkspace()
{
    _workspace = _manager.get_active_workspace();

    _signal['window-removed'] = _workspace.connect('window-removed', (workspace, window) => windowRemoved(workspace, window));
}

function checkWorkspace()
{
    disconnectWindowSignals();

    getWorkspace();

    nextBackground();
}

function init()
{
    _manager = global.workspace_manager;
}

function enable()
{
    _tracker = Shell.WindowTracker.get_default();

    _settings = new Gio.Settings({schema_id: 'org.gnome.desktop.background'});

    getWorkspace();

    _signal['workspace-switched'] = _manager.connect('workspace-switched', checkWorkspace);

    nextBackground();
}

function disable()
{
    disconnectWindowSignals();

    _manager.disconnect(_signal['workspace-switched']);

    _settings = null;
}
