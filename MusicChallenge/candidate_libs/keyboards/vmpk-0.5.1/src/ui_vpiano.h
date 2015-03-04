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
** Form generated from reading UI file 'vpiano.ui'
**
** Created by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_VPIANO_H
#define UI_VPIANO_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QGridLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QMainWindow>
#include <QtGui/QMenu>
#include <QtGui/QMenuBar>
#include <QtGui/QStatusBar>
#include <QtGui/QToolBar>
#include <QtGui/QWidget>
#include "pianokeybd.h"

QT_BEGIN_NAMESPACE

class Ui_VPiano
{
public:
    QAction *actionExit;
    QAction *actionPreferences;
    QAction *actionConnections;
    QAction *actionAbout;
    QAction *actionAboutQt;
    QAction *actionNotes;
    QAction *actionControllers;
    QAction *actionBender;
    QAction *actionPrograms;
    QAction *actionStatusBar;
    QAction *actionPanic;
    QAction *actionResetAll;
    QAction *actionReset;
    QAction *actionEditKM;
    QAction *actionContents;
    QAction *actionWebSite;
    QAction *actionImportSoundFont;
    QAction *actionExtraControls;
    QAction *actionEditExtra;
    QAction *actionEditPrograms;
    QAction *actionEditExtraControls;
    QAction *actionNoteNames;
    QAction *actionShortcuts;
    QAction *actionOctaveUp;
    QAction *actionOctaveDown;
    QAction *actionTransposeUp;
    QAction *actionTransposeDown;
    QAction *actionChannelUp;
    QAction *actionChannelDown;
    QAction *actionNextController;
    QAction *actionPreviousController;
    QAction *actionControllerUp;
    QAction *actionControllerDown;
    QAction *actionNextBank;
    QAction *actionPreviousBank;
    QAction *actionNextProgram;
    QAction *actionPreviousProgram;
    QAction *actionVelocityUp;
    QAction *actionVelocityDown;
    QAction *actionAboutTranslation;
    QAction *actionKeyboardInput;
    QAction *actionMouseInput;
    QAction *actionTouchScreenInput;
    QAction *actionColorPalette;
    QAction *actionColorScale;
    QWidget *centralwidget;
    QGridLayout *gridLayout;
    PianoKeybd *pianokeybd;
    QMenuBar *menubar;
    QMenu *menuFile;
    QMenu *menuEdit;
    QMenu *menuHelp;
    QMenu *menuLanguage;
    QMenu *menuView;
    QMenu *menuTools;
    QMenu *menuNotes;
    QMenu *menuControllers;
    QMenu *menuPrograms;
    QMenu *menuNote_Input;
    QStatusBar *statusBar;
    QToolBar *toolBarNotes;
    QToolBar *toolBarControllers;
    QToolBar *toolBarBender;
    QToolBar *toolBarPrograms;
    QToolBar *toolBarExtra;

