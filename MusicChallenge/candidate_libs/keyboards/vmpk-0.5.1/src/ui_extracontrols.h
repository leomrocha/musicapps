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
** Form generated from reading UI file 'extracontrols.ui'
**
** Created by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_EXTRACONTROLS_H
#define UI_EXTRACONTROLS_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QCheckBox>
#include <QtGui/QComboBox>
#include <QtGui/QDialog>
#include <QtGui/QDialogButtonBox>
#include <QtGui/QFrame>
#include <QtGui/QGridLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QListWidget>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QSpinBox>
#include <QtGui/QStackedWidget>
#include <QtGui/QToolButton>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_DialogExtraControls
{
public:
    QGridLayout *gridLayout_6;
    QListWidget *extraList;
    QFrame *commonFrame;
    QGridLayout *gridLayout_3;
    QLabel *lblLabel;
    QLineEdit *txtLabel;
    QLabel *lblController;
    QSpinBox *spinController;
    QFrame *frameButtons;
    QVBoxLayout *verticalLayout;
    QPushButton *btnAdd;
    QPushButton *btnRemove;
    QPushButton *btnUp;
    QPushButton *btnDown;
    QSpacerItem *verticalSpacer;
    QComboBox *cboControlType;
    QStackedWidget *stackedPanel;
    QWidget *pageSwitch;
    QGridLayout *gridLayout_2;
    QCheckBox *chkSwitchDefOn;
    QLabel *lblvalueOn;
    QSpinBox *spinValueOn;
    QLabel *lblValueOff;
    QSpinBox *spinValueOff;
    QWidget *pageKnob;
    QGridLayout *gridLayout;
    QLabel *lblKnobMin;
    QSpinBox *spinKnobMin;
    QLabel *lblKnobMax;
    QSpinBox *spinKnobMax;
    QLabel *labelKnobDef;
    QSpinBox *spinKnobDef;
    QWidget *pageSpinbox;
    QGridLayout *gridLayout_4;
    QLabel *lblSpinMin;
    QSpinBox *spinSpinMin;
    QLabel *lblSpinMax;
    QSpinBox *spinSpinMax;
    QLabel *lblSpinDef;
    QSpinBox *spinSpinDef;
    QWidget *pageSlider;
    QGridLayout *gridLayout_5;
    QLabel *lblSliderSize;
    QSpinBox *spinSliderSize;
    QLabel *lblSliderMin;
    QSpinBox *spinSliderMin;
    QLabel *lblSliderMax;
    QSpinBox *spinSliderMax;
    QLabel *lblSliderDef;
    QSpinBox *spinSliderDef;
    QWidget *pageButtonCtl;
    QGridLayout *gridLayout_7;
    QLabel *lblvalue;
    QSpinBox *spinValue;
    QSpacerItem *verticalSpacer_3;
    QWidget *pageButtonSyx;
    QGridLayout *gridLayout_8;
    QLabel *lblFileName;
    QLineEdit *edtFileSyx;
    QToolButton *btnFileSyx;
    QSpacerItem *verticalSpacer_2;
    QDialogButtonBox *buttonBox;

    void setupUi(QDialog *DialogExtraControls)
    {
        if (DialogExtraControls->objectName().isEmpty())
            DialogExtraControls->setObjectName(QString::fromUtf8("DialogExtraControls"));
        DialogExtraControls->resize(376, 267);
        QIcon icon;
        icon.addFile(QString::fromUtf8(":/vpiano/vmpk_32x32.png"), QSize(), QIcon::Normal, QIcon::Off);
        DialogExtraControls->setWindowIcon(icon);
        gridLayout_6 = new QGridLayout(DialogExtraControls);
        gridLayout_6->setObjectName(QString::fromUtf8("gridLayout_6"));
        extraList = new QListWidget(DialogExtraControls);
        extraList->setObjectName(QString::fromUtf8("extraList"));
        extraList->setMinimumSize(QSize(100, 0));

        gridLayout_6->addWidget(extraList, 0, 0, 3, 1);

        commonFrame = new QFrame(DialogExtraControls);
        commonFrame->setObjectName(QString::fromUtf8("commonFrame"));
        commonFrame->setEnabled(false);
        commonFrame->setFrameShape(QFrame::StyledPanel);
        commonFrame->setFrameShadow(QFrame::Raised);
        gridLayout_3 = new QGridLayout(commonFrame);
        gridLayout_3->setObjectName(QString::fromUtf8("gridLayout_3"));
        lblLabel = new QLabel(commonFrame);
        lblLabel->setObjectName(QString::fromUtf8("lblLabel"));

        gridLayout_3->addWidget(lblLabel, 0, 0, 1, 1);

        txtLabel = new QLineEdit(commonFrame);
        txtLabel->setObjectName(QString::fromUtf8("txtLabel"));

        gridLayout_3->addWidget(txtLabel, 0, 1, 1, 2);

        lblController = new QLabel(commonFrame);
        lblController->setObjectName(QString::fromUtf8("lblController"));

        gridLayout_3->addWidget(lblController, 1, 0, 1, 2);

        spinController = new QSpinBox(commonFrame);
        spinController->setObjectName(QString::fromUtf8("spinController"));
        spinController->setMaximum(127);

        gridLayout_3->addWidget(spinController, 1, 2, 1, 1);


        gridLayout_6->addWidget(commonFrame, 0, 1, 1, 1);

        frameButtons = new QFrame(DialogExtraControls);
        frameButtons->setObjectName(QString::fromUtf8("frameButtons"));
        frameButtons->setFrameShape(QFrame::NoFrame);
        verticalLayout = new QVBoxLayout(frameButtons);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        btnAdd = new QPushButton(frameButtons);
        btnAdd->setObjectName(QString::fromUtf8("btnAdd"));
        QIcon icon1;
        icon1.addFile(QString::fromUtf8(":/vpiano/list-add.svg"), QSize(), QIcon::Normal, QIcon::Off);
        btnAdd->setIcon(icon1);

        verticalLayout->addWidget(btnAdd);

        btnRemove = new QPushButton(frameButtons);
        btnRemove->setObjectName(QString::fromUtf8("btnRemove"));
        btnRemove->setEnabled(false);
        QIcon icon2;
        icon2.addFile(QString::fromUtf8(":/vpiano/list-remove.svg"), QSize(), QIcon::Normal, QIcon::Off);
        btnRemove->setIcon(icon2);

        verticalLayout->addWidget(btnRemove);

        btnUp = new QPushButton(frameButtons);
        btnUp->setObjectName(QString::fromUtf8("btnUp"));
        btnUp->setEnabled(false);

        verticalLayout->addWidget(btnUp);

        btnDown = new QPushButton(frameButtons);
        btnDown->setObjectName(QString::fromUtf8("btnDown"));
        btnDown->setEnabled(false);

        verticalLayout->addWidget(btnDown);

        verticalSpacer = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout->addItem(verticalSpacer);


        gridLayout_6->addWidget(frameButtons, 0, 2, 3, 1);

        cboControlType = new QComboBox(DialogExtraControls);
        cboControlType->setObjectName(QString::fromUtf8("cboControlType"));
        cboControlType->setEnabled(false);

        gridLayout_6->addWidget(cboControlType, 1, 1, 1, 1);

        stackedPanel = new QStackedWidget(DialogExtraControls);
        stackedPanel->setObjectName(QString::fromUtf8("stackedPanel"));
        stackedPanel->setEnabled(false);
        stackedPanel->setFrameShape(QFrame::StyledPanel);
        stackedPanel->setFrameShadow(QFrame::Raised);
        pageSwitch = new QWidget();
        pageSwitch->setObjectName(QString::fromUtf8("pageSwitch"));
        gridLayout_2 = new QGridLayout(pageSwitch);
        gridLayout_2->setObjectName(QString::fromUtf8("gridLayout_2"));
        chkSwitchDefOn = new QCheckBox(pageSwitch);
        chkSwitchDefOn->setObjectName(QString::fromUtf8("chkSwitchDefOn"));

        gridLayout_2->addWidget(chkSwitchDefOn, 0, 0, 1, 2);

        lblvalueOn = new QLabel(pageSwitch);
        lblvalueOn->setObjectName(QString::fromUtf8("lblvalueOn"));

        gridLayout_2->addWidget(lblvalueOn, 1, 0, 1, 1);

        spinValueOn = new QSpinBox(pageSwitch);
        spinValueOn->setObjectName(QString::fromUtf8("spinValueOn"));
        spinValueOn->setMaximum(127);

        gridLayout_2->addWidget(spinValueOn, 1, 1, 1, 1);

        lblValueOff = new QLabel(pageSwitch);
        lblValueOff->setObjectName(QString::fromUtf8("lblValueOff"));

        gridLayout_2->addWidget(lblValueOff, 2, 0, 1, 1);

        spinValueOff = new QSpinBox(pageSwitch);
        spinValueOff->setObjectName(QString::fromUtf8("spinValueOff"));
        spinValueOff->setMaximum(127);

        gridLayout_2->addWidget(spinValueOff, 2, 1, 1, 1);

        stackedPanel->addWidget(pageSwitch);
        pageKnob = new QWidget();
        pageKnob->setObjectName(QString::fromUtf8("pageKnob"));
        gridLayout = new QGridLayout(pageKnob);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        lblKnobMin = new QLabel(pageKnob);
        lblKnobMin->setObjectName(QString::fromUtf8("lblKnobMin"));

        gridLayout->addWidget(lblKnobMin, 0, 0, 1, 1);

        spinKnobMin = new QSpinBox(pageKnob);
        spinKnobMin->setObjectName(QString::fromUtf8("spinKnobMin"));
        spinKnobMin->setMaximum(127);

        gridLayout->addWidget(spinKnobMin, 0, 1, 1, 1);

        lblKnobMax = new QLabel(pageKnob);
        lblKnobMax->setObjectName(QString::fromUtf8("lblKnobMax"));

        gridLayout->addWidget(lblKnobMax, 1, 0, 1, 1);

        spinKnobMax = new QSpinBox(pageKnob);
        spinKnobMax->setObjectName(QString::fromUtf8("spinKnobMax"));
        spinKnobMax->setMaximum(127);

        gridLayout->addWidget(spinKnobMax, 1, 1, 1, 1);

        labelKnobDef = new QLabel(pageKnob);
        labelKnobDef->setObjectName(QString::fromUtf8("labelKnobDef"));

        gridLayout->addWidget(labelKnobDef, 2, 0, 1, 1);

        spinKnobDef = new QSpinBox(pageKnob);
        spinKnobDef->setObjectName(QString::fromUtf8("spinKnobDef"));
        spinKnobDef->setMaximum(127);

        gridLayout->addWidget(spinKnobDef, 2, 1, 1, 1);

        stackedPanel->addWidget(pageKnob);
        pageSpinbox = new QWidget();
        pageSpinbox->setObjectName(QString::fromUtf8("pageSpinbox"));
        gridLayout_4 = new QGridLayout(pageSpinbox);
        gridLayout_4->setObjectName(QString::fromUtf8("gridLayout_4"));
        lblSpinMin = new QLabel(pageSpinbox);
        lblSpinMin->setObjectName(QString::fromUtf8("lblSpinMin"));

        gridLayout_4->addWidget(lblSpinMin, 0, 0, 1, 1);

        spinSpinMin = new QSpinBox(pageSpinbox);
        spinSpinMin->setObjectName(QString::fromUtf8("spinSpinMin"));
        spinSpinMin->setMaximum(127);

        gridLayout_4->addWidget(spinSpinMin, 0, 1, 1, 1);

        lblSpinMax = new QLabel(pageSpinbox);
        lblSpinMax->setObjectName(QString::fromUtf8("lblSpinMax"));

        gridLayout_4->addWidget(lblSpinMax, 1, 0, 1, 1);

        spinSpinMax = new QSpinBox(pageSpinbox);
        spinSpinMax->setObjectName(QString::fromUtf8("spinSpinMax"));
        spinSpinMax->setMaximum(127);

        gridLayout_4->addWidget(spinSpinMax, 1, 1, 1, 1);

        lblSpinDef = new QLabel(pageSpinbox);
        lblSpinDef->setObjectName(QString::fromUtf8("lblSpinDef"));

        gridLayout_4->addWidget(lblSpinDef, 2, 0, 1, 1);

        spinSpinDef = new QSpinBox(pageSpinbox);
        spinSpinDef->setObjectName(QString::fromUtf8("spinSpinDef"));
        spinSpinDef->setMaximum(127);

        gridLayout_4->addWidget(spinSpinDef, 2, 1, 1, 1);

        stackedPanel->addWidget(pageSpinbox);
        pageSlider = new QWidget();
        pageSlider->setObjectName(QString::fromUtf8("pageSlider"));
        gridLayout_5 = new QGridLayout(pageSlider);
        gridLayout_5->setObjectName(QString::fromUtf8("gridLayout_5"));
        lblSliderSize = new QLabel(pageSlider);
        lblSliderSize->setObjectName(QString::fromUtf8("lblSliderSize"));

        gridLayout_5->addWidget(lblSliderSize, 0, 0, 1, 1);

        spinSliderSize = new QSpinBox(pageSlider);
        spinSliderSize->setObjectName(QString::fromUtf8("spinSliderSize"));
        spinSliderSize->setMaximum(9999);

        gridLayout_5->addWidget(spinSliderSize, 0, 1, 1, 1);

        lblSliderMin = new QLabel(pageSlider);
        lblSliderMin->setObjectName(QString::fromUtf8("lblSliderMin"));

        gridLayout_5->addWidget(lblSliderMin, 1, 0, 1, 1);

        spinSliderMin = new QSpinBox(pageSlider);
        spinSliderMin->setObjectName(QString::fromUtf8("spinSliderMin"));
        spinSliderMin->setMaximum(127);

        gridLayout_5->addWidget(spinSliderMin, 1, 1, 1, 1);

        lblSliderMax = new QLabel(pageSlider);
        lblSliderMax->setObjectName(QString::fromUtf8("lblSliderMax"));

        gridLayout_5->addWidget(lblSliderMax, 2, 0, 1, 1);

        spinSliderMax = new QSpinBox(pageSlider);
        spinSliderMax->setObjectName(QString::fromUtf8("spinSliderMax"));
        spinSliderMax->setMaximum(127);

        gridLayout_5->addWidget(spinSliderMax, 2, 1, 1, 1);

        lblSliderDef = new QLabel(pageSlider);
        lblSliderDef->setObjectName(QString::fromUtf8("lblSliderDef"));

        gridLayout_5->addWidget(lblSliderDef, 3, 0, 1, 1);

        spinSliderDef = new QSpinBox(pageSlider);
        spinSliderDef->setObjectName(QString::fromUtf8("spinSliderDef"));
        spinSliderDef->setMaximum(127);

        gridLayout_5->addWidget(spinSliderDef, 3, 1, 1, 1);

        stackedPanel->addWidget(pageSlider);
        pageButtonCtl = new QWidget();
        pageButtonCtl->setObjectName(QString::fromUtf8("pageButtonCtl"));
        gridLayout_7 = new QGridLayout(pageButtonCtl);
        gridLayout_7->setObjectName(QString::fromUtf8("gridLayout_7"));
        lblvalue = new QLabel(pageButtonCtl);
        lblvalue->setObjectName(QString::fromUtf8("lblvalue"));

        gridLayout_7->addWidget(lblvalue, 0, 0, 1, 1);

        spinValue = new QSpinBox(pageButtonCtl);
        spinValue->setObjectName(QString::fromUtf8("spinValue"));
        spinValue->setMaximum(127);

        gridLayout_7->addWidget(spinValue, 0, 1, 1, 1);

        verticalSpacer_3 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_7->addItem(verticalSpacer_3, 1, 0, 1, 1);

        stackedPanel->addWidget(pageButtonCtl);
        pageButtonSyx = new QWidget();
        pageButtonSyx->setObjectName(QString::fromUtf8("pageButtonSyx"));
        gridLayout_8 = new QGridLayout(pageButtonSyx);
        gridLayout_8->setObjectName(QString::fromUtf8("gridLayout_8"));
        lblFileName = new QLabel(pageButtonSyx);
        lblFileName->setObjectName(QString::fromUtf8("lblFileName"));
        lblFileName->setAlignment(Qt::AlignBottom|Qt::AlignLeading|Qt::AlignLeft);

        gridLayout_8->addWidget(lblFileName, 0, 0, 1, 1);

        edtFileSyx = new QLineEdit(pageButtonSyx);
        edtFileSyx->setObjectName(QString::fromUtf8("edtFileSyx"));
        edtFileSyx->setReadOnly(true);

        gridLayout_8->addWidget(edtFileSyx, 1, 0, 1, 1);

        btnFileSyx = new QToolButton(pageButtonSyx);
        btnFileSyx->setObjectName(QString::fromUtf8("btnFileSyx"));

        gridLayout_8->addWidget(btnFileSyx, 1, 1, 1, 1);

        verticalSpacer_2 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout_8->addItem(verticalSpacer_2, 2, 0, 1, 1);

        stackedPanel->addWidget(pageButtonSyx);

        gridLayout_6->addWidget(stackedPanel, 2, 1, 1, 1);

        buttonBox = new QDialogButtonBox(DialogExtraControls);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok);

        gridLayout_6->addWidget(buttonBox, 3, 0, 1, 3);

#ifndef QT_NO_SHORTCUT
        lblLabel->setBuddy(txtLabel);
        lblController->setBuddy(spinController);
        lblvalueOn->setBuddy(spinValueOn);
        lblValueOff->setBuddy(spinValueOff);
        lblKnobMin->setBuddy(spinKnobMin);
        lblKnobMax->setBuddy(spinKnobMax);
        labelKnobDef->setBuddy(spinKnobDef);
        lblSpinMin->setBuddy(spinSpinMin);
        lblSpinMax->setBuddy(spinSpinMax);
        lblSpinDef->setBuddy(spinSpinDef);
        lblSliderSize->setBuddy(spinSliderSize);
        lblSliderMin->setBuddy(spinSliderMin);
        lblSliderMax->setBuddy(spinSliderMax);
        lblSliderDef->setBuddy(spinSliderDef);
        lblvalue->setBuddy(spinValueOn);
#endif // QT_NO_SHORTCUT
        QWidget::setTabOrder(extraList, txtLabel);
        QWidget::setTabOrder(txtLabel, spinController);
        QWidget::setTabOrder(spinController, chkSwitchDefOn);
        QWidget::setTabOrder(chkSwitchDefOn, spinValueOn);
        QWidget::setTabOrder(spinValueOn, spinValueOff);
        QWidget::setTabOrder(spinValueOff, spinKnobMin);
        QWidget::setTabOrder(spinKnobMin, spinKnobMax);
        QWidget::setTabOrder(spinKnobMax, spinKnobDef);
        QWidget::setTabOrder(spinKnobDef, spinSpinMin);
        QWidget::setTabOrder(spinSpinMin, spinSpinMax);
        QWidget::setTabOrder(spinSpinMax, spinSpinDef);
        QWidget::setTabOrder(spinSpinDef, spinSliderSize);
        QWidget::setTabOrder(spinSliderSize, spinSliderMin);
        QWidget::setTabOrder(spinSliderMin, spinSliderMax);
        QWidget::setTabOrder(spinSliderMax, spinSliderDef);
        QWidget::setTabOrder(spinSliderDef, btnAdd);
        QWidget::setTabOrder(btnAdd, btnRemove);
        QWidget::setTabOrder(btnRemove, btnUp);
        QWidget::setTabOrder(btnUp, btnDown);
        QWidget::setTabOrder(btnDown, buttonBox);

        retranslateUi(DialogExtraControls);
        QObject::connect(buttonBox, SIGNAL(accepted()), DialogExtraControls, SLOT(accept()));
        QObject::connect(buttonBox, SIGNAL(rejected()), DialogExtraControls, SLOT(reject()));
        QObject::connect(cboControlType, SIGNAL(currentIndexChanged(int)), stackedPanel, SLOT(setCurrentIndex(int)));
        QObject::connect(stackedPanel, SIGNAL(currentChanged(int)), cboControlType, SLOT(setCurrentIndex(int)));

        stackedPanel->setCurrentIndex(0);


        QMetaObject::connectSlotsByName(DialogExtraControls);
    } // setupUi

    void retranslateUi(QDialog *DialogExtraControls)
    {
        DialogExtraControls->setWindowTitle(QApplication::translate("DialogExtraControls", "Extra Controls Editor", 0, QApplication::UnicodeUTF8));
        lblLabel->setText(QApplication::translate("DialogExtraControls", "Label:", 0, QApplication::UnicodeUTF8));
        lblController->setText(QApplication::translate("DialogExtraControls", "MIDI Controller:", 0, QApplication::UnicodeUTF8));
        btnAdd->setText(QApplication::translate("DialogExtraControls", "Add", 0, QApplication::UnicodeUTF8));
        btnRemove->setText(QApplication::translate("DialogExtraControls", "Remove", 0, QApplication::UnicodeUTF8));
        btnUp->setText(QApplication::translate("DialogExtraControls", "Up", 0, QApplication::UnicodeUTF8));
        btnDown->setText(QApplication::translate("DialogExtraControls", "Down", 0, QApplication::UnicodeUTF8));
        cboControlType->clear();
        cboControlType->insertItems(0, QStringList()
         << QApplication::translate("DialogExtraControls", "Switch", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("DialogExtraControls", "Knob", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("DialogExtraControls", "Spin box", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("DialogExtraControls", "Slider", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("DialogExtraControls", "Button Ctl", 0, QApplication::UnicodeUTF8)
         << QApplication::translate("DialogExtraControls", "Button SysEx", 0, QApplication::UnicodeUTF8)
        );
        chkSwitchDefOn->setText(QApplication::translate("DialogExtraControls", "Default ON", 0, QApplication::UnicodeUTF8));
        lblvalueOn->setText(QApplication::translate("DialogExtraControls", "value ON:", 0, QApplication::UnicodeUTF8));
        lblValueOff->setText(QApplication::translate("DialogExtraControls", "value OFF:", 0, QApplication::UnicodeUTF8));
        lblKnobMin->setText(QApplication::translate("DialogExtraControls", "Min. value:", 0, QApplication::UnicodeUTF8));
        lblKnobMax->setText(QApplication::translate("DialogExtraControls", "Max. value:", 0, QApplication::UnicodeUTF8));
        labelKnobDef->setText(QApplication::translate("DialogExtraControls", "Default value:", 0, QApplication::UnicodeUTF8));
        lblSpinMin->setText(QApplication::translate("DialogExtraControls", "Min. value:", 0, QApplication::UnicodeUTF8));
        lblSpinMax->setText(QApplication::translate("DialogExtraControls", "Max. value:", 0, QApplication::UnicodeUTF8));
        lblSpinDef->setText(QApplication::translate("DialogExtraControls", "Default value:", 0, QApplication::UnicodeUTF8));
        lblSliderSize->setText(QApplication::translate("DialogExtraControls", "Display size:", 0, QApplication::UnicodeUTF8));
        lblSliderMin->setText(QApplication::translate("DialogExtraControls", "Min. value:", 0, QApplication::UnicodeUTF8));
        lblSliderMax->setText(QApplication::translate("DialogExtraControls", "Max. value:", 0, QApplication::UnicodeUTF8));
        lblSliderDef->setText(QApplication::translate("DialogExtraControls", "Default value:", 0, QApplication::UnicodeUTF8));
        lblvalue->setText(QApplication::translate("DialogExtraControls", "value:", 0, QApplication::UnicodeUTF8));
        lblFileName->setText(QApplication::translate("DialogExtraControls", "File name:", 0, QApplication::UnicodeUTF8));
        btnFileSyx->setText(QApplication::translate("DialogExtraControls", "...", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class DialogExtraControls: public Ui_DialogExtraControls {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_EXTRACONTROLS_H
