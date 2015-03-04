//******************************************************************************
//
// MIDITrail / MTGraphicCfgDlg
//
// �O���t�B�b�N�ݒ�_�C�A���O�N���X
//
// Copyright (C) 2010 WADA Masashi. All Rights Reserved.
//
//******************************************************************************

#pragma once

#include "YNBaseLib.h"
#include "DXRenderer.h"

using namespace YNBaseLib;


//******************************************************************************
// �O���t�B�b�N�ݒ��`
//******************************************************************************
//�A���`�G�C���A�V���O�F�}���`�T���v����ʃf�t�H���g
#define MT_GRAPHIC_MULTI_SAMPLE_TYPE_DEF  (0)  //OFF


//******************************************************************************
// �O���t�B�b�N�ݒ�_�C�A���O�N���X
//******************************************************************************
class MTGraphicCfgDlg
{
public:

	//�R���X�g���N�^�^�f�X�g���N�^
	MTGraphicCfgDlg(void);
	virtual ~MTGraphicCfgDlg(void);

	//�A���`�G�C���A�V���O�T�|�[�g���ݒ�
	void SetAntialiasSupport(unsigned long multiSampleType, bool isSupport);

	//�\���F�_�C�A���O��������܂Ő����Ԃ��Ȃ�
	int Show(HWND hParentWnd);

	//�p�����[�^�ύX�m�F
	bool IsCahnged();

private:

	//�E�B���h�E�v���V�[�W������p�|�C���^
	static MTGraphicCfgDlg* m_pThis;

	//�A�v���P�[�V�����C���X�^���X
	HINSTANCE m_hInstance;

	//�ݒ�t�@�C��
	YNConfFile m_ConfFile;

	//�R���{�{�b�N�X�̃E�B���h�E�n���h��
	HWND m_hComboMultiSampleType;
	bool m_MultSampleTypeSupport[DX_MULTI_SAMPLE_TYPE_MAX+1];

	//�A���`�G�C���A�V���O�ݒ�
	unsigned long m_MultiSampleType;

	//�X�V�t���O
	bool m_isCahnged;

	//�E�B���h�E�v���V�[�W��
	static INT_PTR CALLBACK _WndProc(HWND, UINT, WPARAM, LPARAM);
	INT_PTR _WndProcImpl(const HWND hWnd, const UINT message, const WPARAM wParam, const LPARAM lParam);

	//�_�C�A���O�\�����O������
	int _OnInitDlg(HWND hDlg);

	//�ݒ�t�@�C��������
	int _InitConfFile();

	//�ݒ�t�@�C���ǂݍ���
	int _LoadConf();

	//�f�o�C�X�I���R���{�{�b�N�X������
	int _InitComboMultiSampleType(HWND hCombo, unsigned long selMultiSampleType);

	//�ۑ�����
	int _Save();

};

