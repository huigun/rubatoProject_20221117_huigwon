package com.huigwon.rubato.dao;

import java.util.ArrayList;

import com.huigwon.rubato.dto.RFBoardDto;
import com.huigwon.rubato.dto.RFBrownum;
import com.huigwon.rubato.dto.RMemberDto;
import com.huigwon.rubato.dto.RReplyDto;
import com.huigwon.rubato.dto.RubaFilesDto;

public interface IDao {
	
	// 멤버 관련
	public void joinMember(String mid, String mpw, String mname, String memail); // 회원 가입
	public int checkUserId(String mid); // 아이디 체크
	public int checkUserIdAndPw(String mid, String mpw); // 아이디,비밀번호 체크
	
	// 게시글 관련
	public void rfbwrite(String rfbname, String rfbtitle, String rfbcontent, String rfbid); // 글 작성
	public ArrayList<RFBoardDto> rfblist(); // 글 리스트
	public ArrayList<RFBoardDto> rfblist(int firstgl, int pagesu); // 글 리스트
	public RFBoardDto rfbview(String rfbnum); // 글 보기
	public void rfbdelete(String rfbnum); // 글 삭제
	public void rfbhit(String rfbnum); // 글 조회수
	public int rfboardcount(); // 글 갯수 
	public ArrayList<RFBrownum> rfbrownum();  
	
	// 댓글 관련
	public void rrwrite(String rrorinum, String rrid, String rrcontent); // 새 댓글 입력 insert
	public ArrayList<RReplyDto> rrlist(String rrorinum); // 해당글의 댓글 리스트
	public void rrcount(String rrorinum);
	public void rrcount2(String rrorinum);
	public void rrdelete(String rrnum);
	
	// 게시판 검색 관련
	public ArrayList<RFBoardDto> rfbSearchTitleList(String searchkey);
	public ArrayList<RFBoardDto> rfbSearchcontentList(String searchkey);
	public ArrayList<RFBoardDto> rfbSearchwriterList(String searchkey);
	
	// 파일 업로드 관련
	public void fileinfoinsert(int boardnum, String fileoriname, String filename, String fileextension, String fileurl);
	public ArrayList<RFBoardDto> boardlatestinfo(String rfbid);
	public RubaFilesDto getfileinfo(String boardnum); // 파일이 첨부된 게시글의 번호로 조회한 모든 정보
	// 현재 파일이 첨부된 글을 쓴
}
