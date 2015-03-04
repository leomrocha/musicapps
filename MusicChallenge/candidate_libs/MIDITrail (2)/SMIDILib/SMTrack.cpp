//******************************************************************************
//
// Simple MIDI Library / SMTrack
//
// �g���b�N�N���X
//
// Copyright (C) 2010 WADA Masashi. All Rights Reserved.
//
//******************************************************************************

#include "StdAfx.h"
#include "YNBaseLib.h"
#include "SMCommon.h"
#include "SMTrack.h"
#include "SMEventMIDI.h"
#include "SMEventMeta.h"
#include "SMFPUCtrl.h"

using namespace YNBaseLib;

namespace SMIDILib {


//******************************************************************************
// �R���X�g���N�^
//******************************************************************************
SMTrack::SMTrack(void)
 : m_List(sizeof(SMDataSet), 1000)
{
}

//******************************************************************************
// �f�X�g���N�^
//******************************************************************************
SMTrack::~SMTrack(void)
{
	Clear();
}

//******************************************************************************
// �f�[�^�N���A
//******************************************************************************
void SMTrack::Clear()
{
	SMExDataMap::iterator exdataitr;

	m_List.Clear();

	for (exdataitr = m_ExDataMap.begin(); exdataitr != m_ExDataMap.end(); exdataitr++) {
		delete [] (exdataitr->second);
	}
	m_ExDataMap.clear();

	return;
}

//******************************************************************************
// �f�[�^�Z�b�g�ǉ�
//******************************************************************************
int SMTrack::AddDataSet(
		unsigned long deltaTime,
		SMEvent* pEvent,
		unsigned char portNo
	)
{
	int result = 0;
	unsigned long index = 0;
	unsigned char* pExData = NULL;
	SMDataSet dataSet;

	index = m_List.GetSize();

	//�f�[�^�Z�b�g�쐬
	ZeroMemory(&dataSet, sizeof(SMDataSet));
	dataSet.deltaTime = deltaTime;
	dataSet.eventData.type   = pEvent->GetType();
	dataSet.eventData.status = pEvent->GetStatus();
	dataSet.eventData.meta   = pEvent->GetMetaType();
	dataSet.eventData.size   = pEvent->GetDataSize();
	dataSet.portNo = portNo;

	//�C�x���g�f�[�^��4byte�ȓ��Ȃ�\���̓��Ɋi�[����
	if (pEvent->GetDataSize() <= 4) {
		memcpy(&(dataSet.eventData.data), pEvent->GetDataPtr(), pEvent->GetDataSize());
	}
	//����ȊO�͕ʓr�q�[�v�ɕێ����ă}�b�v�ŊǗ�����
	else {
		try {
			pExData = new unsigned char[pEvent->GetDataSize()];
		}
		catch (std::bad_alloc) {
			result = YN_SET_ERR("Could not allocate memory.", pEvent->GetDataSize(), 0);
			goto EXIT;
		}
		memcpy(pExData, pEvent->GetDataPtr(), pEvent->GetDataSize());
		m_ExDataMap.insert(SMExDataMapPair(index, pExData));
		pExData = NULL;
	}

	result = m_List.AddItem(&dataSet);
	if (result != 0) goto EXIT;

EXIT:;
	delete [] pExData;
	return result;
}

//******************************************************************************
// �f�[�^�Z�b�g�擾
//******************************************************************************
int SMTrack::GetDataSet(
		unsigned long index,
		unsigned long* pDeltaTime,
		SMEvent* pEvent,
		unsigned char* pProtNo
	)
{
	int result = 0;
	unsigned char* pEventData = NULL;
	SMDataSet dataSet;
	SMExDataMap::iterator exdataitr;

	result = m_List.GetItem(index, &dataSet);
	if (result != 0) goto EXIT;

	//�f���^�^�C��
	if (pDeltaTime != NULL) {
		*pDeltaTime = dataSet.deltaTime;
	}

	//�C�x���g�f�[�^�ʒu
	if (dataSet.eventData.size <= 4) {
		pEventData = dataSet.eventData.data;
	}
	else {
		exdataitr = m_ExDataMap.find(index);
		if (exdataitr == m_ExDataMap.end()) {
			result = YN_SET_ERR("Program error.", index, 0);
			goto EXIT;
		}
		pEventData = exdataitr->second;
	}

	//�C�x���g�f�[�^�o�^
	if (pEvent != NULL) {
		result = pEvent->SetData(
						dataSet.eventData.type,
						dataSet.eventData.status,
						dataSet.eventData.meta,
						pEventData,
						dataSet.eventData.size
					);
		if (result != 0) goto EXIT;
	}

	//�|�[�g�ԍ�
	if (pProtNo != NULL) {
		*pProtNo = dataSet.portNo;
	}

EXIT:;
	return result;
}

//******************************************************************************
// �R�s�[
//******************************************************************************
unsigned long SMTrack::GetSize()
{
	return m_List.GetSize();
}

//******************************************************************************
// �R�s�[
//******************************************************************************
int SMTrack::CopyFrom(
		SMTrack* pSrcTrack
	)
{
	int result = 0;
	unsigned long index = 0;
	unsigned long deltaTime = 0;
	SMEvent event;
	unsigned char portNo = 0;

	//TODO: ���������C���e���W�F���g�ȃR�s�[�ɂ���

	if (pSrcTrack == NULL) {
		result = YN_SET_ERR("Program error.", 0, 0);
		goto EXIT;
	}

	//�������g���R�s�[���Ȃ牽�����Ȃ�
	if (pSrcTrack == this) {
		goto EXIT;
	}

	Clear();

	for (index = 0; index < pSrcTrack->GetSize(); index++) {
		result = pSrcTrack->GetDataSet(index, &deltaTime, &event, &portNo);
		if (result != 0) goto EXIT;

		result = AddDataSet(deltaTime, &event, portNo);
		if (result != 0) goto EXIT;
	}

EXIT:;
	return result;
}

//******************************************************************************
// �m�[�g���X�g�擾
//******************************************************************************
int SMTrack::GetNoteList(
		SMNoteList* pNoteList
	)
{
	int result = 0;

	result = _GetNoteList(pNoteList, 0);
	if (result != 0) goto EXIT;

EXIT:;
	return result;
}

//******************************************************************************
// �m�[�g���X�g�擾
//******************************************************************************
int SMTrack::GetNoteListWithRealTime(
		SMNoteList* pNoteList,
		unsigned long timeDivision
	)
{
	int result = 0;

	if (timeDivision == 0) {
		result = YN_SET_ERR("Program error.", 0, 0);
		goto EXIT;
	}

	result = _GetNoteList(pNoteList, timeDivision);
	if (result != 0) goto EXIT;

EXIT:;
	return result;
}

//******************************************************************************
// �m�[�g���X�g�擾
//******************************************************************************
int SMTrack::_GetNoteList(
		SMNoteList* pNoteList,
		unsigned long timeDivision
	)
{
	int result = 0;
	unsigned long index = 0;
	unsigned long deltaTime = 0;
	unsigned long totalTime = 0;
	unsigned char portNo = 0;
	unsigned long key = 0;
	unsigned long tempo = SM_DEFAULT_TEMPO;
	double totalRealtime = 0;
	SMNoteMap noteMap;
	SMNoteMap::iterator itr;
	SMNote note;
	SMEvent event;
	SMEventMIDI midiEvent;
	SMEventMeta metaEvent;
	SMFPUCtrl fpuCtrl;

	// timeDivision  = 0 �̏ꍇ�FstartTime, endTime �̓`�b�N�^�C����ݒ�
	// timeDivision != 0 �̏ꍇ�FstartTime, endTime �̓��A���^�C����ݒ�(msec)

	if (pNoteList == NULL) {
		result = YN_SET_ERR("Program error.", 0, 0);
		goto EXIT;
	}

	//���������_���Z���x��{���x�ɐݒ�
	result = fpuCtrl.Start(SMFPUCtrl::FPUDouble);
	if (result != 0) goto EXIT;

	//�m�[�g���̓g���b�N�o�^���Ńm�[�g���X�g�ɒǉ�����
	//���Ȃ킿�m�[�g�J�n�`�b�N�^�C���Ń\�[�g�����悤�Ƀ��X�g���쐬����
	pNoteList->Clear();

	for (index = 0; index < GetSize(); index++) {

		result = GetDataSet(index, &deltaTime, &event, &portNo);
		if (result != 0) goto EXIT;

		totalTime += deltaTime;
		totalRealtime += _ConvTick2TimeMsec(deltaTime, tempo, timeDivision);

		//�e���|�̕ω����m�F
		if (event.GetType() == SMEvent::EventMeta) {
			metaEvent.Attach(&event);
			if (metaEvent.GetType() == 0x51) {
				tempo = metaEvent.GetTempo();
			}
		}

		//MIDI�C�x���g�ȊO�̓X�L�b�v
		if (event.GetType() != SMEvent::EventMIDI) continue;

		midiEvent.Attach(&event);

		//�m�[�g�I��
		if (midiEvent.GetChMsg() == SMEventMIDI::NoteOn) {
			//�}�b�v���瓖�Y�m�[�g������
			key = _GetNoteKey(portNo, midiEvent.GetChNo(), midiEvent.GetNoteNo());
			itr = noteMap.find(key);

			//���o�^�̏ꍇ
			if (itr == noteMap.end()) {
				note.portNo = portNo;
				note.chNo = midiEvent.GetChNo();
				note.noteNo = midiEvent.GetNoteNo();
				note.velocity = midiEvent.GetVelocity();
				note.startTime = ((timeDivision == 0) ? totalTime : (unsigned long)totalRealtime);
				note.endTime = 0;
			}
			//�o�^�ς݂̏ꍇ
			else {
				//����m�[�g�ԍ��Ńm�[�gOFF�Ȃ��Ƀm�[�gON���A�������ꍇ�ɑ�������
				//MIDI�̎d�l��ǂ����������ɂȂ邩�͕s��
				//�m�[�g����؂��ĐV�����m�[�g�̊J�n�Ƃ���
				result = pNoteList->GetNote(itr->second, &note);
				if (result != 0) goto EXIT;

				//�I���`�b�N�^�C�����L�^���ă��X�g�ɏ����߂�
				note.endTime = ((timeDivision == 0) ? totalTime : (unsigned long)totalRealtime);
				result = pNoteList->SetNote(itr->second, &note);
				if (result != 0) goto EXIT;

				noteMap.erase(itr);

				//�V�����m�[�g
				note.velocity = midiEvent.GetVelocity();
				note.startTime = ((timeDivision == 0) ? totalTime : (unsigned long)totalRealtime);
				note.endTime = 0;
			}
			//�I���`�b�N�^�C������̂܂܃m�[�g���X�g�ɓo�^����
			pNoteList->AddNote(note);
			//�m�[�g���X�g�̃C���f�b�N�X�ʒu���}�b�v�ɋL�^����
			noteMap.insert(SMNoteMapPair(key, (pNoteList->GetSize()-1)));
		}
		//�m�[�g�I�t
		if (midiEvent.GetChMsg() == SMEventMIDI::NoteOff) {
			//�}�b�v���瓖�Y�m�[�g������
			key = _GetNoteKey(portNo, midiEvent.GetChNo(), midiEvent.GetNoteNo());
			itr = noteMap.find(key);

			if (itr != noteMap.end()) {
				result = pNoteList->GetNote(itr->second, &note);
				if (result != 0) goto EXIT;

				//�I���`�b�N�^�C�����L�^���ă��X�g�ɏ����߂�
				note.endTime = ((timeDivision == 0) ? totalTime : (unsigned long)totalRealtime);
				result = pNoteList->SetNote(itr->second, &note);
				if (result != 0) goto EXIT;

				noteMap.erase(itr);
			}
		}
	}

	//�m�[�g�I���̂܂܏I�������ꍇ�̓m�[�g����؂��ă��X�g�ɒǉ�����
	for (itr = noteMap.begin(); itr != noteMap.end(); itr++) {
		result = pNoteList->GetNote(itr->second, &note);
		if (result != 0) goto EXIT;

		note.endTime = ((timeDivision == 0) ? totalTime : (unsigned long)totalRealtime);
		result = pNoteList->SetNote(itr->second, &note);
		if (result != 0) goto EXIT;
	}

	result = fpuCtrl.End();
	if (result != 0) goto EXIT;

EXIT:;
	return result;
}

//******************************************************************************
// �`�b�N�^�C����������Ԃւ̕ϊ��i�~���b�j
//******************************************************************************
double SMTrack::_ConvTick2TimeMsec(
		unsigned long tickTime,
		unsigned long tempo,
		unsigned long timeDivision
	)
{
	double timeMsec = 0;

	//(1) �l������������̕���\ division
	//    ��F48
	//(2) �g���b�N�f�[�^�̃f���^�^�C�� delta
	//    ����\�̒l��p���ĕ\�����鎞�ԍ�
	//    ����\��48�Ńf���^�^�C����24�Ȃ甪���������̎��ԍ�
	//(3) �e���|�ݒ�i�}�C�N���b�j tempo
	//    �l�������̎����ԊԊu
	//
	// �f���^�^�C���ɑΉ���������ԊԊu�i�~���b�j
	//  = (delta / division) * tempo / 1000
	//  = (delta * tempo) / (division * 1000)

	timeMsec = ((double)tickTime * (double)tempo) / (1000.0 * (double)timeDivision);

	return timeMsec;
}

//******************************************************************************
// �m�[�g����L�[�擾
//******************************************************************************
unsigned long SMTrack::_GetNoteKey(
		unsigned char portNo,
		unsigned char chNo,
		unsigned char noteNo
	)
{
	return ((portNo << 16) | (chNo << 8) | noteNo);
}

} // end of namespace
