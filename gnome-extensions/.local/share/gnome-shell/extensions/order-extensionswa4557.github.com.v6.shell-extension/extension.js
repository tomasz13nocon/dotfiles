const Main = imports.ui.main;
const Panel = imports.ui.panel;
const GLib = imports.gi.GLib;
const ByteArray = imports.byteArray

const homeDir = GLib.get_home_dir();
const orderfilePath = ['/usr/share/indicators/application/', homeDir + '/.local/share/indicators/application/'];
const orderfileFn = 'ordering-override.keyfile';

const _origAddToPanelBox = Panel.Panel.prototype._addToPanelBox;


let orderFile = false;
let orderArr = null;

let orderArrSys = (readFile(orderfilePath[0]+orderfileFn));
let orderArrUser = (readFile(orderfilePath[1]+orderfileFn));

if (orderArrUser !== null) {
  orderArr = orderArrUser;
  orderFile = true;
} else if (orderArrUser == null && orderArrSys !== null) {
  orderArr = orderArrSys;
  orderFile = true;
}

function enable() {
  Panel.Panel.prototype._redrawIndicators = _redrawIndicators;
  Panel.Panel.prototype._addToPanelBox = _addToPanelBox;
  const posArrs = getPosArr(Main.panel.statusArea);
  if (orderFile) {
    for (const posArr of posArrs) {
      Main.panel._redrawIndicators(posArr);
    }
  }
}

function disable() {
  Panel.Panel.prototype._redrawIndicators = undefined;
  Panel.Panel.prototype._addToPanelBox = _origAddToPanelBox;
}

function _redrawIndicators(posArr) {
  for (let i = 0; i < posArr.length; i++) {
    const role = posArr[i].role;
    const indicator = posArr[i].indicator;
    const position = i;
    const box = this.statusArea[role].get_parent().get_parent();
    const container = indicator.container;
    container.show();
    const parent = container.get_parent();
    if (parent) {
      parent.remove_actor(container);
    }
    box.insert_child_at_index(container, position);
    if (indicator.menu) {
      this.menuManager.addMenu(indicator.menu);
    }
    this.statusArea[role] = indicator;
    const destroyId = indicator.connect('destroy', (emitter) => {
      delete this.statusArea[role];
      emitter.disconnect(destroyId);
    });
    indicator.connect('menu-set', this._onMenuSet.bind(this));
    this._onMenuSet(indicator);
  }
}

function _addToPanelBox(role, indicator, position, box) {
  orderArrSys = (readFile(orderfilePath[0]+orderfileFn));
  orderArrUser = (readFile(orderfilePath[1]+orderfileFn));

  if (orderArrUser !== null) {
    orderArr = orderArrUser;
    orderFile = true;
  } else if (orderArrUser == null && orderArrSys !== null) {
    orderArr = orderArrSys;
    orderFile = true;
  }
  const container = indicator.container;
  container.show();
  const parent = container.get_parent();
  if (parent) {
    parent.remove_actor(container);
  }
  box.insert_child_at_index(container, position);
  if (indicator.menu) {
    this.menuManager.addMenu(indicator.menu);
  }
  this.statusArea[role] = indicator;


  const destroyId = indicator.connect('destroy', (emitter) => {
    delete this.statusArea[role];
    emitter.disconnect(destroyId);
  });
  indicator.connect('menu-set', this._onMenuSet.bind(this));
  this._onMenuSet(indicator);
  const posArrs = getPosArr(this.statusArea);
  if (orderFile) {
    for (const posArr of posArrs) {
      this._redrawIndicators(posArr);
    }
  }
}

function readFile(path) {
  const test = GLib.file_test(path, GLib.FileTest.IS_REGULAR);
  if (!test) {
    return null;
  }
  const [err, data] = GLib.file_get_contents(path);
  const sData = ByteArray.toString(data).split('\n');
  const retArr = [];
  for (const val of sData) {
    if (!val.includes('=')) {
      continue;
    }
    const tempVal = val.split('=');
    retArr.push(tempVal);
  }
  return retArr;
}

function getPosArr(statusArea) {
  const posArrLeft = [];
  const posArrMiddle = [];
  const posArrRight = [];

  for (const k in statusArea) {
    const toTest = getTestName(statusArea[k], k);
    log('Order application icons: ' + toTest);
    let setPosition = getFilePosition(toTest, orderArr);
    if (setPosition == null) {
      setPosition = 0;
    }
    const posObj = {};
    posObj.role = k;
    posObj.indicator = statusArea[k];
    posObj.position = setPosition;
    posObj.box = statusArea[k].get_parent().get_parent();
    if (posObj.box.name == 'panelLeft') {
      posArrLeft.push(posObj);
    } else if (posObj.box.name == 'panelCenter') {
      posArrMiddle.push(posObj);
    } else if (posObj.box.name == 'panelRight') {
      posArrRight.push(posObj);
    }
  }
  posArrLeft.sort(sortFun);
  posArrMiddle.sort(sortFun);
  posArrRight.sort(sortFun);

  return [posArrLeft, posArrMiddle, posArrRight];
}


function getTestName(indicator, name) {
  let toTest = name;
  if (indicator._indicator) {
    if (name.startsWith('appindicator-')) {
      if (name.includes('dropbox')) {
        // dropbox needs special treatment because it appends the pid to the id.
        // So we need to use the less appropriate title
        toTest = indicator._indicator.title;
      } else {
        toTest = indicator._indicator.id;
      }
    }
  }
  return toTest;
}

function getFilePosition(name, arr) {
  if (arr == null) {
    return null;
  }
  for (const val of arr) {
    if (name == val[0]) {
      return parseInt(val[1]);
    }
  }
  return null;
}

function sortFun(a, b) {
  if (a.position > b.position) {
    return 1;
  } else if (b.position > a.position) {
    return -1;
  } else if (b.position == a.position) {
    if (a.role > b.role) {
      return 1;
    } else if (b.role > a.role) {
      return -1;
    } else {
      return 1;
    }
  }
}


