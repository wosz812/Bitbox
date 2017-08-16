package com.bitbox.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bitbox.dto.CClassDTO;
import com.bitbox.dto.GLogDTO;
import com.bitbox.dto.GMemoDTO;
import com.bitbox.dto.GanttDTO;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.MinutesDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.dto.PageDTO;
import com.bitbox.dto.QnaDTO;
import com.bitbox.dto.ReQnaDTO;
import com.bitbox.dto.StudentDTO;
import com.bitbox.dto.SubSubjectDTO;
import com.bitbox.dto.SubjectDateFormat;
import com.bitbox.dto.TodoDTO;
import com.bitbox.dto.gPageDTO;
import com.bitbox.dto.mPageDTO;

@Repository
public class BitboxDAO implements IBitboxDAO {

	@Autowired
	private SqlSession session;

	private static final String namespace = "com.bitbox.bitboxMapper";
	private static final String login = "com.bitbox.loginMapper";
	private static final String git = "com.bitbox.gitMapper";
	private static final Logger logger = LoggerFactory.getLogger(BitboxDAO.class);

	@Override
	public List<PBoardDTO> listAll(String id) {
		List<PBoardDTO> list = session.selectList(namespace + ".listAll", id);
		return list;
	}

	@Override
	public boolean regist(PBoardDTO board) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".regist", board);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean studentRegist(StudentDTO student) {
		boolean flag = false;
		System.out.println("DAO: " + student);
		int aCnt = session.insert(login + ".regist", student);
		if (aCnt > 0) {
			flag = true;
		}
		logger.info("flag", flag);
		return flag;
	}

	@Override
	public StudentDTO login(String s_id) {
		logger.info(s_id.toString());
		StudentDTO a = session.selectOne(login + ".login", s_id);
		return a;
	}

	@Override
	public List<PBoardDTO> getCalendar(String id) {
		logger.info(id);
		List<PBoardDTO> calendars = session.selectList(namespace + ".getCalendar", id);
		logger.info("data is", calendars.toString());
		return calendars;
	}

	@Override
	public StudentDTO search(StudentDTO dto, int type) {
		StudentDTO student = null;
		if (type == 0) {
			student = session.selectOne(login + ".searchId", dto);
		} else {
			student = session.selectOne(login + ".searchPw", dto);
		}
		return student;
	}

	@Override
	public List<PBoardDTO> listAll() {
		List<PBoardDTO> list = session.selectList(namespace + ".listAll");
		return list;
	}

	@Override
	public boolean projectUpdate(PBoardDTO board) {
		boolean flag = false;
		logger.info("DAO is " + board.getP_title() + "," + board.getP_content());
		int aCnt = session.update(namespace + ".projectUpdate", board);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public List<GroupDTO> groupList() {
		List<GroupDTO> list = session.selectList(namespace + ".getGroupList");
		return list;
	}

	@Override
	public GroupDTO groupModal(String gNo) {
		GroupDTO modal = session.selectOne(namespace + ".getGroupModal", gNo);
		return modal;
	}

	@Override
	public GroupDTO getGroup(int seq) {
		GroupDTO dto = session.selectOne(namespace + ".getGroup", seq);
		System.out.println("getGroup dao: " + dto);
		return dto;
	}

	@Override
	public boolean groupIn(GinDTO gin) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".groupIn", gin);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public GinDTO selectGin(GinDTO gIn) {
		System.out.println("dao ginDTO: " + gIn);
		GinDTO dto = session.selectOne(namespace + ".selectGin", gIn);
		System.out.println("selectGin dao: " + dto);
		return dto;
	}

	@Override
	public boolean groupRegist(GroupDTO dto) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".groupRegist", dto);
		if (aCnt > 0) {
			int bCnt = session.insert(namespace + ".ganttRegist", new GanttDTO(dto.getGroup_seq()));
			if (bCnt > 0) {
				flag = true;
			}
		}
		return flag;
	}

	@Override
	public boolean registPMemo(PMemoDTO dto) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".registPMemo", dto);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean registGMemo(GMemoDTO dto) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".registGMemo", dto);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public List<PMemoDTO> getPMemoList(String id, int start) {
		PageDTO dto = new PageDTO(id, start);
		List<PMemoDTO> memoList = session.selectList(namespace + ".getPMemoList", dto);
		return memoList;
	}

	@Override
	public List<GMemoDTO> getGMemoList(int group_seq, int start) {
		gPageDTO dto = new gPageDTO(group_seq, start);
		List<GMemoDTO> memoList = session.selectList(namespace + ".getGMemoList", dto);
		return memoList;
	}

	@Override
	public int PMemoCnt(String id) {
		int cnt = session.selectOne(namespace + ".getPMemoCnt", id);
		return cnt;
	}

	@Override
	public int GMemoCnt(int group_seq) {
		int cnt = session.selectOne(namespace + ".getGMemoCnt", group_seq);
		return cnt;
	}

	@Override
	public boolean projectDelete(PBoardDTO board) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".projectDelete", board);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public List<GroupDTO> getGroupList(String s_id) {
		List<GroupDTO> groupList = session.selectList(login + ".getGroupList", s_id);
		return groupList;
	}

	public boolean removePMemo(int m_seq) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".removePMemo", m_seq);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean updatePMemo(PMemoDTO pmemo) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".updatePMemo", pmemo);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public PMemoDTO getPMemoModal(int seq) {
		PMemoDTO pmemo = session.selectOne(namespace + ".getPMemoModal", seq);
		return pmemo;
	}

	@Override
	public boolean updateGMemo(GMemoDTO gmemo) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".updateGMemo", gmemo);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean removeGMemo(int gm_seq) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".removeGMemo", gm_seq);
		if (aCnt > 0) {
			flag = true;
		}
		System.out.println("dao : " + flag);
		return flag;
	}

	@Override
	public GMemoDTO getGMemoModal(int seq) {
		GMemoDTO gmemo = session.selectOne(namespace + ".getGMemoModal", seq);
		return gmemo;
	}

	@Override
	public List<GLogDTO> getGLogAlarm(String s_id) {
		List<GLogDTO> list = session.selectList(namespace + ".getGLogAlarm", s_id);
		return list;
	}

	@Override
	public List<QnaDTO> getQnaList(int start) {
		List<QnaDTO> qnaList = session.selectList(namespace + ".getQnaList", start);
		return qnaList;
	}

	@Override
	public boolean registQna(QnaDTO qna) {
		boolean flag = false;
		System.out.println("dao, QNADTO" + qna);
		int aCnt = session.insert(namespace + ".registQna", qna);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean updateReadCount(int q_seq) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".updateReadCount", q_seq);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public QnaDTO detailQna(int q_seq) {
		QnaDTO qna = session.selectOne(namespace + ".detailQna", q_seq);
		return qna;
	}

	@Override
	public int qnaCnt() {
		int cnt = session.selectOne(namespace + ".qnaCnt");
		return cnt;
	}

	@Override
	public boolean qnaDelete(int q_seq) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".qnaDelete", q_seq);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean qnaUpdate(QnaDTO qna) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".qnaUpdate", qna);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public List<ReQnaDTO> getReplyList(int q_seq) {
		List<ReQnaDTO> replyList = session.selectList(namespace + ".getReplyList", q_seq);
		return replyList;
	}

	@Override
	public boolean registReply(ReQnaDTO reply) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".registReply", reply);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public PBoardDTO finduuidname(String p_boardseq) {
		PBoardDTO board = session.selectOne(namespace + ".finduuidname", p_boardseq);
		return board;
	}

	@Override
	public List<MinutesDTO> minutesList(mPageDTO mList) {
		List<MinutesDTO> list = session.selectList(namespace + ".minutesList", mList);
		return list;
	}

	@Override
	public List<String> getNameList(int group_seq) {
		List<String> nameList = session.selectList(namespace + ".getNameList", group_seq);
		return nameList;
	}

	@Override
	public boolean registMinutes(MinutesDTO minutes) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".registMinutes", minutes);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public MinutesDTO readMinutes(int seq) {
		MinutesDTO minutes = session.selectOne(namespace + ".readMinutes", seq);
		return minutes;
	}

	@Override
	public int mCnt(int group_seq) {
		int cnt = session.selectOne(namespace + ".mCnt", group_seq);
		return cnt;
	}

	@Override
	public boolean updateMinutes(MinutesDTO minutes) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".updateMinutes", minutes);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean deleteMinutes(int min_seq) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".deleteMinutes", min_seq);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public StudentDTO getReplyUser(String s_id) {
		StudentDTO student = session.selectOne(namespace + ".getReplyUser", s_id);
		return student;
	}

	@Override
	public String passwordCheck(String s_id) {
		String encodedPw = session.selectOne(login + ".getEncodedPw", s_id);
		return encodedPw;
	}

	@Override
	public StudentDTO idCheck(String s_id) {
		StudentDTO student = session.selectOne(login + ".idCheck", s_id);

		return student;
	}

	@Override
	public boolean myUpdate(StudentDTO dto) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".myUpdate", dto);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public GanttDTO chart(int group_seq) {
		GanttDTO gantt = session.selectOne(namespace + ".chart", group_seq);
		return gantt;
	}

	@Override
	public boolean saveGantt(GanttDTO gantt) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".saveGantt", gantt);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public String getClassName(int s_class_code) {
		String className = session.selectOne(namespace + ".getClassName", s_class_code);
		return className;
	}

	public List<TodoDTO> todoList(TodoDTO dto) {
		List<TodoDTO> todoList = null;
		int aCnt = session.insert(namespace + ".addTodo", dto);
		if (aCnt > 0) {
			todoList = session.selectList(namespace + ".todoList", dto);
		}
		return todoList;
	}

	@Override
	public List<TodoDTO> getTodoList(String todo_id) {
		List<TodoDTO> todoList = session.selectList(namespace + ".getTodoList", todo_id);
		return todoList;
	}

	@Override
	public boolean deleteAll(String id) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".deleteAll", id);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean deleteLine(int seq) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".deleteLine", seq);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public StudentDTO getMasInfo(String title) {
		StudentDTO dto = session.selectOne(git + ".getMasInfo", title);
		return dto;
	}

	@Override
	public MinutesDTO getRecentMinutes(int group_seq) {
		MinutesDTO minutes = session.selectOne(namespace + ".getRecentMinutes", group_seq);
		return minutes;
	}

	@Override
	public String getGroupTitle(int group_seq) {
		String group_title = session.selectOne(namespace + ".getGroupTitle", group_seq);
		return group_title;
	}

	@Override
	public boolean changePw(StudentDTO student) {
		boolean flag = false;
		int aCnt = session.update(login + ".changePw", student);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public List<CClassDTO> getSubject(int code) {
		List<CClassDTO> list = session.selectList(namespace + ".getSubject", code);
		return list;
	}

	@Override
	public CClassDTO getDate(SubjectDateFormat dateFormat) {
		CClassDTO dto = session.selectOne(namespace + ".getDate", dateFormat);
		return dto;
	}

	@Override
	public List<SubSubjectDTO> subSubject(String subject) {
		List<SubSubjectDTO> sub = session.selectList(namespace + ".getsubSubject", subject);
		return sub;
	}

	@Override
	public List<ReQnaDTO> getReQnaAlarm(String s_id) {
		List<ReQnaDTO> dto = session.selectList(namespace + ".getReQnaAlarm", s_id);
		return dto;
	}

	@Override
	public boolean qnaState(int q_seq) {
		boolean flag = false;
		int aCnt = session.update(namespace + ".qnaState", q_seq);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public List<GinDTO> getGroupMember(GroupDTO dto) {
		List<GinDTO> list = session.selectList(namespace + ".getGroupMember", dto);
		return list;
	}

	@Override
	public boolean insertGLog(GLogDTO dto) {
		System.out.println("insert log dto: " + dto);
		boolean flag = false;
		int aCnt = session.insert(namespace + ".insertGLog", dto);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean readGLog(int log_seq) {
		boolean flag = false;
		int aCnt = session.delete(namespace + ".readGLog", log_seq);
		if (aCnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public int getGroupSeq(String title) {
		Integer temp = session.selectOne(namespace + ".getGroupSeq", title);
		int seq;
		if (temp == null) {
			seq = 0;
		} else {
			seq = temp;
		}
		return seq;
	}

	@Override
	public int getPBoardCnt(String id) {
		int cnt = session.selectOne(namespace + ".getPBoardCnt", id);
		return cnt;
	}

	@Override
	public int getGinCnt(String id) {
		int cnt = session.selectOne(namespace + ".getGinCnt", id);
		return cnt;
	}

	@Override
	public int getQnaCnt(String id) {
		int cnt = session.selectOne(namespace + ".getQnaCnt", id);
		return cnt;
	}
}
