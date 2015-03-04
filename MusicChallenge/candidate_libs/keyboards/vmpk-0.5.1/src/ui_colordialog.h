/*

   MIDI Virtual Piano Keyboard
   Copyright (C) 2008-2013, Pedro Lopez-Cabanillas

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License along
   with this program; If not, see http://www.gnu.org/licenses/
 
*/

/********************************************************************************
** Form generated from reading UI file 'colordialog.ui'
**
** Created by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_COLORDIALOG_H
#define UI_COLORDIALOG_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QComboBox>
#include <QtGui/QDialog>
#include <QtGui/QDialogButtonBox>
#include <QtGui/QGridLayout>
#include <QtGui/QGroupBox>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_ColorDialog
{
public:
    QVBoxLayout *verticalLayout;
    QComboBox *paletteNames;
    QGroupBox *groupBox;
    QGridLayout *gridLayout;
    QLabel *paletteText;
    QDialogButtonBox *buttonBox;

    void setupUi(QDialog *ColorDialog)
    {
        if (ColorDialog->objectName().isEmpty())
            ColorDialog->setObjectName(QString::fromUtf8("ColorDialog"));
        ColorDialog->resize(320, 380);
        ColorDialog->setMinimumSize(QSize(320, 380));
        QIcon icon;
        icon.addFile(QString::fromUtf8("../data/vmpk_32x32.png"), QSize(), QIcon::Normal, QIcon::Off);
        ColorDialog->setWindowIcon(icon);
        verticalLayout = new QVBoxLayout(ColorDialog);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        paletteNames = new QComboBox(ColorDialog);
        paletteNames->setObjectName(QString::fromUtf8("paletteNames"));
        paletteNames->setMinimumSize(QSize(200, 0));

        verticalLayout->addWidget(paletteNames);

        groupBox = new QGroupBox(ColorDialog);
        groupBox->setObjectName(QString::fromUtf8("groupBox"));
        gridLayout = new QGridLayout(groupBox);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));

        verticalLayout->addWidget(groupBox);

        paletteText = new QLabel(ColorDialog);
        paletteText->setObjectName(QString::fromUtf8("paletteText"));
        paletteText->setMaximumSize(QSize(16777215, 50));
        paletteText->setWordWrap(true);
        paletteText->setTextInteractionFlags(Qt::NoTextInteraction);

        verticalLayout->addWidget(paletteText);

        buttonBox = new QDialogButtonBox(ColorDialog);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok|QDialogButtonBox::RestoreDefaults);

        verticalLayout->addWidget(buttonBox);


        retranslateUi(ColorDialog);
        QObject::connect(buttonBox, SIGNAL(accepted()), ColorDialog, SLOT(accept()));
        QObject::connect(buttonBox, SIGNAL(rejected()), ColorDialog, SLOT(reject()));

        QMetaObject::connectSlotsByName(ColorDialog);
    } // setupUi

    void retranslateUi(QDialog *ColorDialog)
    {
        ColorDialog->setWindowTitle(QApplication::translate("ColorDialog", "Color Palette", 0, QApplication::UnicodeUTF8));
        groupBox->setTitle(QApplication::translate("ColorDialog", "Colors", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class ColorDialog: public Ui_ColorDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_COLORDIALOG_H
