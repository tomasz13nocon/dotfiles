/* exported SnowIndicator */
/*
 * Copyright 2020 Endless, Inc
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

const {Clutter, GLib, GObject, St} = imports.gi;
const Main = imports.ui.main;
const PopupMenu = imports.ui.popupMenu;
const PanelMenu = imports.ui.panelMenu;
const Slider = imports.ui.slider;

const Gettext = imports.gettext.domain('snow-extension');
const _ = Gettext.gettext;

function random(min = 0, max = 100, toInt = true) {
    let rnd = Math.random();
    rnd = rnd * (max - min) + min;
    if (toInt)
        rnd = Math.floor(rnd);
    return rnd;
}

var Flake = GObject.registerClass({
    Signals: {
        melt: {},
    },
}, class Flake extends St.Label {
    _init(flakes = ["❄", "❅", "❆"]) {
        const _whichFlake = random(0, flakes.length);

        super._init({
            style_class: 'snowflake snowflake' + random(1, 4),
            text: flakes[_whichFlake],
        });
    }

    fall(duration, meltDuration) {
        const {width, height} = global.stage;
        const startx = random(0, width);
        const starty = random(-height, 0);
        this.set_position(startx, starty);
        this.opacity = 255;

        Main.layoutManager.addChrome(this);

        this.ease({
            y: height - this.height,
            x: random(startx - 50, startx + 50),
            rotation_angle_z: random(-180, 180),
            duration: random(4, duration, false) * 1000,
            mode: Clutter.AnimationMode.EASE_OUT_QUAD,
            onComplete: () => { this._melt(meltDuration) },
        });
    }

    _melt(meltDuration) {
        this.emit('melt');

        this.ease({
            opacity: 0,
            duration: meltDuration * 1000,
            mode: Clutter.AnimationMode.EASE_OUT_QUAD,
            onComplete: () => {
                this.destroy();
            },
        });
    }
});

var SnowIndicator = GObject.registerClass(
class SnowIndicator extends PanelMenu.Button {
    _init() {
        super._init(0.5, _("Snow"));

        this._hbox = new St.BoxLayout({ style_class: 'panel-status-menu-box' });
        this._label = new St.Label({text: "❄️", y_align: Clutter.ActorAlign.CENTER});
        this._hbox.add_child(this._label);
        this._hbox.add_child(PopupMenu.arrowIcon(St.Side.BOTTOM));

        this.add_child(this._hbox);

        this._snowSwitch = new PopupMenu.PopupSwitchMenuItem(_('Let it snow!'), false);
        this._snowSwitch.connect('toggled', () => { this._snow() });
        this.menu.addMenuItem(this._snowSwitch);
        this.connect('destroy', () => {
            this._clearUp();
        });

        this._snowing = false;
        this._screenFlakes = 0;
        this._max = 20;
        this._myFlakes = ["❄", "❅", "❆"];
        this._duration = 12;
        this._meltDuration = 1;
        this._initialFlakes = 5;
    }

    _hideSnow() {
        this._screenFlakes -= 1;

        if (this._snowing) {
            if (this._screenFlakes <= this._max) {
                this._showMeSnow();
            }

            // If there's too few snow flakes we add more
            if (this._screenFlakes < this._max) {
                this._showMeSnow();
            }
        }
    }

    _showMeSnow(flakes = 1) {
        for(var i=0; i<flakes; i++) {
            const flake = new Flake(this._myFlakes);
            flake.fall(this._duration, this._meltDuration);
            flake.connect('melt', () => { this._hideSnow() });
            this._screenFlakes += 1;
        }
    }

    _snow() {
        if (this._snowing) {
            this._clearUp();
        } else {
            this._snowing = true;
            this._screenFlakes = 0;
            this._showMeSnow(this._initialFlakes);
        }
    }

    _clearUp() {
        this._snowing = false;
    }
});
