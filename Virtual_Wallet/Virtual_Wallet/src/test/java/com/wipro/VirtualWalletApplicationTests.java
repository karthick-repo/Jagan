package com.wipro;

import java.util.logging.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class VirtualWalletApplicationTests {

	private static final Logger logger = Logger.getLogger(VirtualWalletApplicationTests.class.getName());

	@Test
	public void contextLoads() {
		logger.info("Running  Tests for College Service");
	}

}
