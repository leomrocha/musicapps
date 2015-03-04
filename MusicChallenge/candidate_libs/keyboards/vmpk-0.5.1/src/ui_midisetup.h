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
** Form generated from reading UI file 'midisetup.ui'
**
** Created by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MIDISETUP_H
#define UI_MIDISETUP_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QCheckBox>
#include <QtGui/QComboBox>
#include <QtGui/QDialog>
#include <QtGui/QDialogButtonBox>
#include <QtGui/QGridLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>

QT_BEGIN_NAMESPACE

class Ui_MidiSetupClass
{
public:
    QGridLayout *gridLayout;
    QCheckBox *chkEnableInput;
    QCheckBox *chkEnableThru;
    QLabel *labelInput;
    QComboBox *comboInput;
    QLabel *labelOutput;
    QComboBox *comboOutput;
    QDialogButtonBox *buttonBox;
    QCheckBox *chkOmni;

    void setupUi(QDialog *MidiSetupClass)
    {
        if (MidiSetupClass->objectName().isEmpty())
            MidiSetupClass->setObjectName(QString::fromUtf8("MidiSetupClass"));
        MidiSetupClass->resize(420, 186);
        MidiSetupClass->setMinimumSize(QSize(420, 0));
        QIcon icon;
        icon.addFile(QString::fromUtf8(":/vpiano/vmpk_32x32.png"), QSize(), QIcon::Normal, QIcon::Off);
        MidiSetupClass->setWindowIcon(icon);
        gridLayout = new QGridLayout(MidiSetupClass);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        chkEnableInput = new QCheckBox(MidiSetupClass);
        chkEnableInput->setObjectName(QString::fromUtf8("chkEnableInput"));
        chkEnableInput->setChecked(true);

        gridLayout->addWidget(chkEnableInput, 0, 0, 1, 2);

        chkEnableThru = new QCheckBox(MidiSetupClass);
        chkEnableThru->setObjectName(QString::fromUtf8("chkEnableThru"));

        gridLayout->addWidget(chkEnableThru, 1, 0, 1, 2);

        labelInput = new QLabel(MidiSetupClass);
        labelInput->setObjectName(QString::fromUtf8("labelInput"));
        QSizePolicy sizePolicy(QSizePolicy::Minimum, QSizePolicy::Preferred);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(labelInput->sizePolicy().hasHeightForWidth());
        labelInput->setSizePolicy(sizePolicy);

        gridLayout->addWidget(labelInput, 3, 0, 1, 1);

        comboInput = new QComboBox(MidiSetupClass);
        comboInput->setObjectName(QString::fromUtf8("comboInput"));
        QSizePolicy sizePolicy1(QSizePolicy::Expanding, QSizePolicy::Fixed);
        sizePolicy1.setHorizontalStretch(0);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(comboInput->sizePolicy().hasHeightForWidth());
        comboInput->setSizePolicy(sizePolicy1);
        comboInput->setMinimumSize(QSize(180, 0));

        gridLayout->addWidget(comboInput, 3, 1, 1, 1);

        labelOutput = new QLabel(MidiSetupClass);
        labelOutput->setObjectName(QString::fromUtf8("labelOutput"));
        sizePolicy.setHeightForWidth(labelOutput->sizePolicy().hasHeightForWidth());
        labelOutput->setSizePolicy(sizePolicy);

        gridLayout->addWidget(labelOutput, 4, 0, 1, 1);

        comboOutput = new QComboBox(MidiSetupClass);
        comboOutput->setObjectName(QString::fromUtf8("comboOutput"));
        sizePolicy1.setHeightForWidth(comboOutput->sizePolicy().hasHeightForWidth());
        comboOutput->setSizePolicy(sizePolicy1);
        comboOutput->setMinimumSize(QSize(180, 0));

        gridLayout->addWidget(comboOutput, 4, 1, 1, 1);

        buttonBox = new QDialogButtonBox(MidiSetupClass);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok);

        gridLayout->addWidget(buttonBox, 5, 0, 1, 2);

        chkOmni = new QCheckBox(MidiSetupClass);
        chkOmni->setObjectName(QString::fromUtf8("chkOmni"));

        gridLayout->addWidget(chkOmni, 2, 0, 1, 1);

#ifndef QT_NO_SHORTCUT
        labelInput->setBuddy(comboInput);
        labelOutput->setBuddy(comboOutput);
#endif // QT_NO_SHORTCUT
        QWidget::setTabOrder(chkEnableInput, chkEnableThru);
        QWidget::setTabOrder(chkEnableThru, chkOmni);
        QWidget::setTabOrder(chkOmni, comboInput);
        QWidget::setTabOrder(comboInput, comboOutput);
        QWidget::setTabOrder(comboOutput, buttonBox);

        retranslateUi(MidiSetupClass);
        QObject::connect(buttonBox, SIGNAL(accepted()), MidiSetupClass, SLOT(accept()));
        QObject::connect(buttonBox, SIGNAL(rejected()), MidiSetupClass, SLOT(reject()));
        QObject::connect(chkEnableInput, SIGNAL(toggled(bool)), comboInput, SLOT(setEnabled(bool)));
        QObject::connect(chkEnableInput, SIGNAL(toggled(bool)), chkEnableThru, SLOT(setEnabled(bool)));
        QObject::connect(chkEnableInput, SIGNAL(toggled(bool)), chkOmni, SLOT(setEnabled(bool)));

        QMetaObject::connectSlotsByName(MidiSetupClass);
    } // setupUi

    void retranslateUi(QDialog *MidiSetupClass)
    {
        MidiSetupClass->setWindowTitle(QApplication::translate("MidiSetupClass", "MIDI Setup", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_WHATSTHIS
        chkEnableInput->setWhatsThis(QApplication::translate("MidiSetupClass", "Check this box to enable MIDI input for the program. In Linux and Mac OSX the input port is always enabled and can't be un-ckecked", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_WHATSTHIS
        chkEnableInput->setText(QApplication::translate("MidiSetupClass", "Enable MIDI input", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_WHATSTHIS
        chkEnableThru->setWhatsThis(QApplication::translate("MidiSetupClass", "Check this box to enable the MIDI Thru function: any MIDI event received in the input port will be copied unchanged to the output port", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_WHATSTHIS
        chkEnableThru->setText(QApplication::translate("MidiSetupClass", "Enable MIDI Thru on MIDI Output", 0, QApplication::UnicodeUTF8));
        labelInput->setText(QApplication::translate("MidiSetupClass", "Input MIDI Connection", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_WHATSTHIS
        comboInput->setWhatsThis(QApplication::translate("MidiSetupClass", "Use this control to change the connection for the MIDI input port, if it is enabled", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_WHATSTHIS
        labelOutput->setText(QApplication::translate("MidiSetupClass", "Output MIDI Connection", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_WHATSTHIS
        comboOutput->setWhatsThis(QApplication::translate("MidiSetupClass", "Use this control to change the connection for the MIDI output port", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_WHATSTHIS
        chkOmni->setText(QApplication::translate("MidiSetupClass", "MIDI Omni mode", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class MidiSetupClass: public Ui_MidiSetupClass {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MIDISETUP_H
