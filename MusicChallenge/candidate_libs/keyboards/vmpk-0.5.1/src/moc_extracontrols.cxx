/****************************************************************************
** Meta object code from reading C++ file 'extracontrols.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "extracontrols.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'extracontrols.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DialogExtraControls[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      21,   20,   20,   20, 0x0a,
      34,   20,   20,   20, 0x0a,
      50,   20,   20,   20, 0x0a,
      62,   20,   20,   20, 0x0a,
      93,   76,   20,   20, 0x0a,
     150,  141,   20,   20, 0x0a,
     179,  171,   20,   20, 0x0a,
     204,  199,   20,   20, 0x0a,
     229,  221,   20,   20, 0x0a,
     257,  249,   20,   20, 0x0a,
     285,  277,   20,   20, 0x0a,
     314,  305,   20,   20, 0x0a,
     344,  335,   20,   20, 0x0a,
     370,  364,   20,   20, 0x0a,
     394,  389,   20,   20, 0x0a,
     411,   20,   20,   20, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_DialogExtraControls[] = {
    "DialogExtraControls\0\0addControl()\0"
    "removeControl()\0controlUp()\0controlDown()\0"
    "current,previous\0"
    "itemSelected(QListWidgetItem*,QListWidgetItem*)\0"
    "newlabel\0labelEdited(QString)\0control\0"
    "controlChanged(int)\0type\0typeChanged(int)\0"
    "minimum\0minimumChanged(int)\0maximum\0"
    "maximumChanged(int)\0onvalue\0"
    "onvalueChanged(int)\0offvalue\0"
    "offvalueChanged(int)\0defvalue\0"
    "defaultChanged(int)\0defOn\0defOnChanged(bool)\0"
    "size\0sizeChanged(int)\0openFile()\0"
};

void DialogExtraControls::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        DialogExtraControls *_t = static_cast<DialogExtraControls *>(_o);
        switch (_id) {
        case 0: _t->addControl(); break;
        case 1: _t->removeControl(); break;
        case 2: _t->controlUp(); break;
        case 3: _t->controlDown(); break;
        case 4: _t->itemSelected((*reinterpret_cast< QListWidgetItem*(*)>(_a[1])),(*reinterpret_cast< QListWidgetItem*(*)>(_a[2]))); break;
        case 5: _t->labelEdited((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->controlChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: _t->typeChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: _t->minimumChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: _t->maximumChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 10: _t->onvalueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 11: _t->offvalueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 12: _t->defaultChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 13: _t->defOnChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 14: _t->sizeChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 15: _t->openFile(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData DialogExtraControls::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject DialogExtraControls::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_DialogExtraControls,
      qt_meta_data_DialogExtraControls, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DialogExtraControls::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DialogExtraControls::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DialogExtraControls::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DialogExtraControls))
        return static_cast<void*>(const_cast< DialogExtraControls*>(this));
    return QDialog::qt_metacast(_clname);
}

int DialogExtraControls::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 16)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 16;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
