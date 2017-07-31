package com.bitbox.dao;

import java.util.List;

import com.bitbox.dto.GMemoDTO;
import com.bitbox.dto.GanttDTO;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.MinutesDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.dto.QnaDTO;
import com.bitbox.dto.ReQnaDTO;
import com.bitbox.dto.StudentDTO;
import com.bitbox.dto.TodoDTO;
import com.bitbox.dto.mPageDTO;

public interface IBitboxDAO {
	public StudentDTO idCheck(String s_id);
	public List<PBoardDTO> listAll(String id);
	public boolean regist(PBoardDTO board);
	public boolean studentRegist(StudentDTO student);
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
	public int getPBoardCnt();
	public int GMemoCnt(int group_seq);
	public boolean removePMemo(int m_seq);
	public boolean updatePMemo(PMemoDTO pmemo);
	public PMemoDTO getPMemoModal(int seq);
	public boolean updateGMemo(GMemoDTO gmemo);
	public boolean removeGMemo(int seq);
	public GMemoDTO getGMemoModal(int seq);
	public int getCnt();
	public List<QnaDTO> getQnaList(int start);
	public boolean registQna(QnaDTO qna);
	public QnaDTO detailQna(int q_seq);
	public int qnaCnt();
	public boolean qnaDelete(int q_seq);
	public boolean qnaUpdate(QnaDTO qna);
	public List<ReQnaDTO> getReplyList(int q_seq);
	public boolean registReply(ReQnaDTO reply);
	public PBoardDTO finduuidname(String p_boardseq);
	public List<MinutesDTO> minutesList(mPageDTO mList);
	public List<String> getNameList(int group_seq);
	public boolean registMinutes(MinutesDTO minutes);
	public MinutesDTO readMinutes(int seq);
	public int mCnt(int group_seq);
	public boolean updateMinutes(MinutesDTO minutes);
	public boolean deleteMinutes(int min_seq);
	public boolean updateReadCount(int q_seq);
	public StudentDTO getReplyUser(String s_id);
	public String passwordCheck(String s_id);
	public StudentDTO login(String s_id);
	public boolean myUpdate(StudentDTO dto);
	public GanttDTO chart(int group_seq);
	public boolean saveGantt(GanttDTO gantt);
	public String getClassName(int s_class_code);
	public List<TodoDTO> todoList(TodoDTO dto);
	public List<TodoDTO> getTodoList(String id);
	public boolean deleteAll(String id);
	public boolean deleteLine(int seq);

	public StudentDTO getMasInfo(String title);


	public boolean gitMasterUpdate(GroupDTO dto);
	public GroupDTO selectMasId(GroupDTO dto);
	public MinutesDTO getRecentMinutes(int group_seq);
	public String getGroupTitle(int group_seq);
	public StudentDTO getMasInfo(String title);

}
