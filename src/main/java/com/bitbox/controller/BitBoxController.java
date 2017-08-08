package com.bitbox.controller;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bitbox.dto.CalendarFormat;
import com.bitbox.dto.GLogDTO;
import com.bitbox.dto.GanttDTO;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.MinutesDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.QnaDTO;
import com.bitbox.dto.ReQnaDTO;
import com.bitbox.dto.StudentDTO;
import com.bitbox.dto.SubjectDateFormat;
import com.bitbox.dto.SubjectFormat;
import com.bitbox.dto.TodoDTO;
import com.bitbox.service.IBitboxService;
import com.bitbox.service.PdfService;
import com.google.gson.Gson;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@RequestMapping(value = "/bitbox")

@Controller
public class BitBoxController {
	//test 수정
	//test
	String path = "c:\\dev\\";

	@Autowired
	private IBitboxService service;

	private static final Logger logger = LoggerFactory.getLogger(BitBoxController.class);

	@RequestMapping(value = "/home", method = { RequestMethod.POST, RequestMethod.GET })
	public String home(HttpSession session, Model model) {
		// ((OAuth2Authentication)SecurityContextHolder.getContext().getAuthentication()).getDetails()
		// ((OAuth2Authentication)SecurityContextHolder.getContext().getAuthentication()).getUserAuthentication();
		String url = "/bitbox/home";
		// session.setAttribute("id", session.getAttribute("id"));
		// session.setAttribute("code", session.getAttribute("code"));
		// session.setAttribute("groupList", session.getAttribute("groupList"));
		return url;
	}

	@RequestMapping(value = "/listAll", method = { RequestMethod.POST, RequestMethod.GET })
	public String listAll(HttpSession session, Model model) {
		String url = "";
		List<PBoardDTO> list = service.listAll(session.getAttribute("id").toString());
		model.addAttribute("list", list);
		url = "bitbox/personalProject";
		return url;
	}

	@RequestMapping(value = "/registForm", method = { RequestMethod.POST, RequestMethod.GET })
	public String registForm(HttpSession session) {
		String url = "/bitbox/personalRegistForm";
		return url;
	}

