package com.bitbox.dao;

import java.util.List;

import com.bitbox.dto.GMemoDTO;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.dto.StudentDTO;

public interface IBitboxDAO {
	public List<PBoardDTO> listAll(String id);
	public boolean regist(PBoardDTO board);
	public boolean studentRegist(StudentDTO student);
	public StudentDTO loginCheck(StudentDTO student);
	public List<PBoardDTO> getCalendar(String id);
	public StudentDTO search(StudentDTO dto, int type);
	public List<PBoardDTO> listAll();
	boolean projectUpdate(PBoardDTO board);
	List<GroupDTO> groupList();
	GroupDTO groupModal(String gNo);
	GroupDTO getGroup(int seq);
	boolean groupIn(GinDTO gin);
	GinDTO selectGin(GinDTO gIn);
	public boolean groupRegist(GroupDTO dto);
	public boolean registPMemo(PMemoDTO dto);
	public boolean registGMemo(GMemoDTO dto);
	public List<PMemoDTO> getPMemoList(String id,int start);
	public List<GMemoDTO> getGMemoList(int group_seq, int start);
	public int PMemoCnt(String id);
	public boolean projectDelete(PBoardDTO board);
	public List<GroupDTO> getGroupList(String s_id);
<<<<<<< HEAD
	public int getPBoardCnt();
=======
	public int GMemoCnt(int group_seq);
	public boolean removePMemo(int m_seq);
	public boolean updatePMemo(PMemoDTO pmemo);
	public PMemoDTO getPMemoModal(int seq);
	public boolean updateGMemo(GMemoDTO gmemo);
	public boolean removeGMemo(int seq);
	public GMemoDTO getGMemoModal(int seq);
>>>>>>> 73b941aa03a04ffbed73561cecf760d77232898d
}
