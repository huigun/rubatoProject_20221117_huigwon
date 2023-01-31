package com.huigwon.rubato.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.huigwon.rubato.dao.IDao;
import com.huigwon.rubato.dto.RFBoardDto;
import com.huigwon.rubato.dto.RFBrownum;
import com.huigwon.rubato.dto.RReplyDto;
import com.huigwon.rubato.dto.RubaFilesDto;

@Controller
public class HomeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/")
	public String home() {
		return "redirect:index.html";
	}
	
	@RequestMapping(value="index.html")
	public String index(Model model) {

		IDao dao = sqlSession.getMapper(IDao.class);

		ArrayList<RFBoardDto> dto = dao.rfblist(1,5);
		
		model.addAttribute("fb01", dto.get(0));
		model.addAttribute("fb02", dto.get(1));
		model.addAttribute("fb03", dto.get(2));
		model.addAttribute("fb04", dto.get(3));

		return "index";
	}
	
	@RequestMapping(value="board_list.html")
	public String board_list(HttpServletRequest request, Model model) {
		String pagesu = null;
		String pagepage = null;
		ArrayList<RFBoardDto> dto = null;
		pagesu = request.getParameter("pagesu");
		IDao dao = sqlSession.getMapper(IDao.class);
		if(pagesu == null) {
			pagesu = "1";
			dto = dao.rfblist(1,5);
			int intpagesu = Integer.parseInt(pagesu);
			
		} else {
			int pagesu2 = Integer.parseInt(pagesu);
			for(int i=0;i<pagesu2;i++) {
			int firstgl = i*5+1;
			int lastgl = i*5+5;
			dto = dao.rfblist(firstgl,lastgl);
			}
		}
		
		ArrayList<RFBrownum> rownum = dao.rfbrownum();
		
//		System.out.println(pagesu);
		
		
		int lastsu = rownum.get(0).getRownum();
		// lastsu : 마지막 글 넘버
//		System.out.println("lastsu = " + lastsu);
		
		int glnum = 0;
		int page = (lastsu/5)+1;
		// page : 한 페이지당 5개의 글일때, 페이지 수
		System.out.println("page = " + page);
		int glpage= 1;
		for(int i=0;i<lastsu;i++) {
			glnum = rownum.get(i).getRownum();			
			// i번째 글의 row num
			int glbunho = i+1;
//			System.out.println((i+1) +"번째 글 glbunho = " + glbunho);
			if(glbunho%5==1 && glbunho >5) {
				glpage = glpage+1;
//				System.out.println(glpage);
				}

		}
		int pagepage2 = 0;
		pagepage = request.getParameter("pagepage");
//		System.out.println(pagepage);
		if(pagepage == null) {
			int firstgl = 1;
			int lastgl =5;
			pagepage2 =1;
			model.addAttribute("firstgl", firstgl);
			model.addAttribute("lastgl", lastgl);
			model.addAttribute("pagesu", lastgl);
			model.addAttribute("pagepage", pagepage2);
		} else {
			pagepage2 = Integer.parseInt(pagepage);
			for(int i=0;i<pagepage2;i++) {
			int firstgl = i*5+1;
			int lastgl = i*5+5;
			model.addAttribute("firstgl", firstgl);
			model.addAttribute("lastgl", lastgl);
			model.addAttribute("pagepage", pagepage2);
			}
		}
		int pagepagesu = page/5;
		System.out.println(pagepagesu);
		int rfbcount = dao.rfboardcount();
		model.addAttribute("dto",dto);
		model.addAttribute("rownum", rownum);
		model.addAttribute("glnum", glnum);		
		model.addAttribute("rfbcount", rfbcount);
		model.addAttribute("page", glpage);
		model.addAttribute("ppsu", pagepagesu);
		model.addAttribute("checkpage", page);
		return "board_list";
	}
	
	@RequestMapping(value="board_view.html")
	public String board_view(HttpServletRequest request, Model model) {
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String rfbnum = request.getParameter("rfbnum");
		
//		System.out.println("view" + rrlist);
		ArrayList<RReplyDto> rrlist =  dao.rrlist(rfbnum);
		 dao.rfbhit(rfbnum);
		 RFBoardDto dto = dao.rfbview(rfbnum);
		 RubaFilesDto filedto = dao.getfileinfo(rfbnum);
//		System.out.println(filedto.getBoardnum());
		
		model.addAttribute("dto", dto);
		model.addAttribute("rrlist", rrlist);
		if(filedto!=null) {	
		model.addAttribute("filedto", filedto);
		} else {
			filedto = null;
		}
		return "board_view";
	}
	
	@RequestMapping(value="board_write.html")
	public String board_write() {
		
		return "board_write";
	}
	
	@RequestMapping(value="member_join")
	public String member_join() {
		return "member_join";
	}
	
	@RequestMapping(value="delete")
	public String delete(HttpServletRequest request) {

		String rfbnum = request.getParameter("rfbnum");

			IDao dao = sqlSession.getMapper(IDao.class);
					dao.rfbdelete(rfbnum);
		return "redirect:board_list.html";
	}
	
	
	
	@RequestMapping(value="joinOk")
	public String joinOk(HttpServletRequest request, HttpSession session) {
		
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mname = request.getParameter("mname");
		String memail = request.getParameter("memail");
		
		dao.joinMember(mid, mpw, mname, memail);
		
		session.setAttribute("sessionId", mid);
		
		return "redirect:index.html";
	}
	
	@RequestMapping(value="loginOk")
	public String loginOk(HttpServletRequest request, HttpSession session) {
		
		IDao dao = sqlSession.getMapper(IDao.class);
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		
		int checkIdFalg = dao.checkUserIdAndPw(mid, mpw);
		if(checkIdFalg == 1) {
			session.setAttribute("sessionId", mid);
		}
		
		return "redirect:index.html";
	}
	
	@RequestMapping(value="logOut")
	public String logOut(HttpSession session) {
		session.invalidate();
				
		return "redirect:index.html";
	}
	
	@RequestMapping(value="writeOk")
	public String writeOk(HttpServletRequest request, HttpSession session,Model model, @RequestPart MultipartFile files) throws IllegalStateException, IOException {
		
		String rfbname = request.getParameter("rfbname");	
		String rfbtitle = request.getParameter("rfbtitle");	
		String rfbcontent = request.getParameter("rfbcontent");	
		String rfbid = (String) session.getAttribute("sessionId");
		System.out.println("0");
		
		IDao dao = sqlSession.getMapper(IDao.class);
		if(files.isEmpty()) { // 파일의 첨부여부 확인
			dao.rfbwrite(rfbname, rfbtitle, rfbcontent, rfbid);
		} else {
			dao.rfbwrite(rfbname, rfbtitle, rfbcontent, rfbid);
			ArrayList<RFBoardDto> latestboard = dao.boardlatestinfo(rfbid);
			RFBoardDto dto = latestboard.get(0);
			int rfbnum = dto.getRfbnum();
			// 파일첨부
			String fileoriname = files.getOriginalFilename(); // 첨부된 파일의 원래 이름
			String fileextension = FilenameUtils.getExtension(fileoriname).toLowerCase();
			// 첨부된 파일의 확장자 추출 후 소문자로 강제 변경
			File destinationFile; // java.io 패키지 제공 클래스 임포트
			String destinationFileName; // 실제 서버에 젖아된 파일의 변경된 이름이 저장될 변수 선언
			String fileurl= "D:/springboot_workspace/rubatoProject_20221117_huigwon/src/main/resources/static/uploadfiles/";
			// 첨부된 파일이 저장된 서버의 실제 폴더 경로
			
			destinationFileName = RandomStringUtils.randomAlphanumeric(32)+ "." + fileextension;
			// 알파벳대소문자 + 숫자로 랜덤한 32자의 문자열 생성 후 , .을 구분자로 원본 파일의 확장자를 연결 = 실제 서버에 저장되는 파일의 이름
			destinationFile = new File(fileurl+destinationFileName);
			destinationFile.getParentFile().mkdir();
			files.transferTo(destinationFile); // 파일을 업로드
			dao.fileinfoinsert(rfbnum, fileoriname, destinationFileName, fileextension, fileurl);
		}
		
		
		return "redirect:board_list.html";
	}
	
	@RequestMapping(value="replyOk")
	public String replyOk(HttpServletRequest request, HttpSession session, Model model, RedirectAttributes redircet) {

		String rrorinum = request.getParameter("rfbnum");
		String rrcontent = request.getParameter("rrcontent");
		String rrid = (String) session.getAttribute("sessionId");
	
		IDao dao = sqlSession.getMapper(IDao.class);
		dao.rrwrite(rrorinum, rrid, rrcontent);
		dao.rrcount(rrorinum);
		ArrayList<RReplyDto> rrdto = dao.rrlist(rrorinum);
		
		model.addAttribute("rrcontent", rrcontent);
		redircet.addAttribute("rfbnum", rrorinum);

		return "redirect:board_view.html";
	}
	
	@RequestMapping(value="rrdelete")
	public String rrdelete(HttpServletRequest request, RedirectAttributes redircet) {

			String rrnum = request.getParameter("rrnum");
			String rfbnum = request.getParameter("rfbnum");
			IDao dao = sqlSession.getMapper(IDao.class);

			dao.rrdelete(rrnum);
			dao.rrcount2(rfbnum);
			
			redircet.addAttribute("rfbnum", rfbnum);

		return "redirect:board_view.html";
	}
	
	@RequestMapping(value="search_list")
	public String search_list(HttpServletRequest request, Model model) {
		
		IDao dao = sqlSession.getMapper(IDao.class);
		ArrayList<RFBoardDto> dtos = null;
		String searchkey = request.getParameter("searchkey");
		String searchoption= request.getParameter("searchoption");
		if(searchoption.equals("title")) {
			searchoption="title";
			dtos = dao.rfbSearchTitleList(searchkey);
		} else if(searchoption.equals("content")) {	
			searchoption="content";
			dtos = dao.rfbSearchcontentList(searchkey);
		} else if(searchoption.equals("writer")) {
			searchoption="writer";
			dtos = dao.rfbSearchwriterList(searchkey);
		}
		
		model.addAttribute("dto",dtos);
		model.addAttribute("boardcount", dtos.size());		
		
		return "board_list";
	}
}
