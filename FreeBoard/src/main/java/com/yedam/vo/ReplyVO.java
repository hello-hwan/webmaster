package com.yedam.vo;
//1번으로VO 데이터베이스랑 같이 만들것
import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int replyNo;
	private String reply;
	private String replyer;
	private int boardNo;
	private Date replyDate;

}
