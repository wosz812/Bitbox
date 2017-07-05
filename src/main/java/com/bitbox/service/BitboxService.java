package com.bitbox.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitbox.dao.IBitboxDAO;
import com.bitbox.dto.CalendarFormat;
import com.bitbox.dto.GMemoDTO;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.dto.StudentDTO;

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
	public StudentDTO loginCheck(StudentDTO student) {
		StudentDTO sdto = dao.loginCheck(student);
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
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
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

}
