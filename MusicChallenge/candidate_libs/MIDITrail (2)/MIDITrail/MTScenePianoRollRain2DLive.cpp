//******************************************************************************
//
// MIDITrail / MTScenePianoRollRain2DLive
//
// ���C�u���j�^�p�s�A�m���[�����C��2D�V�[���`��N���X
//
// Copyright (C) 2013 WADA Masashi. All Rights Reserved.
//
//******************************************************************************

#include "StdAfx.h"
#include "MTScenePianoRollRain2DLive.h"


//******************************************************************************
// �R���X�g���N�^
//******************************************************************************
MTScenePianoRollRain2DLive::MTScenePianoRollRain2DLive(void)
{
}

//******************************************************************************
// �f�X�g���N�^
//******************************************************************************
MTScenePianoRollRain2DLive::~MTScenePianoRollRain2DLive(void)
{
}

//******************************************************************************
// ���̎擾
//******************************************************************************
const TCHAR* MTScenePianoRollRain2DLive::GetName()
{
	return _T("PianoRollRain2DLive");
}

//******************************************************************************
// �V�[������
//******************************************************************************
int MTScenePianoRollRain2DLive::Create(
		HWND hWnd,
		LPDIRECT3DDEVICE9 pD3DDevice,
		SMSeqData* pSeqData
	)
{
	int result = 0;

	//�s�A�m���[�����C��2D�̓V���O���L�[�{�[�h
	m_IsSingleKeyboard = true;

	result = MTScenePianoRollRainLive::Create(hWnd, pD3DDevice, pSeqData);
	if (result != 0) goto EXIT;
	
EXIT:;
	return result;
}

//******************************************************************************
// �f�t�H���g���_�擾
//******************************************************************************
void MTScenePianoRollRain2DLive::GetDefaultViewParam(
		MTViewParamMap* pParamMap
	)
{
	D3DXVECTOR3 viewPointVector;
	float phi, theta = 0.0f;
	
	//���_���쐬
	viewPointVector.x = 0.0f;
	viewPointVector.y = 0.34f * 16.0f / 2.0f;
	viewPointVector.z = - 10.0f;
	phi   = 90.0f;	//+Z������
	theta = 90.0f;	//+Z������
	
	pParamMap->clear();
	pParamMap->insert(MTViewParamMapPair("X", viewPointVector.x));
	pParamMap->insert(MTViewParamMapPair("Y", viewPointVector.y));
	pParamMap->insert(MTViewParamMapPair("Z", viewPointVector.z));
	pParamMap->insert(MTViewParamMapPair("Phi", phi));
	pParamMap->insert(MTViewParamMapPair("Theta", theta));
	pParamMap->insert(MTViewParamMapPair("ManualRollAngle", 0.0f));
	pParamMap->insert(MTViewParamMapPair("AutoRollVelocity", 0.0f));
	
	return;
}
