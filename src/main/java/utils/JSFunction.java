package utils;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.JspWriter;

public class JSFunction {
	//메시지 알림창을 띄운 후 명시한 URL로 이동합니다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		try {
			String script = "" //삽입할 자바스크립트 코드
					+ "<script>"
					+ "		alert('"+msg+"');"
					+ "		location.href='"+url+"';"
					+ "</script>";
			out.print(script); //자바스크립트 코드를 out 내장 객체로 출력(삽입)
		} 
		catch(Exception e) {}
	}


	//메세지 알림창을 띄운 후 이전 페이지로 돌아갑니다.
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = "" //삽입할 자바스크립트 코드
		
				+ "<script>"
				+ "		alert('"+msg+"');"
				+ "		history.back();"
				+ "</script>";
		out.print(script); //자바스크립트 코드를 out 내장 객체로 출력(삽입)
	}
	catch(Exception e) {}
		}
	
	//메시지 알림창을 띄운 후 명시한 url로 이동합니다
	public static void alertLocation(HttpServletResponse resp, String msg, String url) {
	    try {
	        resp.setContentType("text/html;charset=UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.println("<script>");
	        out.println("alert('" + msg + "');");
	        out.println("location.href='" + url + "';");
	        out.println("</script>");
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	 
	 //메시지 알림창을 띄운 후 이전 페이지로 돌아갑니다.
	 public static void alertBack(HttpServletResponse resp , String msg) {
		 try {
			 resp.setContentType("text/html;charset=UTF-8");
			 PrintWriter writer = resp.getWriter();
			 String script = ""
					 	+ "<script>"
						+ "		alert('"+msg+"');"
						+ "		history.back();"
						+ "</script>";
			 writer.print(script);
		 }
		 catch (Exception e) {
			  e.printStackTrace();
		 }
	    
	}
}