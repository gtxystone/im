package com.yx.base.test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.jarod.qqwry.IPZone;
import com.github.jarod.qqwry.QQWry;

@SuppressWarnings({ "unchecked", "unused" })
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath*:config/applicationContext.xml" })
public class CommonTest {
	
	@Test
	public void test() throws IOException{
		QQWry qqwry = new QQWry(); // load qqwry.dat from classpath

/*		QQWry qqwry = new QQWry(Paths.get("path/to/qqwry.dat")); // load qqwry.dat from java.nio.file.Path

		byte[] data = Files.readAllBytes(Paths.get("path/to/qqwry.dat"));
		QQWry qqwry = new QQWry(data); // create QQWry with provided data
*/
		String myIP = "210.61.46.5";
		IPZone ipzone = qqwry.findIP(myIP);
		System.out.printf("%s, %s", ipzone.getMainInfo(), ipzone.getSubInfo());
	}
	

}
