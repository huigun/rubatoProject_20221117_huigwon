package com.huigwon.rubato.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class RReplyDto {
	private String rrcontent;
	private String rrid;
	private int rrnum;
	private int rrorinum;
	private String rrdate;
}
