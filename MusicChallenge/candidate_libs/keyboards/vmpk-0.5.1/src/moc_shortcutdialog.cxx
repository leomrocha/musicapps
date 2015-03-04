/****************************************************************************
** Meta object code from reading C++ file 'shortcutdialog.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "shortcutdialog.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'shortcutdialog.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ShortcutTableItemEditor[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      25,   24,   24,   24, 0x05,

 // slots: signature, parameters, type, tag, flags
      43,   24,   24,   24, 0x09,
      51,   24,   24,   24, 0x09,

       0        // eod
};

static const char qt_meta_stringdata_ShortcutTableItemEditor[] = {
    "ShortcutTableItemEditor\0\0editingFinished()\0"
    "clear()\0finish()\0"
};

void ShortcutTableItemEditor::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ShortcutTableItemEditor *_t = static_cast<ShortcutTableItemEditor *>(_o);
        switch (_id) {
        case 0: _t->editingFinished(); break;
        case 1: _t->clear(); break;
        case 2: _t->finish(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObjectExtraData ShortcutTableItemEditor::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ShortcutTableItemEditor::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_ShortcutTableItemEditor,
      qt_meta_data_ShortcutTableItemEditor, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ShortcutTableItemEditor::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ShortcutTableItemEditor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ShortcutTableItemEditor::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ShortcutTableItemEditor))
        return static_cast<void*>(const_cast< ShortcutTableItemEditor*>(this));
    return QWidget::qt_metacast(_clname);
}

int ShortcutTableItemEditor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void ShortcutTableItemEditor::editingFinished()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
static const uint qt_meta_data_ShortcutTableItemDelegate[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      27,   26,   26,   26, 0x09,

       0        // eod
};

static const char qt_meta_stringdata_ShortcutTableItemDelegate[] = {
    "ShortcutTableItemDelegate\0\0commitEditor()\0"
};

void ShortcutTableItemDelegate::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ShortcutTableItemDelegate *_t = static_cast<ShortcutTableItemDelegate *>(_o);
        switch (_id) {
        case 0: _t->commitEditor(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObjectExtraData ShortcutTableItemDelegate::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ShortcutTableItemDelegate::staticMetaObject = {
    { &QItemDelegate::staticMetaObject, qt_meta_stringdata_ShortcutTableItemDelegate,
      qt_meta_data_ShortcutTableItemDelegate, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ShortcutTableItemDelegate::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ShortcutTableItemDelegate::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ShortcutTableItemDelegate::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ShortcutTableItemDelegate))
        return static_cast<void*>(const_cast< ShortcutTableItemDelegate*>(this));
    return QItemDelegate::qt_metacast(_clname);
}

int ShortcutTableItemDelegate::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QItemDelegate::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}
static const uint qt_meta_data_ShortcutDialog[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      16,   15,   15,   15, 0x09,
      51,   15,   15,   15, 0x09,
      84,   15,   15,   15, 0x09,
     106,   15,   15,   15, 0x09,
     115,   15,   15,   15, 0x09,

       0        // eod
};

static const char qt_meta_stringdata_ShortcutDialog[] = {
    "ShortcutDialog\0\0actionActivated(QTableWidgetItem*)\0"
    "actionChanged(QTableWidgetItem*)\0"
    "slotRestoreDefaults()\0accept()\0reject()\0"
};

void ShortcutDialog::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ShortcutDialog *_t = static_cast<ShortcutDialog *>(_o);
        switch (_id) {
        case 0: _t->actionActivated((*reinterpret_cast< QTableWidgetItem*(*)>(_a[1]))); break;
        case 1: _t->actionChanged((*reinterpret_cast< QTableWidgetItem*(*)>(_a[1]))); break;
        case 2: _t->slotRestoreDefaults(); break;
        case 3: _t->accept(); break;
        case 4: _t->reject(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ShortcutDialog::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ShortcutDialog::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_ShortcutDialog,
      qt_meta_data_ShortcutDialog, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ShortcutDialog::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ShortcutDialog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ShortcutDialog::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ShortcutDialog))
        return static_cast<void*>(const_cast< ShortcutDialog*>(this));
    return QDialog::qt_metacast(_clname);
}

int ShortcutDialog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
