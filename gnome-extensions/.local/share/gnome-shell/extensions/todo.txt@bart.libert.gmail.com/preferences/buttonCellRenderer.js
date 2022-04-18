const {Gtk, GObject} = imports.gi;

/* exported ButtonCellRenderer */
var ButtonCellRenderer = GObject.registerClass({
    GTypeName: 'ButtonCellRenderer'

}, class ButtonCellRenderer extends Gtk.CellRendererPixbuf {

    _init() {
        super._init();
        this.activateable = true;
        this.mode = Gtk.CellRendererMode.ACTIVATABLE;
    }

    vfunc_activate(event, widget, path) {
        this.emit('clicked', path);
    }
});

/* vi: set expandtab tabstop=4 shiftwidth=4: */
