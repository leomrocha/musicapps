//******************************************************************************
//
// MIDITrail / MTGraphicCfgDlg
//
// グラフィック設定ダイアログクラス
//
// Copyright (C) 2010 WADA Masashi. All Rights Reserved.
//
//******************************************************************************

#pragma once

#include "YNBaseLib.h"
#include "DXRenderer.h"

using namespace YNBaseLib;


//******************************************************************************
// グラフィック設定定義
//******************************************************************************
//アンチエイリアシング：マルチサンプル種別デフォルト
#define MT_GRAPHIC_MULTI_SAMPLE_TYPE_DEF  (0)  //OFF


//******************************************************************************
// グラフィック設定ダイアログクラス
//******************************************************************************
class MTGraphicCfgDlg
{
public:

	//コンストラクタ／デストラクタ
	MTGraphicCfgDlg(void);
	virtual ~MTGraphicCfgDlg(void);

	//アンチエイリアシングサポート情報設定
	void SetAntialiasSupport(unsigned long multiSampleType, bool isSupport);

	//表示：ダイアログが閉じられるまで制御を返さない
	int Show(HWND hParentWnd);

	//パラメータ変更確認
	bool IsCahnged();

private:

	//ウィンドウプロシージャ制御用ポインタ
	static MTGraphicCfgDlg* m_pThis;

	//アプリケーションインスタンス
	HINSTANCE m_hInstance;

	//設定ファイル
	YNConfFile m_ConfFile;

	//コンボボックスのウィンドウハンドル
	HWND m_hComboMultiSampleType;
	bool m_MultSampleTypeSupport[DX_MULTI_SAMPLE_TYPE_MAX+1];

	//アンチエイリアシング設定
	unsigned long m_MultiSampleType;

	//更新フラグ
	bool m_isCahnged;

	//ウィンドウプロシージャ
	static INT_PTR CALLBACK _WndProc(HWND, UINT, WPARAM, LPARAM);
	INT_PTR _WndProcImpl(const HWND hWnd, const UINT message, const WPARAM wParam, const LPARAM lParam);

	//ダイアログ表示直前初期化
	int _OnInitDlg(HWND hDlg);

	//設定ファイル初期化
	int _InitConfFile();

	//設定ファイル読み込み
	int _LoadConf();

	//デバイス選択コンボボックス初期化
	int _InitComboMultiSampleType(HWND hCombo, unsigned long selMultiSampleType);

	//保存処理
	int _Save();

};


