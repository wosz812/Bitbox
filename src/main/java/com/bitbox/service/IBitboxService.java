package com.bitbox.service;

import java.util.ArrayList;
import java.util.List;

import com.bitbox.dto.CalendarFormat;
import com.bitbox.dto.GMemoDTO;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.dto.StudentDTO;

public interface IBitboxService {

	public List<PBoardDTO> listAll(String id);

	public boolean regist(PBoardDTO board);

	public boolean studentRegist(StudentDTO student);

	public StudentDTO loginCheck(StudentDTO student);

	public List<CalendarFormat> getCalendar(String id);

	public StudentDTO searchInfo(StudentDTO dto, int type);

	public List<PBoardDTO> listAll();

	boolean projectUpdate(PBoardDTO board);

	int groupJoin(GroupDTO group, GinDTO gIn);

	GroupDTO getGroupModal(String gNo);

	List<GroupDTO> getGroupList();

	public boolean groupRegist(GroupDTO dto);

	public boolean registPMemo(PMemoDTO dto);
	
	public boolean registGMemo(GMemoDTO dto);

	public List<PMemoDTO> getPMemoList(String id,int page);
	
	public List<GMemoDTO> getGMemoList(int group_seq, int page);

	public ArrayList<String> getPageList(int page, String id);

	public boolean projectDelete(PBoardDTO board);
	
	public List<GroupDTO> getGroupList(String s_id);

	public ArrayList<String> getGPageList(int page, int group_seq);

	
}
