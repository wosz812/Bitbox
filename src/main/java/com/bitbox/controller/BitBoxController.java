package com.bitbox.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bitbox.dto.CalendarFormat;
import com.bitbox.dto.GinDTO;
import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.PBoardDTO;
import com.bitbox.dto.QnaDTO;
import com.bitbox.dto.ReQnaDTO;
import com.bitbox.service.IBitboxService;
import com.google.gson.Gson;

@RequestMapping(value = "/bitbox")

@Controller
public class BitBoxController {
	//지원
	//대성
	//대성1지연이
	//대성1
	//대성 test
	String path = "c:\\dev\\";

	@Autowired
	private IBitboxService service;

	private static final Logger logger = LoggerFactory.getLogger(BitBoxController.class);

	@RequestMapping(value = "/home", method = { RequestMethod.POST, RequestMethod.GET })
	public String index(HttpSession session) {
		String url = "/bitbox/home";
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		session.setAttribute("groupList", session.getAttribute("groupList"));
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
		UUID uuidname=UUID.randomUUID();
		try {
			p_filename.transferTo(new File(path + uuidname.toString()+"_"+fileNames));
			board.setP_title(p_title);
			board.setP_content(p_content);
			board.setP_category(p_category);
			board.setP_filename(fileNames);
			board.setP_uuidname(uuidname.toString()+"_"+fileNames);
			board.setS_id(session.getAttribute("id").toString());
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
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
		PBoardDTO board=service.finduuidname(p_boardseq);
		logger.info("file seq or uuidname is {}",p_boardseq +","+board.getP_uuidname());
		String filename=board.getP_uuidname();
		header.setContentDispositionFormData("name", filename);
		header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		
		return ResponseEntity.ok().headers(header).body(new FileSystemResource(new File(path + filename)));
	}

	@RequestMapping(value = "/projectUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	public String projectUpdate(HttpSession session, @RequestParam("p_title") String p_title,
			@RequestParam("p_content") String p_content, @RequestParam("p_boardseq") int p_boardseq,@RequestParam(value="cal",defaultValue="")String cal) {
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
			if(cal.equals("cal")){
				url = "redirect:/bitbox/calendar";
			}else{
			url = "redirect:/bitbox/listAll";
			}
		}
		return url;
	}
	
	@RequestMapping(value = "/projectDelete", method = { RequestMethod.POST, RequestMethod.GET })
	public String projectDelete(HttpSession session, @RequestParam("p_title") String p_title,
			@RequestParam("p_content") String p_content, @RequestParam("p_boardseq") int p_boardseq,@RequestParam(value="cal",defaultValue="")String cal) {
		String url = "";
		boolean flag = false;
		PBoardDTO board = new PBoardDTO();
		board.setP_boardseq(p_boardseq);		
		board.setS_id(session.getAttribute("id").toString());
		logger.info(p_boardseq + "," + session.getAttribute("id").toString());
		flag = service.projectDelete(board);
		if (flag) {
			if(cal.equals("cal")){
				url = "redirect:/bitbox/calendar";
			}else{
			url = "redirect:/bitbox/listAll";
			}
		}
		return url;
	}
	@RequestMapping(value = "/detailProject", method = { RequestMethod.POST, RequestMethod.GET })
	public String detailProject(Model model,HttpSession session,@RequestParam("p_title") String p_title,
			@RequestParam("p_content") String p_content, @RequestParam("p_boardseq") int p_boardseq,
			@RequestParam("p_filename") String p_filename,@RequestParam("p_category") String p_category){
		String url="/bitbox/projectView";	
		PBoardDTO board=new PBoardDTO();
		board.setP_boardseq(p_boardseq);
		board.setP_title(p_title);
		board.setP_content(p_content);
		board.setP_filename(p_filename);
		board.setP_category(p_category);	
		board.setS_id(session.getAttribute("id").toString());
		model.addAttribute("board",board);
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
		Object session_code = session.getAttribute("code");
		session.setAttribute("groupList", session.getAttribute("groupList"));
		String id = (String) session.getAttribute("id");
		dto.setS_id(id);
		boolean flag = service.groupRegist(dto);
		if (flag) {
			//url = "redirect:/bitbox/group";
			session.removeAttribute("groupList");
			List<GroupDTO> groupList = service.getGroupList(session_id);
			session.setAttribute("groupList", groupList);
			
			url = "redirect:/bitbox/group";
		}

		return url;
	}

	@RequestMapping(value = "/group", method = { RequestMethod.POST, RequestMethod.GET })
	public String group(Model model, HttpSession session,
			@RequestParam(value = "state", defaultValue = "-1") int state) {
		String url = "";
		String id = session.getId();
		// System.out.println("groupJoin: "+id);
		List<GroupDTO> list = service.getGroupList();
		model.addAttribute("list", list);
		url = "/bitbox/group";
		return url;
	}

	@RequestMapping(value = "/modal", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody GroupDTO modal(@RequestParam("gno") String gNo, Model model) {
		String url = "";
		// System.out.println("modal: "+gNo);
		GroupDTO modal = service.getGroupModal(gNo);
		// System.out.println("controller: "+modal);

		return modal;
	}

	@RequestMapping(value = "/groupJoin", method = { RequestMethod.POST, RequestMethod.GET })
	   public String groupJoin(HttpSession session, GroupDTO group, Model model) {
	      //System.out.println("groupJoin Controller: "+group);
	      String url = "";
	      String id = (String) session.getAttribute("id");
	      group.setS_id(id);// 가입하려는 사람의 groupDTO
 
	      GinDTO gIn = new GinDTO(group.getGroup_seq(), id);
	      //System.out.println(gIn);

	      int state = service.groupJoin(group, gIn);
	      
	      if(state==0){
	    	  session.removeAttribute("groupList");
	    	  List<GroupDTO> groupList = service.getGroupList(id);
	    	  session.setAttribute("groupList", groupList);
	      }
	      
	      //System.out.println(state);
	      /*
	       * if(state==0){ url="redirect:/bitbox/group"; }else if(state==1){
	       * System.out.println("중복된 가입입니다."); url="redirect:/bitbox/group";
	       * }else{ //state==2 System.out.println("비밀번호 오류입니다.");
	       * url="redirect:/bitbox/group"; }
	       */
	      model.addAttribute("state", state);
	      url = "redirect:/bitbox/group?state="+state;
	      // System.out.println("groupJoin: "+id);
	      return url;
	   }
	@RequestMapping(value = "/alarm", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody int alarm() {
		String url = "";
		//System.out.println("alarm call");
		// System.out.println("modal: "+gNo);
		int cnt=service.getCnt();
		// System.out.println("controller: "+modal);

		return cnt;
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
		System.out.println("readQna / replyList : " + replyList);
		model.addAttribute("replyList", replyList);
		model.addAttribute("qnaList", qnaList);
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

}