	@RequestMapping(value = "/regist", method = { RequestMethod.POST, RequestMethod.GET })
	public String regist(@RequestParam("p_title") String p_title, @RequestParam("p_content") String p_content,
			@RequestParam("p_category") String p_category, HttpSession session, MultipartFile p_filename) { // 占쎈쐻占쎈셾占쎈뻻繹먮씮�굲
																											// 占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈짗占쎌굲癲됯퇊�쐻�뜝占�
		String url = null;
		PBoardDTO board = new PBoardDTO();
		String path = this.path;
		boolean flag = false;
		String fileNames = p_filename.getOriginalFilename();
		UUID uuidname = UUID.randomUUID();
		try {
			p_filename.transferTo(new File(path + uuidname.toString() + "_" + fileNames));
			board.setP_title(p_title);
			board.setP_content(p_content);
			board.setP_category(p_category);
			board.setP_filename(fileNames);
			board.setP_uuidname(uuidname.toString() + "_" + fileNames);
			board.setS_id(session.getAttribute("id").toString());
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		flag = service.regist(board);
		if (flag) {
			url = "redirect:/bitbox/listAll";
		}
		return url;
	}

	@RequestMapping(value = "/download", method = { RequestMethod.POST, RequestMethod.GET })
	public HttpEntity<?> downloadtest(@RequestParam("p_boardseq") String p_boardseq, HttpServletRequest req) {
		String path = SystemPropertyUtils.resolvePlaceholders("${storage.path:" + this.path + "}");
		HttpHeaders header = new HttpHeaders();
		PBoardDTO board = service.finduuidname(p_boardseq);
		logger.info("file seq or uuidname is {}", p_boardseq + "," + board.getP_uuidname());
		String filename = board.getP_uuidname();
		header.setContentDispositionFormData("name", filename);
		header.setContentType(MediaType.APPLICATION_OCTET_STREAM);

		return ResponseEntity.ok().headers(header).body(new FileSystemResource(new File(path + filename)));
	}

	@RequestMapping(value = "/uploadImage", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody String uploadImage(HttpServletRequest req, HttpServletResponse res, MultipartFile image) {
		// String path="C:\\dev\\image\\";
		String path = req.getSession().getServletContext().getRealPath("/") + "image\\";
		System.out.println(path);
		UUID uuidname = UUID.randomUUID();
		String imageName = uuidname.toString() + image.getOriginalFilename();
		try {
			image.transferTo(new File(path + imageName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		String url = "http://localhost:8080/image/" + imageName;
		res.setCharacterEncoding("UTF-8");
		return url;
	}

	@RequestMapping(value = "/projectUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	public String projectUpdate(HttpSession session, @RequestParam("p_title") String p_title,
			@RequestParam("p_content") String p_content, @RequestParam("p_boardseq") int p_boardseq,
			@RequestParam(value = "cal", defaultValue = "") String cal) {
		String url = "";
		boolean flag = false;
		PBoardDTO board = new PBoardDTO();
		board.setP_boardseq(p_boardseq);
		board.setP_title(p_title);
		board.setP_content(p_content);
		board.setS_id(session.getAttribute("id").toString());
		logger.info(p_title + "," + cal);
		flag = service.projectUpdate(board);
		if (flag) {
			if (cal.equals("cal")) {
				url = "redirect:/bitbox/calendar";
			} else {
				url = "redirect:/bitbox/listAll";
			}
		}
		return url;
	}

	@RequestMapping(value = "/projectDelete", method = { RequestMethod.POST, RequestMethod.GET })
	public String projectDelete(HttpSession session, @RequestParam("p_title") String p_title,
			@RequestParam("p_content") String p_content, @RequestParam("p_boardseq") int p_boardseq,
			@RequestParam(value = "cal", defaultValue = "") String cal) {
		String url = "";
		boolean flag = false;
		PBoardDTO board = new PBoardDTO();
		board.setP_boardseq(p_boardseq);
		board.setS_id(session.getAttribute("id").toString());
		logger.info(p_boardseq + "," + session.getAttribute("id").toString());
		flag = service.projectDelete(board);
		if (flag) {
			if (cal.equals("cal")) {
				url = "redirect:/bitbox/calendar";
			} else {
				url = "redirect:/bitbox/listAll";
			}
		}
		return url;
	}

	@RequestMapping(value = "/detailProject", method = { RequestMethod.POST, RequestMethod.GET })
	public String detailProject(Model model, HttpSession session, @RequestParam("p_title") String p_title,
			@RequestParam("p_content") String p_content, @RequestParam("p_boardseq") int p_boardseq,
			@RequestParam("p_filename") String p_filename, @RequestParam("p_category") String p_category) {
		String url = "/bitbox/projectView";
		PBoardDTO board = new PBoardDTO();
		board.setP_boardseq(p_boardseq);
		board.setP_title(p_title);
		board.setP_content(p_content);
		board.setP_filename(p_filename);
		board.setP_category(p_category);
		board.setS_id(session.getAttribute("id").toString());
		model.addAttribute("board", board);
		return url;
	}

	@RequestMapping(value = "/calendar", method = { RequestMethod.POST, RequestMethod.GET })
	public String calendar(HttpSession session) {
		String url = "/bitbox/calendar";
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		session.setAttribute("groupList", session.getAttribute("groupList"));
		return url;
	}

	@RequestMapping(value = "/getCalendar", method = RequestMethod.GET)
	public @ResponseBody String getVacation(HttpServletResponse response, HttpSession session) {
		logger.info("Calendar 데이터 접근");
		List<CalendarFormat> data = service.getCalendar(session.getAttribute("id").toString());
		String json = new Gson().toJson(data);
		logger.info(json);
		// Write JSON string.
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		return json;
	}

	@RequestMapping(value = "/getData", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object getData(HttpServletResponse response, HttpSession session) {
		logger.info("Data 筌욊쑴�뿯");
		List<PBoardDTO> data = service.listAll(session.getAttribute("id").toString());
		Map<String, List<PBoardDTO>> map = new HashMap<String, List<PBoardDTO>>();
		map.put("data", data);
		// String json = new Gson().toJson(data);
		logger.info(map.get("data").toString());
		// Write JSON string.
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		return map;
	}

	@RequestMapping(value = "/logout", method = { RequestMethod.POST, RequestMethod.GET })
	public String logout(HttpSession session) {
		String url = "redirect:/login/";
		session.invalidate();
		return url;
	}

	@RequestMapping(value = "/groupRegistForm", method = { RequestMethod.POST, RequestMethod.GET })
	public String groupRegistForm(HttpSession session) {
		String url = "/bitbox/groupRegist";
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		session.setAttribute("groupList", session.getAttribute("groupList"));
		return url;
	}

	@RequestMapping(value = "/groupRegist", method = { RequestMethod.POST, RequestMethod.GET })
	public String groupRegist(HttpSession session, GroupDTO dto) {
		String url = "/bitbox/groupRegist";
		session.setAttribute("id", session.getAttribute("id"));
		String session_id = (String) session.getAttribute("id");
		session.setAttribute("code", session.getAttribute("code"));
		session.setAttribute("groupList", session.getAttribute("groupList"));
		String id = (String) session.getAttribute("id");
		dto.setS_id(id);
		boolean flag = service.groupRegist(dto);
		if (flag) {
			// url = "redirect:/bitbox/group";
			session.removeAttribute("groupList");
			List<GroupDTO> groupList = service.getGroupList(session_id);
			session.setAttribute("groupList", groupList);

			url = "redirect:/bitbox/group";
			String title=dto.getTitle();
			url = "redirect:/git/gitBoard?title="+title+"&status=1";
		}

		return url;
	}

	@RequestMapping(value = "/group", method = { RequestMethod.POST, RequestMethod.GET })
	public String group(Model model, HttpSession session,
			@RequestParam(value = "state", defaultValue = "-1") int state) {
		String url = "";
		// System.out.println("groupJoin: "+id);
		List<GroupDTO> list = service.getGroupList();
		model.addAttribute("list", list);
		url = "/bitbox/group";
		return url;
	}

	@RequestMapping(value = "/modal", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody GroupDTO modal(@RequestParam("gno") String gNo, Model model) {
		// System.out.println("modal: "+gNo);
		GroupDTO modal = service.getGroupModal(gNo);
		// System.out.println("controller: "+modal);

		return modal;
	}

	@RequestMapping(value = "/groupJoin", method = { RequestMethod.POST, RequestMethod.GET })
	public String groupJoin(HttpSession session, GroupDTO group, Model model) {
		// System.out.println("groupJoin Controller: "+group);
		String url = "";
		String id = (String) session.getAttribute("id");
		group.setS_id(id);// 가입하려는 사람의 groupDTO

		GinDTO gIn = new GinDTO(group.getGroup_seq(), id);
		// System.out.println(gIn);

		int state = service.groupJoin(group, gIn);

		if (state == 0) { //group에 대한 repository를 만들기 위한 if문
			//groupLog table에 가입 연산 log남기기
			List<GinDTO> getGMemberList=service.getGroupMember(group);
			ArrayList<GLogDTO> gLogList=new ArrayList<GLogDTO>();
			for(int i=0;i<getGMemberList.size();i++){
				GLogDTO dto=new GLogDTO(getGMemberList.get(i).getS_id(), group.getTitle(), id, "group join", id+"님이 "+group.getTitle()+"그룹에 가입했습니다.");
				gLogList.add(dto);
			}
			System.out.println(gLogList);
			boolean flag=service.insertGLog(gLogList);
			if(flag){
				session.removeAttribute("groupList");
				
				List<GroupDTO> groupList = service.getGroupList(id);
				session.setAttribute("groupList", groupList);
				String title=group.getTitle();
				System.out.println("group in title: "+title);
				url = "redirect:/git/gitBoard?title="+title+"&status=2";
			}
		}else{
			model.addAttribute("state", state);
			url = "redirect:/bitbox/group?state=" + state;
		}

		// System.out.println(state);
		/*
		 * if(state==0){ url="redirect:/bitbox/group"; }else if(state==1){
		 * System.out.println("중복된 가입입니다."); url="redirect:/bitbox/group";
		 * }else{ //state==2 System.out.println("비밀번호 오류입니다.");
		 * url="redirect:/bitbox/group"; }
		 */
		
		// System.out.println("groupJoin: "+id);
		return url;
	}

	@RequestMapping(value = "/groupAlarm", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody List<GLogDTO> groupAlarm(HttpSession session) {
		// System.out.println("alarm call");
		// System.out.println("modal: "+gNo);
		String s_id=(String) session.getAttribute("id");
		List<GLogDTO> list = service.getGLogAlarm(s_id);
		// System.out.println("controller: "+modal);
		return list;
	}
	
	@RequestMapping(value = "/qnaAlarm", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody List<ReQnaDTO> qnaAlarm(HttpSession session) {
		// System.out.println("alarm call");
		// System.out.println("modal: "+gNo);
		String s_id=(String) session.getAttribute("id");
		List<ReQnaDTO> list = service.getReQnaAlarm(s_id);
		//System.out.println("controller reqna list: "+list);
		return list;
	}
	
	@RequestMapping(value = "/qnaState", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody boolean qnaState(@RequestParam("q_seq") int q_seq) {
		boolean flag=service.qnaState(q_seq);
		return flag;
	}
	
	@RequestMapping(value = "/readGLog", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody boolean readGLog(HttpSession session,@RequestParam("log_seq") int log_seq) {
		boolean flag=service.readGLog(log_seq);
		return flag;
	}
	
	@RequestMapping(value = "/uploadFile", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody boolean uploadFile(HttpSession session,@RequestParam("title") String title) {
		String id=(String) session.getAttribute("id");
		GroupDTO group=new GroupDTO();
		group.setS_id(id);
		group.setTitle(title);
		
		List<GinDTO> getGMemberList=service.getGroupMember(group);
		ArrayList<GLogDTO> gLogList=new ArrayList<GLogDTO>();
		for(int i=0;i<getGMemberList.size();i++){
			GLogDTO dto=new GLogDTO(getGMemberList.get(i).getS_id(), group.getTitle(), id, "file upload", id+"님이 "+group.getTitle()+"에 파일을 업로드 했습니다.");
			gLogList.add(dto);
		}
		System.out.println(gLogList);
		boolean flag=service.insertGLog(gLogList);
		return flag;
	}
	
	@RequestMapping(value = "/qna", method = { RequestMethod.POST, RequestMethod.GET })
	public String qna(HttpSession session, Model model, @RequestParam(value = "page", defaultValue = "0") int page) {
		String url = "/bitbox/qna";
		List<QnaDTO> qnaList = service.getQnaList(page);
		ArrayList<String> pageList = service.getQnaPageList(page);
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("pageList", pageList);
		model.addAttribute("page", page);
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		session.setAttribute("groupList", session.getAttribute("groupList"));
		return url;
	}

	@RequestMapping(value = "/readQna", method = { RequestMethod.POST, RequestMethod.GET })
	public String readQna(HttpSession session, Model model, @RequestParam("page") int page,
			@RequestParam("q_seq") int q_seq) {
		String url = "/bitbox/qnaView";
		QnaDTO qnaList = service.detailQna(q_seq);
		List<ReQnaDTO> replyList = service.getReplyList(q_seq);
		String replyUser = service.getReplyUser((String) session.getAttribute("id"));
		model.addAttribute("replyList", replyList);
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("replyUser", replyUser);
		model.addAttribute("page", page);
		return url;
	}

	@RequestMapping(value = "/createQ", method = { RequestMethod.POST, RequestMethod.GET })
	public String createQ(HttpSession session) {
		String url = "/bitbox/qnaRegistForm";
		return url;
	}

	@RequestMapping(value = "/question", method = { RequestMethod.POST, RequestMethod.GET })
	public String question(HttpSession session, MultipartFile q_upload, QnaDTO qna) {
		String url = "";
		String path = this.path;
		String fileName = null;
		qna.setS_id((String) session.getAttribute("id"));
		QnaDTO dto = qna;
		boolean flag = false;
		if (q_upload == null) {
			flag = service.registQna(dto);
		} else {
			fileName = q_upload.getOriginalFilename();
			try {
				q_upload.transferTo(new File(path + fileName));
				dto.setS_id(session.getAttribute("id").toString());
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			flag = service.registQna(dto);
		}
		if (flag) {
			url = "redirect:/bitbox/qna";
		}
		return url;
	}

	@RequestMapping(value = "/qnaUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	public String qnaUpdate(HttpSession session, @RequestParam("page") int page, Model model, QnaDTO qna) {
		String url = "";
		boolean flag = service.qnaUpdate(qna);
		if (flag) {
			url = "redirect:/bitbox/qna";
		}
		model.addAttribute("page", page);
		return url;
	}

	@RequestMapping(value = "/qnaDelete", method = { RequestMethod.POST, RequestMethod.GET })
	public String qnaDelete(HttpSession session, @RequestParam("page") int page, Model model,
			@RequestParam("q_seq") int q_seq) {
		String url = "";
		boolean flag = service.qnaDelete(q_seq);
		if (flag) {
			url = "redirect:/bitbox/qna";
		}
		model.addAttribute("page", page);
		return url;
	}

	@RequestMapping(value = "/registReply", method = { RequestMethod.POST, RequestMethod.GET })
	public String registReply(HttpSession session, ReQnaDTO reply, @RequestParam("page") int page,
			@RequestParam("q_seq") int q_seq) {
		String url = null;
		boolean flag = service.registReply(reply);
		if (flag) {
			url = "redirect:/bitbox/readQna?page=" + page + "&q_seq=" + q_seq;
		}
		return url;
	}

	@RequestMapping(value = "/diff", method = RequestMethod.GET)
	public String diff() {
		String url = "/bitbox/diff";
		return url;
	}

	@RequestMapping(value = "/read", method = RequestMethod.POST)
	public @ResponseBody String read(@RequestParam("file") MultipartFile file, Model model) {
		// String url ="";
		// MultipartFile file = (MultipartFile) uploadfile;
		StringBuffer temp = service.readFile(file);
		String list = null;
		if (temp != null) {
			model.addAttribute("list", list);
		} else {
			temp.append("no Text");
		}
		list = temp.toString();
		// url="/bitbox/test2";
		return list;
	}

	@RequestMapping(value = "/registMinutesForm", method = { RequestMethod.POST, RequestMethod.GET })
	public String minutes(HttpSession session, @RequestParam("group_seq") int group_seq,
			@RequestParam("group_title") String group_title, Model model) {
		String url = "/bitbox/registMinutes";
		ArrayList<String> member = service.getMember(group_seq);
		model.addAttribute("group_title", group_title);
		model.addAttribute("group_seq", group_seq);
		model.addAttribute("member", member);
		return url;
	}

	@RequestMapping(value = "/registMinutes", method = { RequestMethod.POST, RequestMethod.GET })
	public String registMinutes(HttpSession session, MinutesDTO minutes, @RequestParam("member") String[] nameList,
			@RequestParam("group_title") String group_title, @RequestParam("group_seq") int group_seq, Model model) {
		String url = "";
		String id=(String) session.getAttribute("id");
		GroupDTO group=new GroupDTO();
		group.setS_id(id);
		group.setTitle(group_title);
		
		List<GinDTO> getGMemberList=service.getGroupMember(group);
		ArrayList<GLogDTO> gLogList=new ArrayList<GLogDTO>();
		for(int i=0;i<getGMemberList.size();i++){
			GLogDTO dto=new GLogDTO(getGMemberList.get(i).getS_id(), group.getTitle(), id, "write meeting", id+"님이 "+group.getTitle()+"에 회의록을 작성했습니다.");
			gLogList.add(dto);
		}
		//System.out.println(gLogList);
		boolean flags=service.insertGLog(gLogList);
		if(flags){
			StringBuffer sb = new StringBuffer();
			sb.append(nameList[0]);
			if (nameList.length > 1) {
				for (int i = 1; i < nameList.length; i++) {
					sb.append("," + nameList[i]);
				}
			}
			minutes.setMin_attendee(sb.toString());
			boolean flag = service.registMinutes(minutes);
			if (flag) {
				url = "redirect:/bitbox/minutesList?group_seq=" + minutes.getGroup_seq() + "&group_title=" + group_title;
			}
		}
		return url;
	}

	@RequestMapping(value = "/minutesList", method = { RequestMethod.POST, RequestMethod.GET })
	public String minutesList(HttpSession session, @RequestParam(value="group_seq",defaultValue="0") int group_seq,
			@RequestParam("group_title") String group_title, Model model,
			@RequestParam(value = "page", defaultValue = "0") int page) {
		String url="";
		if(group_seq==0){
			group_seq=service.getGroupSeq(group_title);
		}
		url= "/bitbox/minutesList";
		List<MinutesDTO> list = service.minutesList(group_seq, page);
		ArrayList<String> mPageList = service.getMinutesPageList(group_seq, page, group_title);
		model.addAttribute("list", list);
		model.addAttribute("mPageList", mPageList);
		model.addAttribute("group_seq", group_seq);
		model.addAttribute("group_title", group_title);
		model.addAttribute("page", page);
		return url;
	}

	@RequestMapping(value = "/minutesView", method = { RequestMethod.POST, RequestMethod.GET })
	public String minuteView(HttpSession session, @RequestParam("seq") int seq,
			@RequestParam("group") String group_title, Model model, @RequestParam("page") int page) {
		String url = "/bitbox/minutesView";
		MinutesDTO minutes = service.readMinutes(seq);
		model.addAttribute("minutes", minutes);
		model.addAttribute("group_title", group_title);
		model.addAttribute("page", page);
		return url;
	}

	@RequestMapping(value = "/minutesUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	public String minuteUpdate(HttpSession session, MinutesDTO minutes, @RequestParam("group_title") String group_title,
			Model model, @RequestParam("page") int page) {
		String url = "";
		String id=(String) session.getAttribute("id");
		GroupDTO group=new GroupDTO();
		group.setS_id(id);
		group.setTitle(group_title);
		
		List<GinDTO> getGMemberList=service.getGroupMember(group);
		ArrayList<GLogDTO> gLogList=new ArrayList<GLogDTO>();
		for(int i=0;i<getGMemberList.size();i++){
			GLogDTO dto=new GLogDTO(getGMemberList.get(i).getS_id(), group.getTitle(), id, "write meeting", id+"님이 "+group.getTitle()+"에 회의록을 수정했습니다.");
			gLogList.add(dto);
		}
		//System.out.println(gLogList);
		boolean flags=service.insertGLog(gLogList);
		if(flags){
			boolean flag = service.updateMinutes(minutes);
			if (flag) {
				url = "redirect:/bitbox/minutesView?seq=" + minutes.getMin_seq() + "&group=" + group_title + "&page="
						+ page;
			}
		}
		return url;
	}

	@RequestMapping(value = "/minutesDelete", method = { RequestMethod.POST, RequestMethod.GET })
	public String minuteDelete(HttpSession session, MinutesDTO minutes, @RequestParam("group_title") String group_title,
			Model model, @RequestParam("page") int page) {
		String url = "";
		String id=(String) session.getAttribute("id");
		GroupDTO group=new GroupDTO();
		group.setS_id(id);
		group.setTitle(group_title);
		
		List<GinDTO> getGMemberList=service.getGroupMember(group);
		ArrayList<GLogDTO> gLogList=new ArrayList<GLogDTO>();
		for(int i=0;i<getGMemberList.size();i++){
			GLogDTO dto=new GLogDTO(getGMemberList.get(i).getS_id(), group.getTitle(), id, "write meeting", id+"님이 "+group.getTitle()+"에 회의록을 삭제했습니다.");
			gLogList.add(dto);
		}
		//System.out.println(gLogList);
		boolean flags=service.insertGLog(gLogList);
		if(flags){
			boolean flag = service.deleteMinutes(minutes.getMin_seq());
			if (flag) {
				url = "redirect:/bitbox/minutesList?group_seq=" + minutes.getGroup_seq() + "&group_title=" + group_title
						+ "&page=" + page;
			}
		}
		return url;
	}

	@RequestMapping(value = "/minutesDownload", method = { RequestMethod.POST, RequestMethod.GET })
	public String minutesDownload(MinutesDTO minutes, @RequestParam("group_title") String group_title, Model model) {
		String url = "/bitbox/download";
		// 줄바꿈처리
		minutes.setMin_content(service.enter(minutes.getMin_content()));
		minutes.setMin_opinion(service.enter(minutes.getMin_opinion()));
		minutes.setMin_schedule(service.enter(minutes.getMin_schedule()));
		minutes.setMin_decide(service.enter(minutes.getMin_decide()));
		minutes.setMin_prepare(service.enter(minutes.getMin_prepare()));

		model.addAttribute("data", minutes);
		model.addAttribute("title", group_title);
		return url;
	}

	@RequestMapping(value = "/gitBoard", method = RequestMethod.GET)
	public String gitBoard(@RequestParam("title") String title) {
		System.out.println("gitBoard controller: " + title);
		String url = "/bitbox/gitBoard";

		return url;
	}

	@RequestMapping(value = "/myPage", method = { RequestMethod.POST, RequestMethod.GET })
	public String myPage(HttpSession session, Model model) {
		String url = "/bitbox/myPage";
		StudentDTO student = service.login((String)session.getAttribute("id"));
		model.addAttribute("student",student);
		String class_name = service.getClassName(student.getS_class_code());
		model.addAttribute("class_name",class_name);
		
		return url;
	}

	@RequestMapping(value = "/myUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	public String myUpdate(HttpServletRequest req, @RequestParam("profile_img") MultipartFile profile_img,
			HttpSession session, StudentDTO dto) {
		System.out.println("controller in");
		String url = "";
		String path = "C:\\dev\\image\\";
		System.out.println("dto  : " + dto.toString());
		System.out.println("file : " + profile_img.toString());
		String fileName = profile_img.getOriginalFilename();
		UUID uuidname = UUID.randomUUID();
		try {
			File directory = new File(path);
			if(!directory.exists()){
				directory.mkdirs();// 파일경로 없으면 생성
			}
			profile_img.transferTo(new File(path + uuidname.toString() + "_" + fileName));
			dto.setS_img(fileName);
			dto.setS_uuid_img(uuidname.toString() + "_" + fileName);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		boolean flag = service.myUpdate(dto);
		if (flag) {
			session.removeAttribute("img");
			session.setAttribute("img", uuidname.toString() + "_" + fileName);
			url = "redirect:/bitbox/myPage";
		}

		return url;
	}

	@RequestMapping(value = "/ganttForm", method = { RequestMethod.POST, RequestMethod.GET })
	public String myPage(HttpSession session, @RequestParam("group_seq") int group_seq,
			@RequestParam("group_title") String group_title, Model model) {
		String url = "/bitbox/ganttForm";
		GanttDTO gantt = service.chart(group_seq);
		model.addAttribute("gantt", gantt);
		model.addAttribute("group_title", group_title);
		return url;
	}

	@RequestMapping(value = "/saveGantt", method = { RequestMethod.POST, RequestMethod.GET })
	public String saveGantt(HttpSession session, @RequestParam("group_title") String group_title, GanttDTO gantt) {
		String url = "";
		boolean flag = service.saveGantt(gantt);
		if (flag) {
			url = "redirect:/bitbox/ganttForm?group_title=" + group_title + "&group_seq=" + gantt.getGroup_seq();
		}
		return url;
	}

	@RequestMapping(value = "/exportExcel", method = { RequestMethod.POST, RequestMethod.GET })
	public String exportExcel(Model model, @RequestParam("data") String data,
			@RequestParam("extension") String extension) {
		String url = "/bitbox/export";
		model.addAttribute("data", data);
		model.addAttribute("extension", extension);
		return url;
	}
	
	@RequestMapping(value = "/addTodo", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody ArrayList<String> addTodo(HttpSession session, @RequestParam("text") String text) {
		TodoDTO dto = new TodoDTO(text, (String) session.getAttribute("id"));
		ArrayList<String> todoList = service.todoList(dto);
		return todoList;
	}

	@RequestMapping(value = "/getTodoList", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody ArrayList<String> getTodoList(HttpSession session) {
		ArrayList<String> todoList = service.getTodoList((String) session.getAttribute("id"));
		return todoList;
	}

	@RequestMapping(value = "/deleteAll", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody String deleteAll(HttpSession session) {
		String todoList = null;
		boolean flag = service.deleteAll((String) session.getAttribute("id"));
		if (flag) {
			todoList = "<tr><td class=\"inp\"><input class=\"form-control\" id=\"todoText\" placeholder=\"Input TODO\""
					+ "type=\"text\"></td><td style=\"padding-right: 15px; padding-left: 15px\"><button id=\"todoButton\" class=\"btn btn-primary\">Add</button></td>"
					+ "<td><button id=\"todoDeleteAll\" class=\"btn btn-danger\">Delete all</button></td></tr>";
		}
		return todoList;
	}

	@RequestMapping(value = "/deleteLine", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody ArrayList<String> deleteLine(HttpSession session, @RequestParam("seq") int seq) {
		boolean flag = service.deleteLine(seq);
		ArrayList<String> todoList = null;
		if (flag) {
			todoList = service.getTodoList((String) session.getAttribute("id"));
		}
		return todoList;
	}
	
	@RequestMapping(value = "/recent_Down", method = { RequestMethod.POST, RequestMethod.GET })
	public String recentDownload(@RequestParam("group_seq") int group_seq, Model model,HttpServletResponse response) {
		String url = "/bitbox/download";
		// 줄바꿈처리
		MinutesDTO minutes = service.getRecentMinutes(group_seq);
		if(minutes==null){
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out;
				out = response.getWriter();
				out.println("<script>alert('error : 회의록이 존재하지 않습니다');</script>");
				out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			url = "/bitbox/home";
		}else{
			String group_title = service.getGroupTitle(group_seq);
			System.out.println("in : "+minutes);
			minutes.setMin_content(service.enter(minutes.getMin_content()));
			minutes.setMin_opinion(service.enter(minutes.getMin_opinion()));
			minutes.setMin_schedule(service.enter(minutes.getMin_schedule()));
			minutes.setMin_decide(service.enter(minutes.getMin_decide()));
			minutes.setMin_prepare(service.enter(minutes.getMin_prepare()));
	
			model.addAttribute("data", minutes);
			model.addAttribute("title", group_title);
			
		}
		return url;
	}
	@RequestMapping(value = "/pdfCreate", method = { RequestMethod.POST, RequestMethod.GET })
	public String pdfCreate(HttpServletRequest req,HttpServletResponse response,MinutesDTO minutes, @RequestParam("group_title") String group_title, Model model){
		String url = "/bitbox/home";
		
		PdfService pdf = new PdfService();
		url = pdf.makePDF(minutes, group_title);
		
//		try {
//			response.setContentType("text/html; charset=UTF-8");
//			PrintWriter out;
//			out = response.getWriter();
//			out.println("<script>alert('c:/dev/pdf에 저장되었습니다.');</script>");
//			out.flush();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
	    //System.out.println(url);
	    return "redirect:"+url;
	    
//	    return url;
	}
	
	@RequestMapping(value = "/recent_Pdf", method = { RequestMethod.POST, RequestMethod.GET })
	public String recentPdf(@RequestParam("group_seq") int group_seq, Model model,HttpServletResponse response) {
		String url = "";
		// 줄바꿈처리
		MinutesDTO minutes = service.getRecentMinutes(group_seq);
		if(minutes==null){
			//회의록이 없을경우
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out;
				out = response.getWriter();
				out.println("<script>alert('error : 회의록이 존재하지 않습니다');</script>");
				out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			url = "/bitbox/home";
		}else{
			String group_title = service.getGroupTitle(group_seq);
			PdfService pdf = new PdfService();
			url = pdf.makePDF(minutes, group_title);
			
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out;
				out = response.getWriter();
				out.println("<script>alert('회의록은 C:/dev/pdf 에 저장되었습니다.');</script>");
				out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			url = "/bitbox/home";
		}
		return url;
	}
	
	@RequestMapping(value = "/getSubject", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody ArrayList<SubjectFormat> getSubject(HttpSession session) {
		int code=(int) session.getAttribute("code");
		ArrayList<SubjectFormat> subjectList =service.getSubject(code);
		return subjectList;
	}
	@RequestMapping(value = "/getSubSubject", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody ArrayList<SubjectFormat> getSubSubject(HttpSession session,@RequestParam("subject")String subject) {
		ArrayList<SubjectFormat> sub_subject=service.getsubSubject(subject);	
		return sub_subject;
	}
	
	@RequestMapping(value = "/getSubjectDate", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody ArrayList<SubjectFormat> getSubjectDate(HttpSession session,@RequestParam("subject")String subject) {
		System.out.println(subject);
		int code=(int) session.getAttribute("code");
		SubjectDateFormat dateFormat=new SubjectDateFormat();
		dateFormat.setSubject(subject);
		dateFormat.setCode(code);
		ArrayList<SubjectFormat> date=service.getDate(dateFormat);		
		return date;
	}
	@RequestMapping(value = "/titleCheck", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody boolean titleCheck(@RequestParam("title")String title) {
		boolean flag=false;
		int seq=service.getGroupSeq(title);
		if(seq>0){ //해당 title에 대한 그룹이 있으니까 seq가 0보다 크다.
			flag=true;
		}
		//title seq가 0과 같다면 해당 title을 가진 그룹이 없다라고 판단.
		return flag;
	}
}
