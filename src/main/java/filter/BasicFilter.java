package filter;

import java.io.IOException;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;

public class BasicFilter implements Filter {
	
	FilterConfig config;
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		config = filterConfig;
		String filterName = filterConfig.getFilterName();
		
		System.out.println("BasicFilter -> inint()호출됨:" + filterName);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String filterInitParam = config.getInitParameter("FILTER_INIT_PARAM");
		System.out.println("BasicFilter -> 초기화 매개변수 :" + filterInitParam);
		
//		String method = request.getMethod();
		String method = ((HttpServletRequest)request).getMethod();
		
		chain.doFilter(request, response);
		
	}
	
	@Override
	public void destroy() {
		System.out.println("BasicFilter -> destroy() 호출됨");
	}
}
