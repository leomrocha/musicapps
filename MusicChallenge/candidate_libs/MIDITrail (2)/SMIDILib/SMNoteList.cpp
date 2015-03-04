//******************************************************************************
//
// Simple MIDI Library / SMNoteList
//
// ノートリストクラス
//
// Copyright (C) 2010 WADA Masashi. All Rights Reserved.
//
//******************************************************************************

#include "StdAfx.h"
#include "YNBaseLib.h"
#include "SMNoteList.h"

using namespace YNBaseLib;

namespace SMIDILib {


//******************************************************************************
// コンストラクタ
//******************************************************************************
SMNoteList::SMNoteList(void)
 : m_List(sizeof(SMNote), 1000)
{
}

//******************************************************************************
// デストラクタ
//******************************************************************************
SMNoteList::~SMNoteList(void)
{
	Clear();
}

//******************************************************************************
// クリア
//******************************************************************************
void SMNoteList::Clear(void)
{
	m_List.Clear();
}

//******************************************************************************
// ノート情報追加
//******************************************************************************
int SMNoteList::AddNote(
		SMNote note
	)
{
	return m_List.AddItem(&note);
}

//******************************************************************************
// ノート情報取得
//******************************************************************************
int SMNoteList::GetNote(
		unsigned long index,
		SMNote* pNote
	)
{
	return m_List.GetItem(index, pNote);
}

//******************************************************************************
// ノート情報登録（上書き）
//******************************************************************************
int SMNoteList::SetNote(
		unsigned long index,
		SMNote* pNote
	)
{
	return m_List.SetItem(index, pNote);
}

//******************************************************************************
// ノート数取得
//******************************************************************************
unsigned long SMNoteList::GetSize()
{
	return m_List.GetSize();
}

//******************************************************************************
// リストコピー
//******************************************************************************
int SMNoteList::CopyFrom(
		SMNoteList* pSrcList
	)
{
	return m_List.CopyFrom(&(pSrcList->m_List));
}

} // end of namespace

