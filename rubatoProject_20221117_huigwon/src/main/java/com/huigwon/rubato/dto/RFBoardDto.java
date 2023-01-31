package com.huigwon.rubato.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class RFBoardDto {
	private int rfbnum;
	private int rfbhit;
	private String rfbuserid;
	private String rfbname;
	private String rfbcontent;
	private String rfbtitle;
	private String rfbdate;
	private int rfbreplycount;
}
