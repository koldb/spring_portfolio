package com.spring.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.vo.NewsVO;

@Controller
@RequestMapping("/news/*")
public class NewsController {

	private static final Logger logger = LoggerFactory.getLogger(NewsController.class);


	// jsp페이지 로딩을 위한 임시 메소드
	@RequestMapping(value = "/newsList", method = RequestMethod.GET)
	public String startCrawl(NewsVO newsVO) throws IOException {
		
		//logger.info("Test~~~~");

		
		return "/news/newsList";

	}
	
	// Ajax로 뉴스 불러오기
	@RequestMapping(value = "/newsListAjax", method = RequestMethod.GET)
	@ResponseBody
	public List startCrawlAjax(NewsVO newsVO) throws IOException {
		
		// logger.info("Test~~~~");
	
		// 현재날짜 포맷변경 후 String에 저장
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		Date currentTime = new Date();
		
		String now = formatter.format(currentTime);
		
		// 기사 카테고리 선택
		String sid1 = newsVO.getSid1();

		logger.info(sid1);

		String url = "https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=" + sid1 + "&listType=title&date=" + now;
		
		Document rawData = Jsoup.connect(url).timeout(5000).get();
		
		//System.out.println(address);		
		
		Elements articles = rawData.select("ul.type02 > li");
		//System.out.println("articles >>>>> " + articles);
		
		List article = new ArrayList();
		
				
		for(Element e : articles) {
			Map<String, String> result = new HashMap<String, String>();
			//System.out.println(e.toString());
			 
			String href = e.select("a").attr("href");
			result.put("href", href);
			String title = e.select("a").text();
			result.put("title", title);
			String writer = e.select("span.writing").text();
			result.put("writer", writer);
			String writeDate = e.select("span.date").text();
			result.put("writeDate", writeDate);
					
			article.add(result);
						
		}	
		//System.out.println(article);

		
		return article;
	}

}
