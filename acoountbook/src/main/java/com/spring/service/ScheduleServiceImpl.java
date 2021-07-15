package com.spring.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import com.spring.dao.ScheduleDAO;
import com.spring.service.ScheduleService;
import com.spring.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Inject
	private ScheduleDAO dao;

	@Override
	public List<ScheduleVO> selectSchedule(Map params) throws Exception {
		return dao.selectSchedule(params);
	}

	@Override
	public int insertSchedule(ScheduleVO vo) throws Exception {
		return dao.insertSchedule(vo);
	}

	@Override
	public ScheduleVO readSchedule(Map params) throws Exception {
		return dao.readSchedule(params);
	}
	
	@Override
	public int updateSchedule(Map params) throws Exception {
		return dao.updateSchedule(params);
	}
	
	@Override
	public int deleteSchedule(Map params) throws Exception {
		return dao.deleteSchedule(params);
	}
}