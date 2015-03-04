/****************************************************************************
** Meta object code from reading C++ file 'knob.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "knob.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'knob.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Knob[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       2,   24, // properties
       1,   30, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      20,    6,    5,    5, 0x0a,
      50,   41,    5,    5, 0x0a,

 // properties: name, type, flags
      76,   72, 0x02095103,
      41,   89, 0x0009510b,

 // enums: name, flags, count, data
      89, 0x0,    3,   34,

 // enum data: key, value
      98, uint(Knob::QDialMode),
     108, uint(Knob::AngularMode),
     120, uint(Knob::LinearMode),

       0        // eod
};

static const char qt_meta_stringdata_Knob[] = {
    "Knob\0\0iDefaultValue\0setDefaultValue(int)\0"
    "dialMode\0setDialMode(DialMode)\0int\0"
    "defaultValue\0DialMode\0QDialMode\0"
    "AngularMode\0LinearMode\0"
};

void Knob::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Knob *_t = static_cast<Knob *>(_o);
        switch (_id) {
        case 0: _t->setDefaultValue((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->setDialMode((*reinterpret_cast< DialMode(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Knob::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Knob::staticMetaObject = {
    { &QDial::staticMetaObject, qt_meta_stringdata_Knob,
      qt_meta_data_Knob, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Knob::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Knob::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Knob::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Knob))
        return static_cast<void*>(const_cast< Knob*>(this));
    return QDial::qt_metacast(_clname);
}

int Knob::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDial::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = getDefaultValue(); break;
        case 1: *reinterpret_cast< DialMode*>(_v) = getDialMode(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setDefaultValue(*reinterpret_cast< int*>(_v)); break;
        case 1: setDialMode(*reinterpret_cast< DialMode*>(_v)); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
QT_END_MOC_NAMESPACE
