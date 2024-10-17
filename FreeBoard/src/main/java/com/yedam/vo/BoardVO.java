package com.yedam.vo;

import java.util.Date;

import lombok.Data;

@Data //게터세터 투스트링 등 웬만한거 다 만들어줌
public class BoardVO {
	private int boardNo; // board_no = boardNO
	private String title;
	private String content;
	private String writer;
	private String writerName;
	private int viewCnt;
	private Date writeDate;
	private Date updateDate;
}
