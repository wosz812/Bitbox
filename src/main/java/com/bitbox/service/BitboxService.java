package com.bitbox.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bitbox.dao.IBitboxDAO;
import com.bitbox.dto.CClassDTO;
import com.bitbox.dto.CalendarFormat;
import com.bitbox.dto.GLogDTO;
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
import com.bitbox.dto.SubSubjectDTO;
import com.bitbox.dto.SubjectDateFormat;
import com.bitbox.dto.SubjectFormat;
import com.bitbox.dto.TodoDTO;
import com.bitbox.dto.mPageDTO;

@Service
public class BitboxService implements IBitboxService, UserDetailsService {

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
	public UserDetails loadUserByUsername(String arg0) throws UsernameNotFoundException {
		StudentDTO sdto = login(arg0);
		sdto.setGroup(getGroupList(sdto.getS_id()));
		return sdto;
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
			format.setUrl("http://localhost:8080/bitbox/detailProject?p_boardseq=" + calendar.get(i).getP_boardseq()
					+ "&p_title=" + calendar.get(i).getP_title() + "&p_content=" + calendar.get(i).getP_content()
					+ "&p_filename=" + calendar.get(i).getP_filename() + "&p_category="
					+ calendar.get(i).getP_category() + "&cal=cal");

			// 수정
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
		System.out.println("groupRegist service before"+dto);
		boolean flag = dao.groupRegist(dto);
		System.out.println("groupRegist service after"+dto);
		if (flag) {
			GinDTO group = new GinDTO(dto.getGroup_seq(), dto.getS_id());
			flag = dao.groupIn(group);
		}
		return flag;
	}
	
