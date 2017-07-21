package com.bitbox.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bitbox.dao.IBitboxDAO;
import com.bitbox.dto.CalendarFormat;
import com.bitbox.dto.GMemoDTO;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.MinutesDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.dto.QnaDTO;
import com.bitbox.dto.ReQnaDTO;
import com.bitbox.dto.StudentDTO;
import com.bitbox.dto.mPageDTO;


@Service
public class BitboxService implements IBitboxService {

	@Autowired
	private IBitboxDAO dao;

	@Override
	public List<PBoardDTO> listAll(String id) {
		List<PBoardDTO> list = dao.listAll(id);
		return list;
	}

	@Override
	public boolean regist(PBoardDTO board) {
		boolean flag = dao.regist(board);
		return flag;
	}

	@Override
	public boolean studentRegist(StudentDTO student) {
		boolean flag = dao.studentRegist(student);
		return flag;
	}

	@Override
	public StudentDTO login(String s_id) {
		StudentDTO sdto = dao.login(s_id);
		return sdto;
	}

	@Override
	public List<CalendarFormat> getCalendar(String id) {
		List<PBoardDTO> calendar = dao.getCalendar(id);
		List<CalendarFormat> calendars = new ArrayList<CalendarFormat>();
		CalendarFormat format = null;
		for (int i = 0; i < calendar.size(); i++) {
			format = new CalendarFormat();
			format.setTitle(calendar.get(i).getP_title());
			format.setStart(new SimpleDateFormat("yyyy-MM-dd").format(calendar.get(i).getP_date()));
            format.setUrl("http://localhost:8080/bitbox/detailProject?p_boardseq="+calendar.get(i).getP_boardseq()+"&p_title="+calendar.get(i).getP_title()
                    +"&p_content="+calendar.get(i).getP_content()+"&p_filename="+calendar.get(i).getP_filename()+"&p_category="+calendar.get(i).getP_category()+"&cal=cal");

            //수정
			calendars.add(format);
		}
		return calendars;
	}

	@Override
	public StudentDTO searchInfo(StudentDTO dto, int type) {
		StudentDTO student = dao.search(dto, type);
		return student;
	}

	@Override
	public List<PBoardDTO> listAll() {
		List<PBoardDTO> list = dao.listAll();
		return list;
	}

	@Override
	public boolean projectUpdate(PBoardDTO board) {
		boolean flag = dao.projectUpdate(board);
		return flag;
	}

	@Override
	public List<GroupDTO> getGroupList() {
		List<GroupDTO> list = dao.groupList();
		return list;
	}

	@Override
	public GroupDTO getGroupModal(String gNo) {
		GroupDTO modal = dao.groupModal(gNo);
		return modal;
	}

	@Override
	public int groupJoin(GroupDTO group, GinDTO gIn) {
		int state = 3;
		GroupDTO dto = dao.getGroup(group.getGroup_seq());// 媛��엯�븯�젮�뒗 group
															// dto
		GinDTO sGin = dao.selectGin(gIn);

		if (!(dto.getPw().equals(group.getPw()))) {
			state = 2;
		} else if (sGin != null) {
			state = 1;
		} else {
			GinDTO gin = new GinDTO(dto.getGroup_seq(), group.getS_id());
			boolean flag = dao.groupIn(gin);
			if (flag) {
				state = 0;
			}
		}
		return state;
	}

	@Override
	public boolean groupRegist(GroupDTO dto) {
		boolean flag = dao.groupRegist(dto);
		if (flag) {
			GinDTO group = new GinDTO(dto.getGroup_seq(), dto.getS_id());
			flag = dao.groupIn(group);
		}
		return flag;
	}

	@Override
	public boolean registPMemo(PMemoDTO dto) {
		boolean flag = false;
		flag = dao.registPMemo(dto);
		return flag;
	}

	@Override
	public boolean registGMemo(GMemoDTO dto) {
		boolean flag = false;
		flag = dao.registGMemo(dto);
		return flag;
	}

	@Override
	public List<PMemoDTO> getPMemoList(String id, int page) {
		int start = (page * 3) + 1;
		List<PMemoDTO> memoList = dao.getPMemoList(id, start);
		return memoList;
	}

	@Override
	public List<GMemoDTO> getGMemoList(int group_seq, int page) {
		int start = (page * 3) + 1;
		List<GMemoDTO> memoList = dao.getGMemoList(group_seq, start);
		return memoList;
	}

