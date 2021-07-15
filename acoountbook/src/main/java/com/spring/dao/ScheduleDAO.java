package com.spring.dao;

import java.util.List;
import java.util.Map;

import com.spring.vo.ScheduleVO;

public interface ScheduleDAO {

	public List<ScheduleVO> selectSchedule(Map params) throws Exception;
	public int insertSchedule(ScheduleVO vo) throws Exception;

	public ScheduleVO readSchedule(Map params) throws Exception;
	public int updateSchedule(Map params) throws Exception;
	public int deleteSchedule(Map params) throws Exception;
}
