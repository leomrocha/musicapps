/****************************************************************************
** Meta object code from reading C++ file 'preferences.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "preferences.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'preferences.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Preferences[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      19,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      19,   13,   12,   12, 0x0a,
      38,   13,   12,   12, 0x0a,
      59,   13,   12,   12, 0x0a,
      79,   13,   12,   12, 0x0a,
     101,   13,   12,   12, 0x0a,
     124,   13,   12,   12, 0x0a,
     145,   13,   12,   12, 0x0a,
     166,   13,   12,   12, 0x0a,
     189,   13,   12,   12, 0x0a,
     218,   13,   12,   12, 0x0a,
     243,   13,   12,   12, 0x0a,
     265,   13,   12,   12, 0x0a,
     287,   13,   12,   12, 0x0a,
     306,   12,   12,   12, 0x0a,
     331,   12,   12,   12, 0x0a,
     349,   12,   12,   12, 0x0a,
     370,   12,   12,   12, 0x0a,
     394,   12,   12,   12, 0x0a,
     416,   12,   12,   12, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_Preferences[] = {
    "Preferences\0\0value\0setNumOctaves(int)\0"
    "setDrumsChannel(int)\0setNetworkPort(int)\0"
    "setGrabKeyboard(bool)\0setStyledWidgets(bool)\0"
    "setAlwaysOnTop(bool)\0setRawKeyboard(bool)\0"
    "setVelocityColor(bool)\0"
    "setEnforceChannelState(bool)\0"
    "setEnabledKeyboard(bool)\0setEnabledMouse(bool)\0"
    "setEnabledTouch(bool)\0setDriver(QString)\0"
    "slotOpenInstrumentFile()\0slotSelectColor()\0"
    "slotOpenKeymapFile()\0slotOpenRawKeymapFile()\0"
    "slotRestoreDefaults()\0accept()\0"
};

void Preferences::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Preferences *_t = static_cast<Preferences *>(_o);
        switch (_id) {
        case 0: _t->setNumOctaves((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->setDrumsChannel((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->setNetworkPort((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: _t->setGrabKeyboard((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 4: _t->setStyledWidgets((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 5: _t->setAlwaysOnTop((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 6: _t->setRawKeyboard((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 7: _t->setVelocityColor((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 8: _t->setEnforceChannelState((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 9: _t->setEnabledKeyboard((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 10: _t->setEnabledMouse((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 11: _t->setEnabledTouch((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 12: _t->setDriver((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 13: _t->slotOpenInstrumentFile(); break;
        case 14: _t->slotSelectColor(); break;
        case 15: _t->slotOpenKeymapFile(); break;
        case 16: _t->slotOpenRawKeymapFile(); break;
        case 17: _t->slotRestoreDefaults(); break;
        case 18: _t->accept(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Preferences::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Preferences::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_Preferences,
      qt_meta_data_Preferences, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Preferences::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Preferences::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Preferences::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Preferences))
        return static_cast<void*>(const_cast< Preferences*>(this));
    return QDialog::qt_metacast(_clname);
}

int Preferences::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 19)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 19;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
