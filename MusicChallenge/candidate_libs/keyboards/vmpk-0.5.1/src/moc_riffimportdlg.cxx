/****************************************************************************
** Meta object code from reading C++ file 'riffimportdlg.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "riffimportdlg.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'riffimportdlg.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_RiffImportDlg[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      28,   15,   14,   14, 0x09,
      83,   60,   14,   14, 0x09,
     122,   14,   14,   14, 0x09,
     134,   14,   14,   14, 0x09,

       0        // eod
};

static const char qt_meta_stringdata_RiffImportDlg[] = {
    "RiffImportDlg\0\0bank,pc,name\0"
    "slotInstrument(int,int,QString)\0"
    "name,version,copyright\0"
    "slotCompleted(QString,QString,QString)\0"
    "openInput()\0openOutput()\0"
};

void RiffImportDlg::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        RiffImportDlg *_t = static_cast<RiffImportDlg *>(_o);
        switch (_id) {
        case 0: _t->slotInstrument((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 1: _t->slotCompleted((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 2: _t->openInput(); break;
        case 3: _t->openOutput(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData RiffImportDlg::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject RiffImportDlg::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_RiffImportDlg,
      qt_meta_data_RiffImportDlg, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &RiffImportDlg::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *RiffImportDlg::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *RiffImportDlg::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_RiffImportDlg))
        return static_cast<void*>(const_cast< RiffImportDlg*>(this));
    return QDialog::qt_metacast(_clname);
}

int RiffImportDlg::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