	@Override
	public ArrayList<String> getPageList(int page, String id) {
		ArrayList<String> pageList = new ArrayList<String>();
		// 페이지 리스트를 받아와야함
		int amount = 3;
		int count = dao.PMemoCnt(id);// 로우 갯수
		int pageCount = (int) Math.ceil(count / (double) amount);
		int pageUnit = page / 10;
		int endPage = (pageUnit * 10) + 10;
		endPage = endPage <= pageCount ? endPage : pageCount;

		if (pageUnit != 0) {
			pageList.add(" <a href='/memo/pMemo?group_seq=0&page=" + ((pageUnit - 1) * 10) + "'> prev </a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			pageList.add(" <a href='/memo/pMemo?group_seq=0&page=" + (i) + "'>" + (i + 1) + "</a> ");
		}
		// next
		if (endPage < pageCount) {
			pageList.add(" <a href='/memo/pMemo?group_seq=0&page=" + (endPage) + "'> next </a> ");
		}

		return pageList;
	}

	@Override
	public ArrayList<String> getGPageList(int page, int group_seq) {
		ArrayList<String> pageList = new ArrayList<String>();
		// 페이지 리스트를 받아와야함
		int amount = 3;
		int count = dao.GMemoCnt(group_seq);// 로우 갯수
		int pageCount = (int) Math.ceil(count / (double) amount);
		int pageUnit = page / 10;
		int endPage = (pageUnit * 10) + 10;
		endPage = endPage <= pageCount ? endPage : pageCount;

		if (pageUnit != 0) {
			pageList.add(" <a href='/memo/gMemo?group_seq=" + group_seq + "&page=" + ((pageUnit - 1) * 10)
					+ "'> prev </a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			pageList.add(" <a href='/memo/gMemo?group_seq=" + group_seq + "&page=" + (i) + "'>" + (i + 1) + "</a> ");
		}
		// next
		if (endPage < pageCount) {
			pageList.add(" <a href='/memo/gMemo?group_seq=" + group_seq + "&page=" + (endPage) + "'> next </a> ");
		}

		return pageList;
	}

	@Override
	public boolean projectDelete(PBoardDTO board) {
		boolean flag = dao.projectDelete(board);
		return flag;
	}

	@Override
	public List<GroupDTO> getGroupList(String s_id) {
		List<GroupDTO> groupList = dao.getGroupList(s_id);
		return groupList;
	}

	@Override
	public boolean removePMemo(int m_seq) {
		boolean flag = dao.removePMemo(m_seq);
		return flag;
	}

	@Override
	public boolean updatePMemo(PMemoDTO pmemo) {
		boolean flag = dao.updatePMemo(pmemo);
		return flag;
	}

	@Override
	public PMemoDTO getPMemoModal(int seq) {
		PMemoDTO pmemo = dao.getPMemoModal(seq);
		return pmemo;
	}

	@Override
	public boolean updateGMemo(GMemoDTO gmemo) {
		boolean flag = dao.updateGMemo(gmemo);
		return flag;
	}

	@Override
	public boolean removeGMemo(int gm_seq) {
		boolean flag = dao.removeGMemo(gm_seq);
		System.out.println("service : " + flag);
		return flag;
	}

	@Override
	public GMemoDTO getGMemoModal(int seq) {
		GMemoDTO gmemo = dao.getGMemoModal(seq);
		return gmemo;
	}

	@Override
	public int getCnt() {
		//System.out.println("service call");
		int cnt=dao.getCnt();
		//System.out.println("dao call-service");
		return cnt;
	}
	
	@Override
	public List<QnaDTO> getQnaList(int page) {
		int start = (page * 10) + 1;
		List<QnaDTO> qnaList = dao.getQnaList(start);
		return qnaList;
	}

	@Override
	public boolean registQna(QnaDTO qna) {
		boolean flag = dao.registQna(qna);
		return flag;
	}

	@Override
	public QnaDTO detailQna(int q_seq) {
		boolean flag = dao.updateReadCount(q_seq);
		QnaDTO qna = null;
		if(flag){
			qna = dao.detailQna(q_seq);
		}
		return qna;
	}

	@Override
	public ArrayList<String> getQnaPageList(int page) {
		ArrayList<String> pageList = new ArrayList<String>();
		// 페이지 리스트를 받아와야함
		int amount = 10;
		int count = dao.qnaCnt();// 로우 갯수
		int pageCount = (int) Math.ceil(count / (double) amount);
		int pageUnit = page / 10;
		int endPage = (pageUnit * 10) + amount;
		endPage = endPage <= pageCount ? endPage : pageCount;

		if (pageUnit != 0) {
			pageList.add(" <a href='/bitbox/qna?&page=" + ((pageUnit - 1) * 10) + "'> prev </a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			pageList.add(" <a href='/bitbox/qna?page=" + (i) + "'>" + (i + 1) + "</a> ");
		}
		// next
		if (endPage < pageCount) {
			pageList.add(" <a href='/bitbox/qna?page=" + (endPage) + "'> next </a> ");
		}

		return pageList;
	}

	@Override
	public boolean qnaDelete(int q_seq) {
		boolean flag = dao.qnaDelete(q_seq);
		return flag;
	}

	@Override
	public boolean qnaUpdate(QnaDTO qna) {
		boolean flag = dao.qnaUpdate(qna);
		return flag;
	}

	@Override
	public List<ReQnaDTO> getReplyList(int q_seq) {
		List<ReQnaDTO> replyList = dao.getReplyList(q_seq);
		return replyList;
	}

	@Override
	public boolean registReply(ReQnaDTO reply) {
		boolean flag = dao.registReply(reply);
		return flag;
	}

	@Override
	public PBoardDTO finduuidname(String p_boardseq) {
		PBoardDTO board=dao.finduuidname(p_boardseq);
		return board;
	}

	@Override
	public StringBuffer readFile(MultipartFile file) {
		InputStream input = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		StringBuffer list = new StringBuffer();
		
		String line;
		//System.out.println(fileName);
		try {
			
			input = file.getInputStream();
			isr = new InputStreamReader(input,"UTF-8");
			br = new BufferedReader(isr);
//			model.addAttribute("list",br.toString());
			while((line=br.readLine())!=null){
				list.append(line);
				list.append("\n");
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			try {
				br.close();
				isr.close();
				input.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	@Override
	public List<MinutesDTO> minutesList(int group_seq, int page) {
		int start = (page * 10) + 1;
		List<MinutesDTO> list = dao.minutesList(new mPageDTO(group_seq, start));
		return list;
	}

	@Override
	public ArrayList<String> getMinutesPageList(int group_seq, int page, String group_title) {
		ArrayList<String> mpageList = new ArrayList<String>();
		// 페이지 리스트를 받아와야함
		int amount = 10;
		int count = dao.mCnt(group_seq);// 로우 갯수
		int pageCount = (int) Math.ceil(count / (double) amount);
		int pageUnit = page / 10;
		int endPage = (pageUnit * 10) + amount;
		endPage = endPage <= pageCount ? endPage : pageCount;

		if (pageUnit != 0) {
			mpageList.add(" <a href='/bitbox/minutesList?page=" + ((pageUnit - 1) * 10) + "&group_seq=" + group_seq
					+ "&group_title=" + group_title + "'> prev </a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			mpageList.add(" <a href='/bitbox/minutesList?page=" + (i) + "&group_seq=" + group_seq
					+ "&group_title=" + group_title + "'>" + (i + 1) + "</a> ");
		}
		// next
		if (endPage < pageCount) {
			mpageList.add(" <a href='/bitbox/minutesList?page=" + (endPage) + "&group_seq=" + group_seq
					+ "&group_title=" + group_title + "'> next </a> ");
		}

		return mpageList;
	}

	@Override
	public ArrayList<String> getMember(int group_seq) {
		ArrayList<String> member = new ArrayList<String>();
		List<String> nameList = dao.getNameList(group_seq);
		for (String name : nameList) {
			member.add("<option>"+name+"</option>");
		}
		return member;
	}

	@Override
	public boolean registMinutes(MinutesDTO minutes) {
		boolean flag = dao.registMinutes(minutes);
		return flag;
	}

	@Override
	public MinutesDTO readMinutes(int seq) {
		MinutesDTO minutes = dao.readMinutes(seq);
		return minutes;
	}

	@Override
	public boolean updateMinutes(MinutesDTO minutes) {
		boolean flag = dao.updateMinutes(minutes);
		return flag;
	}

	@Override
	public boolean deleteMinutes(int min_seq) {
		boolean flag = dao.deleteMinutes(min_seq);
		return flag;
	}
	
	@Override
	public String getReplyUser(String s_id) {
		StudentDTO student = dao.getReplyUser(s_id);
		String replyUser = student.getS_id() + " ( " + student.getS_name() + " )";
		return replyUser;
	}
	
	@Override
	public String enter(String str) {
		String str2 = str.replace("\r\n", "<br>");
		return str2;
	}

	@Override
	public String passwordCheck(String s_id) {
		// TODO Auto-generated method stub
		String encodedPw = dao.passwordCheck(s_id);
		return encodedPw;
	}

	@Override
	public boolean idCheck(String s_id) {
		// TODO Auto-generated method stub
		boolean flag = false;
		if(dao.idCheck(s_id)!=null){
			flag = true;
		}
		return flag;
	}

}