    void setupUi(QMainWindow *VPiano)
    {
        if (VPiano->objectName().isEmpty())
            VPiano->setObjectName(QString::fromUtf8("VPiano"));
        VPiano->resize(567, 274);
        VPiano->setWindowTitle(QString::fromUtf8("Virtual MIDI Piano Keyboard"));
        QIcon icon;
        icon.addFile(QString::fromUtf8(":/vpiano/vmpk_32x32.png"), QSize(), QIcon::Normal, QIcon::Off);
        VPiano->setWindowIcon(icon);
        actionExit = new QAction(VPiano);
        actionExit->setObjectName(QString::fromUtf8("actionExit"));
        actionPreferences = new QAction(VPiano);
        actionPreferences->setObjectName(QString::fromUtf8("actionPreferences"));
        actionConnections = new QAction(VPiano);
        actionConnections->setObjectName(QString::fromUtf8("actionConnections"));
        actionAbout = new QAction(VPiano);
        actionAbout->setObjectName(QString::fromUtf8("actionAbout"));
        actionAboutQt = new QAction(VPiano);
        actionAboutQt->setObjectName(QString::fromUtf8("actionAboutQt"));
        actionNotes = new QAction(VPiano);
        actionNotes->setObjectName(QString::fromUtf8("actionNotes"));
        actionNotes->setCheckable(true);
        actionControllers = new QAction(VPiano);
        actionControllers->setObjectName(QString::fromUtf8("actionControllers"));
        actionControllers->setCheckable(true);
        actionBender = new QAction(VPiano);
        actionBender->setObjectName(QString::fromUtf8("actionBender"));
        actionBender->setCheckable(true);
        actionPrograms = new QAction(VPiano);
        actionPrograms->setObjectName(QString::fromUtf8("actionPrograms"));
        actionPrograms->setCheckable(true);
        actionStatusBar = new QAction(VPiano);
        actionStatusBar->setObjectName(QString::fromUtf8("actionStatusBar"));
        actionStatusBar->setCheckable(true);
        actionStatusBar->setChecked(true);
        actionPanic = new QAction(VPiano);
        actionPanic->setObjectName(QString::fromUtf8("actionPanic"));
        actionPanic->setShortcut(QString::fromUtf8("Esc"));
        actionResetAll = new QAction(VPiano);
        actionResetAll->setObjectName(QString::fromUtf8("actionResetAll"));
        actionReset = new QAction(VPiano);
        actionReset->setObjectName(QString::fromUtf8("actionReset"));
        actionEditKM = new QAction(VPiano);
        actionEditKM->setObjectName(QString::fromUtf8("actionEditKM"));
        actionContents = new QAction(VPiano);
        actionContents->setObjectName(QString::fromUtf8("actionContents"));
        actionContents->setShortcut(QString::fromUtf8("F1"));
        actionWebSite = new QAction(VPiano);
        actionWebSite->setObjectName(QString::fromUtf8("actionWebSite"));
        actionImportSoundFont = new QAction(VPiano);
        actionImportSoundFont->setObjectName(QString::fromUtf8("actionImportSoundFont"));
        actionExtraControls = new QAction(VPiano);
        actionExtraControls->setObjectName(QString::fromUtf8("actionExtraControls"));
        actionExtraControls->setCheckable(true);
        actionEditExtra = new QAction(VPiano);
        actionEditExtra->setObjectName(QString::fromUtf8("actionEditExtra"));
        actionEditPrograms = new QAction(VPiano);
        actionEditPrograms->setObjectName(QString::fromUtf8("actionEditPrograms"));
        actionEditPrograms->setEnabled(false);
        actionEditPrograms->setVisible(false);
        actionEditPrograms->setIconVisibleInMenu(false);
        actionEditExtraControls = new QAction(VPiano);
        actionEditExtraControls->setObjectName(QString::fromUtf8("actionEditExtraControls"));
        actionNoteNames = new QAction(VPiano);
        actionNoteNames->setObjectName(QString::fromUtf8("actionNoteNames"));
        actionNoteNames->setCheckable(true);
        actionShortcuts = new QAction(VPiano);
        actionShortcuts->setObjectName(QString::fromUtf8("actionShortcuts"));
        actionOctaveUp = new QAction(VPiano);
        actionOctaveUp->setObjectName(QString::fromUtf8("actionOctaveUp"));
        actionOctaveUp->setShortcut(QString::fromUtf8("Right"));
        actionOctaveDown = new QAction(VPiano);
        actionOctaveDown->setObjectName(QString::fromUtf8("actionOctaveDown"));
        actionOctaveDown->setShortcut(QString::fromUtf8("Left"));
        actionTransposeUp = new QAction(VPiano);
        actionTransposeUp->setObjectName(QString::fromUtf8("actionTransposeUp"));
        actionTransposeUp->setShortcut(QString::fromUtf8("Ctrl+Right"));
        actionTransposeDown = new QAction(VPiano);
        actionTransposeDown->setObjectName(QString::fromUtf8("actionTransposeDown"));
        actionTransposeDown->setShortcut(QString::fromUtf8("Ctrl+Left"));
        actionChannelUp = new QAction(VPiano);
        actionChannelUp->setObjectName(QString::fromUtf8("actionChannelUp"));
        actionChannelUp->setShortcut(QString::fromUtf8("Up"));
        actionChannelDown = new QAction(VPiano);
        actionChannelDown->setObjectName(QString::fromUtf8("actionChannelDown"));
        actionChannelDown->setShortcut(QString::fromUtf8("Down"));
        actionNextController = new QAction(VPiano);
        actionNextController->setObjectName(QString::fromUtf8("actionNextController"));
        actionNextController->setShortcut(QString::fromUtf8("Ctrl++"));
        actionPreviousController = new QAction(VPiano);
        actionPreviousController->setObjectName(QString::fromUtf8("actionPreviousController"));
        actionPreviousController->setShortcut(QString::fromUtf8("Ctrl+-"));
        actionControllerUp = new QAction(VPiano);
        actionControllerUp->setObjectName(QString::fromUtf8("actionControllerUp"));
        actionControllerUp->setShortcut(QString::fromUtf8("+"));
        actionControllerDown = new QAction(VPiano);
        actionControllerDown->setObjectName(QString::fromUtf8("actionControllerDown"));
        actionControllerDown->setShortcut(QString::fromUtf8("-"));
        actionNextBank = new QAction(VPiano);
        actionNextBank->setObjectName(QString::fromUtf8("actionNextBank"));
        actionNextBank->setShortcut(QString::fromUtf8("Ctrl+PgUp"));
        actionPreviousBank = new QAction(VPiano);
        actionPreviousBank->setObjectName(QString::fromUtf8("actionPreviousBank"));
        actionPreviousBank->setShortcut(QString::fromUtf8("Ctrl+PgDown"));
        actionNextProgram = new QAction(VPiano);
        actionNextProgram->setObjectName(QString::fromUtf8("actionNextProgram"));
        actionNextProgram->setShortcut(QString::fromUtf8("PgUp"));
        actionPreviousProgram = new QAction(VPiano);
        actionPreviousProgram->setObjectName(QString::fromUtf8("actionPreviousProgram"));
        actionPreviousProgram->setShortcut(QString::fromUtf8("PgDown"));
        actionVelocityUp = new QAction(VPiano);
        actionVelocityUp->setObjectName(QString::fromUtf8("actionVelocityUp"));
        actionVelocityUp->setShortcut(QString::fromUtf8("End"));
        actionVelocityDown = new QAction(VPiano);
        actionVelocityDown->setObjectName(QString::fromUtf8("actionVelocityDown"));
        actionVelocityDown->setShortcut(QString::fromUtf8("Home"));
        actionAboutTranslation = new QAction(VPiano);
        actionAboutTranslation->setObjectName(QString::fromUtf8("actionAboutTranslation"));
        actionKeyboardInput = new QAction(VPiano);
        actionKeyboardInput->setObjectName(QString::fromUtf8("actionKeyboardInput"));
        actionKeyboardInput->setCheckable(true);
        actionKeyboardInput->setChecked(true);
        actionMouseInput = new QAction(VPiano);
        actionMouseInput->setObjectName(QString::fromUtf8("actionMouseInput"));
        actionMouseInput->setCheckable(true);
        actionMouseInput->setChecked(true);
        actionTouchScreenInput = new QAction(VPiano);
        actionTouchScreenInput->setObjectName(QString::fromUtf8("actionTouchScreenInput"));
        actionTouchScreenInput->setCheckable(true);
        actionTouchScreenInput->setChecked(true);
        actionColorPalette = new QAction(VPiano);
        actionColorPalette->setObjectName(QString::fromUtf8("actionColorPalette"));
        actionColorScale = new QAction(VPiano);
        actionColorScale->setObjectName(QString::fromUtf8("actionColorScale"));
        actionColorScale->setCheckable(true);
        centralwidget = new QWidget(VPiano);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
        gridLayout = new QGridLayout(centralwidget);
        gridLayout->setContentsMargins(0, 0, 0, 0);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        pianokeybd = new PianoKeybd(centralwidget);
        pianokeybd->setObjectName(QString::fromUtf8("pianokeybd"));

        gridLayout->addWidget(pianokeybd, 0, 0, 1, 1);

        VPiano->setCentralWidget(centralwidget);
        menubar = new QMenuBar(VPiano);
        menubar->setObjectName(QString::fromUtf8("menubar"));
        menubar->setGeometry(QRect(0, 0, 567, 25));
        menuFile = new QMenu(menubar);
        menuFile->setObjectName(QString::fromUtf8("menuFile"));
        menuEdit = new QMenu(menubar);
        menuEdit->setObjectName(QString::fromUtf8("menuEdit"));
        menuHelp = new QMenu(menubar);
        menuHelp->setObjectName(QString::fromUtf8("menuHelp"));
        menuLanguage = new QMenu(menuHelp);
        menuLanguage->setObjectName(QString::fromUtf8("menuLanguage"));
        menuView = new QMenu(menubar);
        menuView->setObjectName(QString::fromUtf8("menuView"));
        menuTools = new QMenu(menubar);
        menuTools->setObjectName(QString::fromUtf8("menuTools"));
        menuNotes = new QMenu(menuTools);
        menuNotes->setObjectName(QString::fromUtf8("menuNotes"));
        menuControllers = new QMenu(menuTools);
        menuControllers->setObjectName(QString::fromUtf8("menuControllers"));
        menuPrograms = new QMenu(menuTools);
        menuPrograms->setObjectName(QString::fromUtf8("menuPrograms"));
        menuNote_Input = new QMenu(menuTools);
        menuNote_Input->setObjectName(QString::fromUtf8("menuNote_Input"));
        VPiano->setMenuBar(menubar);
        statusBar = new QStatusBar(VPiano);
        statusBar->setObjectName(QString::fromUtf8("statusBar"));
        statusBar->setSizeGripEnabled(true);
        VPiano->setStatusBar(statusBar);
        toolBarNotes = new QToolBar(VPiano);
        toolBarNotes->setObjectName(QString::fromUtf8("toolBarNotes"));
        QSizePolicy sizePolicy(QSizePolicy::Minimum, QSizePolicy::Fixed);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(toolBarNotes->sizePolicy().hasHeightForWidth());
        toolBarNotes->setSizePolicy(sizePolicy);
        toolBarNotes->setToolButtonStyle(Qt::ToolButtonTextOnly);
        VPiano->addToolBar(Qt::TopToolBarArea, toolBarNotes);
        toolBarControllers = new QToolBar(VPiano);
        toolBarControllers->setObjectName(QString::fromUtf8("toolBarControllers"));
        sizePolicy.setHeightForWidth(toolBarControllers->sizePolicy().hasHeightForWidth());
        toolBarControllers->setSizePolicy(sizePolicy);
        toolBarControllers->setToolButtonStyle(Qt::ToolButtonTextOnly);
        VPiano->addToolBar(Qt::TopToolBarArea, toolBarControllers);
        VPiano->insertToolBarBreak(toolBarControllers);
        toolBarBender = new QToolBar(VPiano);
        toolBarBender->setObjectName(QString::fromUtf8("toolBarBender"));
        sizePolicy.setHeightForWidth(toolBarBender->sizePolicy().hasHeightForWidth());
        toolBarBender->setSizePolicy(sizePolicy);
        toolBarBender->setToolButtonStyle(Qt::ToolButtonTextOnly);
        VPiano->addToolBar(Qt::TopToolBarArea, toolBarBender);
        VPiano->insertToolBarBreak(toolBarBender);
        toolBarPrograms = new QToolBar(VPiano);
        toolBarPrograms->setObjectName(QString::fromUtf8("toolBarPrograms"));
        sizePolicy.setHeightForWidth(toolBarPrograms->sizePolicy().hasHeightForWidth());
        toolBarPrograms->setSizePolicy(sizePolicy);
        toolBarPrograms->setToolButtonStyle(Qt::ToolButtonTextOnly);
        VPiano->addToolBar(Qt::TopToolBarArea, toolBarPrograms);
        VPiano->insertToolBarBreak(toolBarPrograms);
        toolBarExtra = new QToolBar(VPiano);
        toolBarExtra->setObjectName(QString::fromUtf8("toolBarExtra"));
        sizePolicy.setHeightForWidth(toolBarExtra->sizePolicy().hasHeightForWidth());
        toolBarExtra->setSizePolicy(sizePolicy);
        toolBarExtra->setToolButtonStyle(Qt::ToolButtonTextOnly);
        VPiano->addToolBar(Qt::TopToolBarArea, toolBarExtra);
        VPiano->insertToolBarBreak(toolBarExtra);

        menubar->addAction(menuFile->menuAction());
        menubar->addAction(menuEdit->menuAction());
        menubar->addAction(menuTools->menuAction());
        menubar->addAction(menuView->menuAction());
        menubar->addAction(menuHelp->menuAction());
        menuFile->addAction(actionImportSoundFont);
        menuFile->addSeparator();
        menuFile->addAction(actionExit);
        menuEdit->addAction(actionConnections);
        menuEdit->addAction(actionPreferences);
        menuEdit->addAction(actionEditKM);
        menuEdit->addAction(actionEditExtraControls);
        menuEdit->addAction(actionShortcuts);
        menuEdit->addAction(actionColorPalette);
        menuHelp->addAction(actionContents);
        menuHelp->addAction(actionWebSite);
        menuHelp->addAction(menuLanguage->menuAction());
        menuHelp->addSeparator();
        menuHelp->addAction(actionAbout);
        menuHelp->addAction(actionAboutTranslation);
        menuHelp->addAction(actionAboutQt);
        menuView->addAction(actionNotes);
        menuView->addAction(actionControllers);
        menuView->addAction(actionBender);
        menuView->addAction(actionPrograms);
        menuView->addAction(actionExtraControls);
        menuView->addSeparator();
        menuView->addAction(actionNoteNames);
        menuView->addAction(actionColorScale);
        menuView->addAction(actionStatusBar);
        menuTools->addAction(actionChannelUp);
        menuTools->addAction(actionChannelDown);
        menuTools->addAction(menuNotes->menuAction());
        menuTools->addAction(menuControllers->menuAction());
        menuTools->addAction(menuPrograms->menuAction());
        menuTools->addAction(menuNote_Input->menuAction());
        menuNotes->addAction(actionOctaveUp);
        menuNotes->addAction(actionOctaveDown);
        menuNotes->addAction(actionTransposeUp);
        menuNotes->addAction(actionTransposeDown);
        menuNotes->addAction(actionVelocityUp);
        menuNotes->addAction(actionVelocityDown);
        menuControllers->addAction(actionNextController);
        menuControllers->addAction(actionPreviousController);
        menuControllers->addAction(actionControllerUp);
        menuControllers->addAction(actionControllerDown);
        menuPrograms->addAction(actionNextBank);
        menuPrograms->addAction(actionPreviousBank);
        menuPrograms->addAction(actionNextProgram);
        menuPrograms->addAction(actionPreviousProgram);
        menuNote_Input->addAction(actionKeyboardInput);
        menuNote_Input->addAction(actionMouseInput);
        menuNote_Input->addAction(actionTouchScreenInput);
        toolBarNotes->addAction(actionPanic);
        toolBarNotes->addSeparator();
        toolBarControllers->addAction(actionResetAll);
        toolBarControllers->addSeparator();
        toolBarBender->addAction(actionReset);
        toolBarBender->addSeparator();
        toolBarPrograms->addAction(actionEditPrograms);
        toolBarExtra->addAction(actionEditExtra);
        toolBarExtra->addSeparator();

        retranslateUi(VPiano);
        QObject::connect(actionExit, SIGNAL(triggered()), VPiano, SLOT(close()));
        QObject::connect(actionNotes, SIGNAL(toggled(bool)), toolBarNotes, SLOT(setVisible(bool)));
        QObject::connect(actionControllers, SIGNAL(toggled(bool)), toolBarControllers, SLOT(setVisible(bool)));
        QObject::connect(actionBender, SIGNAL(toggled(bool)), toolBarBender, SLOT(setVisible(bool)));
        QObject::connect(actionPrograms, SIGNAL(toggled(bool)), toolBarPrograms, SLOT(setVisible(bool)));
        QObject::connect(actionStatusBar, SIGNAL(toggled(bool)), statusBar, SLOT(setVisible(bool)));
        QObject::connect(actionExtraControls, SIGNAL(toggled(bool)), toolBarExtra, SLOT(setVisible(bool)));

        QMetaObject::connectSlotsByName(VPiano);
    } // setupUi

