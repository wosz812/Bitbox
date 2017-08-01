package com.bitbox.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.bitbox.dto.CalendarFormat;
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

public interface IBitboxService {

	public List<PBoardDTO> listAll(String id);

	public boolean regist(PBoardDTO board);

	public boolean studentRegist(StudentDTO student);

	public StudentDTO login(String s_id);

	public String passwordCheck(String s_id);

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

	public List<PMemoDTO> getPMemoList(String id, int page);

	public List<GMemoDTO> getGMemoList(int group_seq, int page);

	public ArrayList<String> getPageList(int page, String id);

	public boolean projectDelete(PBoardDTO board);

	public List<GroupDTO> getGroupList(String s_id);

	public ArrayList<String> getGPageList(int page, int group_seq);

	public boolean removePMemo(int m_seq);

	public boolean updatePMemo(PMemoDTO pmemo);

	public PMemoDTO getPMemoModal(int seq);

	public boolean updateGMemo(GMemoDTO gmemo);

	public boolean removeGMemo(int seq);

	public GMemoDTO getGMemoModal(int seq);

	public int getCnt();

	public List<QnaDTO> getQnaList(int page);

	public boolean registQna(QnaDTO qna);

	public QnaDTO detailQna(int q_seq);

	public ArrayList<String> getQnaPageList(int page);

	public boolean qnaDelete(int q_seq);

	public boolean qnaUpdate(QnaDTO qna);

	public List<ReQnaDTO> getReplyList(int q_seq);

	public boolean registReply(ReQnaDTO reply);

	public PBoardDTO finduuidname(String p_boardseq);

	public StringBuffer readFile(MultipartFile file);

	public List<MinutesDTO> minutesList(int group_seq, int page);

	public ArrayList<String> getMember(int group_seq);

	public boolean registMinutes(MinutesDTO minutes);

	public MinutesDTO readMinutes(int seq);

	public ArrayList<String> getMinutesPageList(int group_seq, int page, String group_title);

	public boolean updateMinutes(MinutesDTO minutes);

	public boolean deleteMinutes(int min_seq);

	public String getReplyUser(String s_id);

	public String enter(String str);

	public boolean idCheck(String s_id);

	public boolean myUpdate(StudentDTO dto);

	public GanttDTO chart(int group_seq);

	public boolean saveGantt(GanttDTO gantt);

	public String getClassName(int s_class_code);

	public ArrayList<String> todoList(TodoDTO dto);

	public ArrayList<String> getTodoList(String id);

	public boolean deleteAll(String id);

	public boolean deleteLine(int seq);

	public boolean changePw(StudentDTO student);

	public StudentDTO getMasInfo(String title);

	public MinutesDTO getRecentMinutes(int group_seq);

	public String getGroupTitle(int group_seq);

}
