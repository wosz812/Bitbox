package com.bitbox.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitbox.dao.IBitboxDAO;
import com.bitbox.dto.CalendarFormat;
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
			format.setUrl("http://localhost:8080/bitbox/detailProject?p_boardseq="+calendar.get(i).getP_boardseq()+"&p_title="+calendar.get(i).getP_title()
					+"&p_content="+calendar.get(i).getP_content()+"&p_upload="+calendar.get(i).getP_upload()+"&p_category="+calendar.get(i).getP_category()+"&cal=cal");
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
	public boolean registMemo(PMemoDTO dto) {
		boolean flag = false;
		flag = dao.registMemo(dto);
		return flag;
	}

	@Override
	public List<PMemoDTO> getMemoList(String id,int page) {
		int start = (page*5) +1;
		List<PMemoDTO> memoList = dao.getMemoList(id,start);
		return memoList;
	}

	@Override
	public ArrayList<String> getPageList(int page, String id) {
		ArrayList<String> pageList = new ArrayList<String>();
		// 페이지 리스트를 받아와야함
		int amount = 5;
		int count = dao.PMemoCnt(id);// 로우 갯수
		int pageCount = (int) Math.ceil(count / (double) amount);
		int pageUnit = page / amount;
		int endPage = (pageUnit * 10) + amount;
		endPage = endPage <= pageCount ? endPage : pageCount;
		
		if (pageUnit != 0) {
			pageList.add(" <a href='/memo/memoView?page=" + ((pageUnit - 1) * 10) + "'> prev </a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			pageList.add(" <a href='/memo/memoView?page=" + (i) + "'>" + (i + 1) + "</a> ");
		}
		// next
		if (endPage < pageCount) {
			pageList.add(" <a href='/memo/memoView?page=" + (endPage) + "'> next </a> ");
		}

		return pageList;
	}

	@Override
	public boolean projectDelete(PBoardDTO board) {
		// TODO Auto-generated method stub
		boolean flag=dao.projectDelete(board);
		return flag;
	}
	
	@Override
	public List<GroupDTO> getGroupList(String s_id) {
		List<GroupDTO> groupList = dao.getGroupList(s_id);
		return groupList;
	}

}
