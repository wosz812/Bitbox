package com.bitbox.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.dto.StudentDTO;

@Repository
public class BitboxDAO implements IBitboxDAO {

	@Autowired
	private SqlSession session;

	private static final String namespace = "com.bitbox.bitboxMapper";
	private static final String login = "com.bitbox.loginMapper";
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

		int aCnt = session.insert(login + ".regist", student);
		if (aCnt > 0) {
			flag = true;
		}
		logger.info("flag", flag);
		return flag;
	}

	@Override
	public StudentDTO loginCheck(StudentDTO student) {
		logger.info(student.toString());
		StudentDTO a = session.selectOne(login + ".loginCheck", student);
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
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
		GroupDTO dto = session.selectOne(namespace + ".getGroup", seq);
		System.out.println("getGroup dao: " + dto);
		return dto;
	}

	@Override
	public boolean groupIn(GinDTO gin) {
		// TODO Auto-generated method stub
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
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean registMemo(PMemoDTO dto) {
		boolean flag = false;
		int aCnt = session.insert(namespace + ".registMemo", dto);
		if (aCnt > 0) {
			flag = true;
		}
		return false;
	}

	@Override
	public List<PMemoDTO> getMemoList() {
		List<PMemoDTO> memoList = session.selectList(namespace + ".getMemoList");
		return memoList;
	}
}
