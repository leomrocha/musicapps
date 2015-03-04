//******************************************************************************
//
// MIDITrail / MTScenePianoRoll2D
//
// ピアノロール2Dシーン描画クラス
//
// Copyright (C) 2010 WADA Masashi. All Rights Reserved.
//
//******************************************************************************

#include "StdAfx.h"
#include "MTScenePianoRoll2D.h"


//******************************************************************************
// コンストラクタ
//******************************************************************************
MTScenePianoRoll2D::MTScenePianoRoll2D(void)
{
}

//******************************************************************************
// デストラクタ
//******************************************************************************
MTScenePianoRoll2D::~MTScenePianoRoll2D(void)
{
}

//******************************************************************************
// 名称取得
//******************************************************************************
const TCHAR* MTScenePianoRoll2D::GetName()
{
	return _T("PianoRoll2D");
}

//******************************************************************************
// シーン生成
//******************************************************************************
int MTScenePianoRoll2D::Create(
		HWND hWnd,
		LPDIRECT3DDEVICE9 pD3DDevice,
		SMSeqData* pSeqData
	)
{
	int result = 0;

	//ピアノロール2Dはライトなし
	//  ノートボックスの幅をゼロにするので表と裏が同一平面状で重なる
	//  ライトを有効にすると表と裏の色が異なりZファイティングを誘発する
	m_IsEnableLight = FALSE;

	result = MTScenePianoRoll3D::Create(hWnd, pD3DDevice, pSeqData);
	if (result != 0) goto EXIT;

EXIT:;
	return result;
}

