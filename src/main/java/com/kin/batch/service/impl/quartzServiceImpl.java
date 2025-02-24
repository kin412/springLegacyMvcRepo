package com.kin.batch.service.impl;

import org.springframework.stereotype.Service;

import com.kin.batch.service.quartzService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("testQuartzJob")
public class quartzServiceImpl implements quartzService {

	@Override
	public void testQuartz() {
		log.info("--testQuartz");
	}
	

}