	@Override
	public boolean groupImport(GroupDTO dto,ArrayList<String> memberList) {
		boolean[] flags=new boolean[3];
		boolean flag=false;
		flags[0]=dao.groupImport(dto);
		System.out.println("gimport cgroup success");
		if(flags[0]){
			boolean[] mflags=new boolean[memberList.size()];
			int seq=dao.getGroupSeq(dto.getTitle());
			for(int i=0;i<memberList.size();i++){
				GinDTO mgroup = new GinDTO(seq, memberList.get(i));
				mflags[i]=dao.groupIn(mgroup);
			}
			System.out.println("gimport gin success");
			for(int j=0;j<mflags.length;j++){
				if(mflags[j]){
					if(j==mflags.length-1){
						flags[1]=true;
					}
				}else{
					System.out.println("groupin insert fail!!");
				}
			}
			flags[2]=dao.ganttRegist(seq);
		}
		for(int i=0;i<flags.length;i++){
			if(flags[i]){
				if(i==flags.length-1){
					flag=true;
				}
			}else{
				System.out.println("group Import fail!!");
			}
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
			pageList.add(" <a href='/memo/pMemo?group_seq=0&page=" + ((pageUnit - 1) * 10)
					+ "'><button class=\"btn btn-primary\">prev</button></a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			pageList.add(" <a href='/memo/pMemo?group_seq=0&page=" + (i) + "'><button class=\"btn btn-primary\">"
					+ (i + 1) + "</button></a> ");
		}
		// next
		if (endPage < pageCount) {
			pageList.add(" <a href='/memo/pMemo?group_seq=0&page=" + (endPage)
					+ "'><button class=\"btn btn-primary\">next</button></a> ");
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
					+ "'><button class=\"btn btn-default\">prev</button></a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			pageList.add(" <a href='/memo/gMemo?group_seq=" + group_seq + "&page=" + (i)
					+ "'><button class=\"btn btn-primary\">" + (i + 1) + "</button></a> ");
		}
		// next
		if (endPage < pageCount) {
			pageList.add(" <a href='/memo/gMemo?group_seq=" + group_seq + "&page=" + (endPage)
					+ "'><button class=\"btn btn-default\">next</button></a> ");
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
	public List<GLogDTO> getGLogAlarm(String s_id) {
		// System.out.println("service call");
		List<GLogDTO> list= dao.getGLogAlarm(s_id);
		// System.out.println("dao call-service");
		return list;
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
		if (flag) {
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
			pageList.add(" <a href='/bitbox/qna?&page=" + ((pageUnit - 1) * 10)
					+ "'><button class=\"btn btn-default\">prev</button></a>");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			pageList.add(" <a href='/bitbox/qna?page=" + (i) + "'><button class=\"btn btn-primary\">" + (i + 1)
					+ "</button></a>");
		}
		// next
		if (endPage < pageCount) {
			pageList.add(" <a href='/bitbox/qna?page=" + (endPage)
					+ "'><button class=\"btn btn-default\">next</button></a> ");
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
		PBoardDTO board = dao.finduuidname(p_boardseq);
		return board;
	}

	@Override
	public StringBuffer readFile(MultipartFile file) {
		InputStream input = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		StringBuffer list = new StringBuffer();

		String line;
		// System.out.println(fileName);
		try {

			input = file.getInputStream();
			isr = new InputStreamReader(input, "UTF-8");
			br = new BufferedReader(isr);
			// model.addAttribute("list",br.toString());
			while ((line = br.readLine()) != null) {
				list.append(line);
				list.append("\n");
			}

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
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
					+ "&group_title=" + group_title + "'><button class=\"btn btn-default\">prev</button></a> ");
		}
		for (int i = pageUnit * 10; i < endPage; i++) {
			mpageList.add(" <a href='/bitbox/minutesList?page=" + (i) + "&group_seq=" + group_seq + "&group_title="
					+ group_title + "'><button class=\"btn btn-primary\">" + (i + 1) + "</button></a> ");
		}
		// next
		if (endPage < pageCount) {
			mpageList.add(" <a href='/bitbox/minutesList?page=" + (endPage) + "&group_seq=" + group_seq
					+ "&group_title=" + group_title + "'><button class=\"btn btn-default\">next</button></a> ");
		}

		return mpageList;
	}

	@Override
	public ArrayList<String> getMember(int group_seq) {
		ArrayList<String> member = new ArrayList<String>();
		List<String> nameList = dao.getNameList(group_seq);
		for (String name : nameList) {
			member.add("<option>" + name + "</option>");
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
	public String enter2(String str) {
		String str2 = str.replace("<br>", "\r\n");
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
		if (dao.idCheck(s_id) != null) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean myUpdate(StudentDTO dto) {
		// TODO Auto-generated method stub
		boolean flag = dao.myUpdate(dto);

		return flag;
	}

	@Override
	public GanttDTO chart(int group_seq) {
		GanttDTO gantt = dao.chart(group_seq);
		return gantt;
	}

	@Override
	public boolean saveGantt(GanttDTO gantt) {
		boolean flag = dao.saveGantt(gantt);
		return flag;
	}

	@Override
	public String getClassName(int s_class_code) {
		// TODO Auto-generated method stub
		String className = dao.getClassName(s_class_code);
		return className;
	}

	public ArrayList<String> getTodoList(String id) {
		List<TodoDTO> todoList = dao.getTodoList(id);
		ArrayList<String> list = new ArrayList<String>();
		list.add("<tr><td class=\"inp\"><input class=\"form-control\" id=\"todoText\" placeholder=\"Input TODO\""
				+ "type=\"text\"></td><td style=\"padding-right: 15px; padding-left: 15px\"><button id=\"todoButton\" class=\"btn btn-primary\">Add</button></td>"
				+ "<td><button id=\"todoDeleteAll\" class=\"btn btn-danger\">Delete all</button></td></tr>");
		for (TodoDTO todo : todoList) {
			list.add("<tr><td colspan=\"2\" style=\"padding-left: 15px\">" + todo.getTodo()
					+ "</td><td class=\"btn\"><button class=\"btn btn-warning\" id=\"deleteLine\" seq=\""
					+ todo.getTodo_seq() + "\">Delete</button></td></tr>");
		}
		return list;
	}
	
	@Override
	public List<TodoDTO> getTodoListAlarm(String id) {
		List<TodoDTO> todoList = dao.getTodoList(id);
		return todoList;
	}

	@Override
	public ArrayList<String> todoList(TodoDTO dto) {
		List<TodoDTO> todoList = dao.todoList(dto);
		ArrayList<String> list = new ArrayList<String>();
		list.add("<tr><td class=\"inp\"><input class=\"form-control\" id=\"todoText\" placeholder=\"Input TODO\""
				+ "type=\"text\"></td><td style=\"padding-right: 15px; padding-left: 15px\"><button id=\"todoButton\" class=\"btn btn-primary\">Add</button></td>"
				+ "<td><button id=\"todoDeleteAll\" class=\"btn btn-danger\">Delete all</button></td></tr>");
		for (TodoDTO todo : todoList) {
			list.add("<tr><td colspan=\"2\"  style=\"padding-left: 15px\">" + todo.getTodo()
					+ "</td><td class=\"btn\"><button class=\"btn btn-warning\" id=\"deleteLine\" seq=\""
					+ todo.getTodo_seq() + "\">Delete</button></td></tr>");
		}
		return list;
	}

	@Override
	public boolean deleteAll(String id) {
		boolean flag = dao.deleteAll(id);
		return flag;
	}

	@Override
	public boolean deleteLine(int seq) {
		boolean flag = dao.deleteLine(seq);
		return flag;
	}

	@Override
	public StudentDTO getMasInfo(String title) {
		// TODO Auto-generated method stub
		StudentDTO sdto = dao.getMasInfo(title);
		return sdto;
	}

	public MinutesDTO getRecentMinutes(int group_seq) {
		// TODO Auto-generated method stub
		MinutesDTO minutes = dao.getRecentMinutes(group_seq);
		return minutes;
	}

	@Override
	public String getGroupTitle(int group_seq) {
		// TODO Auto-generated method stub
		String group_title = dao.getGroupTitle(group_seq);
		return group_title;
	}

	@Override
	public boolean changePw(StudentDTO student) {
		boolean flag = dao.changePw(student);
		return flag;
	}
	@Override
	public ArrayList<SubjectFormat> getSubject(int code) {
		//과정 과목 받아오는 메소드.
		List<CClassDTO> list = dao.getSubject(code);
		ArrayList<SubjectFormat> formats = new ArrayList<SubjectFormat>();
		SubjectFormat f = null;
		for (int i = 0; i < list.size(); i++) {
			f = new SubjectFormat();
			f.setLabel(list.get(i).getSub_name());
			f.setValue("1");
			formats.add(f);
		}
		return formats;
	}

	@Override
	public ArrayList<SubjectFormat> getDate(SubjectDateFormat dateFormat) {
		//과정 일수 받아오는 메소드.
		CClassDTO dto = dao.getDate(dateFormat);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		formatter.format(new Date());
		ArrayList<SubjectFormat> formats = new ArrayList<SubjectFormat>();
		SubjectFormat format1 = new SubjectFormat();
		SubjectFormat format2 = new SubjectFormat();
		long statsDate=0;
		try {

			long endDate = diffOfDate(formatter.format(new Date()), formatter.format(dto.getEnd_date()));
			statsDate=diffOfDate(formatter.format(dto.getStart_date()), formatter.format(new Date()));
			if(statsDate<=0){
				endDate=diffOfDate(formatter.format(dto.getStart_date()), formatter.format(dto.getEnd_date()));
			}
			if (endDate < 0) {
				endDate = 0;
			}
			
			format1.setLabel("남은 일수");
			format1.setValue(String.valueOf(endDate));
			System.out.println("남은 일수 :" + String.valueOf(endDate));
			long startDate = diffOfDate(formatter.format(dto.getStart_date()), formatter.format(new Date()));
			long totalDate = diffOfDate(formatter.format(dto.getStart_date()), formatter.format(dto.getEnd_date()));
			
			if (startDate > totalDate) {
				startDate = totalDate;		
				
			}
			if(startDate<0){
				startDate=0;
			}
			format2.setLabel("현재 일수");
			format2.setValue(String.valueOf(startDate));
			formats.add(format1);
			formats.add(format2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return formats;
	}

	@Override
	public ArrayList<SubjectFormat> getsubSubject(String subject) {
		// TODO Auto-generated method stub
		ArrayList<SubjectFormat> formats = new ArrayList<SubjectFormat>();
		SubjectFormat sf = null;
		List<SubSubjectDTO> sub = dao.subSubject(subject);
		for (int i = 0; i < sub.size(); i++) {
			sf = new SubjectFormat();
			sf.setLabel(sub.get(i).getSub());
			sf.setValue("1");
			formats.add(sf);
		}
		return formats;
	}

	public static long diffOfDate(String begin, String end) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Date beginDate = formatter.parse(begin);
		Date endDate = formatter.parse(end);
		long diff = endDate.getTime() - beginDate.getTime();
		long diffDays = diff / (24 * 60 * 60 * 1000);
		return diffDays;
	}

	@Override
	public List<ReQnaDTO> getReQnaAlarm(String s_id) {
		// TODO Auto-generated method stub
		List<ReQnaDTO> dto=dao.getReQnaAlarm(s_id);
		return dto;
	}

	@Override
	public boolean qnaState(int q_seq) {
		// TODO Auto-generated method stub
		boolean flag=dao.qnaState(q_seq);
		return flag;
	}

	@Override
	public List<GinDTO> getGroupMember(GroupDTO dto) {
		// TODO Auto-generated method stub
		List<GinDTO> list=dao.getGroupMember(dto);
		return list;
	}

	@Override
	public boolean insertGLog(ArrayList<GLogDTO> list) {
		ArrayList<Boolean> flagList=new ArrayList<Boolean>();
		boolean flag=false;
		for(int i=0;i<list.size();i++){
			flagList.add(dao.insertGLog(list.get(i)));
		}
		for(int i=0;i<flagList.size();i++){
			if(flagList.get(i)){
				if(i==flagList.size()-1){
					flag=true;
				}
			}
		}
		return flag;
	}

	@Override
	public boolean readGLog(int log_seq) {
		// TODO Auto-generated method stub
		boolean flag=dao.readGLog(log_seq);
		return flag;
	}

	@Override
	public int getGroupSeq(String title) {
		// TODO Auto-generated method stub
		int seq=dao.getGroupSeq(title);
		return seq;
	}

	@Override
	public int getPBoardCnt(String id) {
		int cnt=dao.getPBoardCnt(id);
		return cnt;
	}
	
	@Override
	public int getGinCnt(String id) {
		int cnt=dao.getGinCnt(id);
		return cnt;
	}

	@Override
	public int getQnaCnt(String id) {
		int cnt=dao.getQnaCnt(id);
		return cnt;
	}

	@Override
	public List<StudentDTO> getMemberListClass(StudentDTO dto) {
		// TODO Auto-generated method stub
		List<StudentDTO> list=dao.getMemberListClass(dto);
		return list;
	}

	@Override
	public StudentDTO getStudentId(String git_id) {
		StudentDTO dto=dao.getStudentId(git_id);
		return dto;
	}
}
