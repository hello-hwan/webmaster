package com.yedam.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.yedam.common.Control;
import com.yedam.service.BoardService;
import com.yedam.service.BoardServiceImpl;

public class EventControl implements Control{
	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/json;charset=utf-8");
		String job = req.getParameter("job");
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		BoardService svc = new BoardServiceImpl();
		
		/*
		String json = gson.toJson(result);
		if(job.equals("list")) { // 목록.
			List<Map<String, Object>> result = svc.eventList();
			
			resp.getWriter().print(json);
			
		}else if(job.equals("add"){ //등록.
			String title = req.getParameter("title");
			String start = req.getParameter("start");
			String end = req.getParameter("end");
			Map<String, String>map = new HashMap<>();
			map.put("title", title);
			map.put("start", start);
			map.put("end", end);
			
			if (svc.registerEvent(map)){
				json ="{\"retCode\" : \"OK\"}"
			}
		}
		*/
		
	}
}