    void retranslateUi(QMainWindow *VPiano)
    {
        actionExit->setText(QApplication::translate("VPiano", "&Quit", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionExit->setStatusTip(QApplication::translate("VPiano", "Exit the program", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionPreferences->setText(QApplication::translate("VPiano", "&Preferences", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionPreferences->setStatusTip(QApplication::translate("VPiano", "Edit the program settings", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionConnections->setText(QApplication::translate("VPiano", "MIDI &Connections", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionConnections->setStatusTip(QApplication::translate("VPiano", "Edit the MIDI connections", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionAbout->setText(QApplication::translate("VPiano", "&About", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionAbout->setStatusTip(QApplication::translate("VPiano", "Show the About box", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionAboutQt->setText(QApplication::translate("VPiano", "About &Qt", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionAboutQt->setStatusTip(QApplication::translate("VPiano", "Show the Qt about box", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionNotes->setText(QApplication::translate("VPiano", "&Notes", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionNotes->setStatusTip(QApplication::translate("VPiano", "Show or hide the Notes toolbar", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionControllers->setText(QApplication::translate("VPiano", "&Controllers", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionControllers->setStatusTip(QApplication::translate("VPiano", "Show or hide the Controller toolbar", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionBender->setText(QApplication::translate("VPiano", "Pitch &Bender", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionBender->setStatusTip(QApplication::translate("VPiano", "Show or hide the Pitch Bender toolbar", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionPrograms->setText(QApplication::translate("VPiano", "&Programs", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionPrograms->setStatusTip(QApplication::translate("VPiano", "Show or hide the Programs toolbar", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionStatusBar->setText(QApplication::translate("VPiano", "&Status Bar", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionStatusBar->setStatusTip(QApplication::translate("VPiano", "Show or hide the Status Bar", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionPanic->setText(QApplication::translate("VPiano", "Panic", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionPanic->setStatusTip(QApplication::translate("VPiano", "Stops all active notes", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionResetAll->setText(QApplication::translate("VPiano", "Reset All", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionResetAll->setStatusTip(QApplication::translate("VPiano", "Resets all the controllers", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionReset->setText(QApplication::translate("VPiano", "Reset", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionReset->setStatusTip(QApplication::translate("VPiano", "Resets the Bender value", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionEditKM->setText(QApplication::translate("VPiano", "&Keyboard Map", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionEditKM->setStatusTip(QApplication::translate("VPiano", "Edit the current keyboard layout", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionContents->setText(QApplication::translate("VPiano", "&Contents", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionContents->setStatusTip(QApplication::translate("VPiano", "Open the index of the help document", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionWebSite->setText(QApplication::translate("VPiano", "VMPK &Web site", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionWebSite->setStatusTip(QApplication::translate("VPiano", "Open the VMPK web site address using a web browser", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionImportSoundFont->setText(QApplication::translate("VPiano", "&Import SoundFont...", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionImportSoundFont->setStatusTip(QApplication::translate("VPiano", "Import SoundFont", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionExtraControls->setText(QApplication::translate("VPiano", "&Extra Controls", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionExtraControls->setStatusTip(QApplication::translate("VPiano", "Show or hide the Extra Controls toolbar", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionEditExtra->setText(QApplication::translate("VPiano", "Edit", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionEditExtra->setStatusTip(QApplication::translate("VPiano", "Open the Extra Controls editor", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionEditPrograms->setText(QApplication::translate("VPiano", "Edit", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionEditPrograms->setStatusTip(QApplication::translate("VPiano", "Open the Banks/Programs editor", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionEditExtraControls->setText(QApplication::translate("VPiano", "&Extra Controllers", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionEditExtraControls->setStatusTip(QApplication::translate("VPiano", "Open the Extra Controls editor", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionNoteNames->setText(QApplication::translate("VPiano", "N&ote Names", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionNoteNames->setStatusTip(QApplication::translate("VPiano", "Show or hide the note names", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionShortcuts->setText(QApplication::translate("VPiano", "&Shortcuts", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionShortcuts->setStatusTip(QApplication::translate("VPiano", "Open the Shortcuts editor", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionOctaveUp->setText(QApplication::translate("VPiano", "Octave Up", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionOctaveUp->setStatusTip(QApplication::translate("VPiano", "Play one octave higher", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionOctaveDown->setText(QApplication::translate("VPiano", "Octave Down", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionOctaveDown->setStatusTip(QApplication::translate("VPiano", "Play one octave lower", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionTransposeUp->setText(QApplication::translate("VPiano", "Transpose Up", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionTransposeUp->setStatusTip(QApplication::translate("VPiano", "Transpose one semitone higher", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionTransposeDown->setText(QApplication::translate("VPiano", "Transpose Down", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionTransposeDown->setStatusTip(QApplication::translate("VPiano", "Transpose one semitone lower", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionChannelUp->setText(QApplication::translate("VPiano", "Next  Channel", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionChannelUp->setStatusTip(QApplication::translate("VPiano", "Play and listen next channel", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionChannelDown->setText(QApplication::translate("VPiano", "Previous Channel", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionChannelDown->setStatusTip(QApplication::translate("VPiano", "Play and listen previous channel", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionNextController->setText(QApplication::translate("VPiano", "Next Controller", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionNextController->setStatusTip(QApplication::translate("VPiano", "Select the next controller", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionPreviousController->setText(QApplication::translate("VPiano", "Previous Controller", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionPreviousController->setStatusTip(QApplication::translate("VPiano", "Select the previous controller", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionControllerUp->setText(QApplication::translate("VPiano", "Controller Up", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionControllerUp->setStatusTip(QApplication::translate("VPiano", "Increment the controller value", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionControllerDown->setText(QApplication::translate("VPiano", "Controller Down", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionControllerDown->setStatusTip(QApplication::translate("VPiano", "Decrement the controller value", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionNextBank->setText(QApplication::translate("VPiano", "Next Bank", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionNextBank->setStatusTip(QApplication::translate("VPiano", "Select the next instrument bank", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionPreviousBank->setText(QApplication::translate("VPiano", "Previous Bank", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionPreviousBank->setStatusTip(QApplication::translate("VPiano", "Select the previous instrument bank", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionNextProgram->setText(QApplication::translate("VPiano", "Next Program", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionNextProgram->setStatusTip(QApplication::translate("VPiano", "Select the next instrument program", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionPreviousProgram->setText(QApplication::translate("VPiano", "Previous Program", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionPreviousProgram->setStatusTip(QApplication::translate("VPiano", "Select the previous instrument program", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionVelocityUp->setText(QApplication::translate("VPiano", "Velocity Up", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionVelocityUp->setStatusTip(QApplication::translate("VPiano", "Increment note velocity", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionVelocityDown->setText(QApplication::translate("VPiano", "Velocity Down", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionVelocityDown->setStatusTip(QApplication::translate("VPiano", "Decrement note velocity", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionAboutTranslation->setText(QApplication::translate("VPiano", "About &Translation", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionAboutTranslation->setStatusTip(QApplication::translate("VPiano", "Show information about the program language translation", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionKeyboardInput->setText(QApplication::translate("VPiano", "Computer Keyboard", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionKeyboardInput->setStatusTip(QApplication::translate("VPiano", "Enable computer keyboard triggered note input", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionMouseInput->setText(QApplication::translate("VPiano", "Mouse", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionMouseInput->setStatusTip(QApplication::translate("VPiano", "Enable mouse triggered note input", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionTouchScreenInput->setText(QApplication::translate("VPiano", "Touch Screen", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionTouchScreenInput->setStatusTip(QApplication::translate("VPiano", "Enable screen touch triggered note input", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionColorPalette->setText(QApplication::translate("VPiano", "Color Palette", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionColorPalette->setStatusTip(QApplication::translate("VPiano", "Open the color palette editor", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        actionColorScale->setText(QApplication::translate("VPiano", "Color Scale", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_STATUSTIP
        actionColorScale->setStatusTip(QApplication::translate("VPiano", "Show or hide the colorized keys", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_STATUSTIP
        menuFile->setTitle(QApplication::translate("VPiano", "&File", 0, QApplication::UnicodeUTF8));
        menuEdit->setTitle(QApplication::translate("VPiano", "&Edit", 0, QApplication::UnicodeUTF8));
        menuHelp->setTitle(QApplication::translate("VPiano", "&Help", 0, QApplication::UnicodeUTF8));
        menuLanguage->setTitle(QApplication::translate("VPiano", "&Language", 0, QApplication::UnicodeUTF8));
        menuView->setTitle(QApplication::translate("VPiano", "&View", 0, QApplication::UnicodeUTF8));
        menuTools->setTitle(QApplication::translate("VPiano", "&Tools", 0, QApplication::UnicodeUTF8));
        menuNotes->setTitle(QApplication::translate("VPiano", "Notes", 0, QApplication::UnicodeUTF8));
        menuControllers->setTitle(QApplication::translate("VPiano", "Controllers", 0, QApplication::UnicodeUTF8));
        menuPrograms->setTitle(QApplication::translate("VPiano", "Programs", 0, QApplication::UnicodeUTF8));
        menuNote_Input->setTitle(QApplication::translate("VPiano", "Note Input", 0, QApplication::UnicodeUTF8));
        toolBarNotes->setWindowTitle(QApplication::translate("VPiano", "&Notes", 0, QApplication::UnicodeUTF8));
        toolBarControllers->setWindowTitle(QApplication::translate("VPiano", "&Controllers", 0, QApplication::UnicodeUTF8));
        toolBarBender->setWindowTitle(QApplication::translate("VPiano", "Pitch &Bender", 0, QApplication::UnicodeUTF8));
        toolBarPrograms->setWindowTitle(QApplication::translate("VPiano", "&Programs", 0, QApplication::UnicodeUTF8));
        toolBarExtra->setWindowTitle(QApplication::translate("VPiano", "&Extra Controls", 0, QApplication::UnicodeUTF8));
        Q_UNUSED(VPiano);
    } // retranslateUi

};

namespace Ui {
    class VPiano: public Ui_VPiano {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_VPIANO_H
