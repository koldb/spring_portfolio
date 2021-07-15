package com.spring.controller;

import java.net.InetAddress;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.service.ScheduleService;
import com.spring.vo.MemberVO;
import com.spring.vo.ScheduleVO;

@Controller
@RequestMapping("/schedule/*")
public class ScheduleController {

	private static final Logger logger = LoggerFactory.getLogger(ScheduleController.class);

	@Inject
	private ScheduleService service;

	@RequestMapping(value = "/scheduleList", method = { RequestMethod.GET, RequestMethod.POST})
	public String Schedule(/*@RequestParam String userId*/MemberVO vo , Model model) throws Exception {
		logger.info("scheduleList");
		
		
		
		try {
			model.addAttribute("userId", vo.getUserId());
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "board/scheduleList";

	}

	
	  @ResponseBody
	  @RequestMapping(value = "/selectSchedule", method = { RequestMethod.GET, RequestMethod.POST})
	  public List<ScheduleVO> selectSchedule(@RequestBody Map<String, Object> params, Model model) throws Exception {
	  logger.info("selectSchedule");
	  
	  List<ScheduleVO> result = null;
	  
	  		
			System.out.println(params);
	  
	  try { result = service.selectSchedule(params); // 날짜 뒤에 .0 없애기
	  
	  System.out.println(result);
	  for (int i=0; i<result.size(); i++) {
		 String tempStr = result.get(i).getStartDate(); 
		 String tempEnd = result.get(i).getEndDate(); 
		  
		  
		  
		//  tempStr = tempStr.substring(0, tempStr.length()-2); 
		 // tempEnd = tempEnd.substring(0, tempEnd.length()-2);
		  result.get(i).setStartDate(tempStr); 
		  result.get(i).setEndDate(tempEnd); 
		  
		  System.out.println("startdate :" +tempStr );
		  System.out.println("enddate :" +tempEnd );
		  
		  System.out.println(result);
		  
	  
	  } }
	  catch(Exception e) { e.printStackTrace(); }
	  
	  return result; 
	  }
	 

	 @RequestMapping(value = "/insertSchedule", method = { RequestMethod.GET, RequestMethod.POST})
	public String insertSchedule(ScheduleVO vo) throws Exception {
		logger.info("insertSchedule");
		
		
		vo.setMemo(vo.getMemo().replaceAll("\n", "<br>"));
		vo.setStartDate(vo.getStartDate());
		vo.setEndDate(vo.getEndDate());
		
		System.out.println(vo);
		
		try {
			service.insertSchedule(vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/schedule/scheduleList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/readSchedule", method = { RequestMethod.GET, RequestMethod.POST})
	public ScheduleVO readSchedule(@RequestBody Map<String, Object> params) throws Exception {
		logger.info("readSchedule");

		ScheduleVO result = null;
		try {
			result = service.readSchedule(params);
			result.setMemo(result.getMemo().replaceAll("<br>", "\n"));

			// 날짜 뒤에 .0 없애기		
			String tempStr = result.getStartDate();
			String tempEnd = result.getEndDate();
			tempStr = tempStr.substring(0, tempStr.length()-2);
			tempEnd = tempEnd.substring(0, tempEnd.length()-2);
			result.setStartDate(tempStr);
			result.setEndDate(tempEnd);
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateSchedule", method = { RequestMethod.GET, RequestMethod.POST})
	public int updateSchedule(@RequestBody Map<String, String> params) throws Exception {
		logger.info("updateSchedule");
		
		int result = 0;
		params.put("memo", params.get("memo").replaceAll("\n", "<br>"));
		try {
			result = service.updateSchedule(params);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteSchedule", method = { RequestMethod.GET, RequestMethod.POST})
	public int deleteSchedule(@RequestBody Map<String, Object> params) throws Exception {
		logger.info("deleteSchedule");
		
		int result = 0;
		try {
			result = service.deleteSchedule(params);
			System.out.println("==============================================================================result : " + result);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
