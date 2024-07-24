package com.kh.pjtMungHub.common.template;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

    public void init(FilterConfig fConfig) throws ServletException {
        // 초기화 코드가 필요하다면 여기에 작성
    }

    public void destroy() {
        // 종료시 코드가 필요하다면 여기에 작성
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest htRequest = (HttpServletRequest)request;
        HttpSession session = htRequest.getSession();

        if(session.getAttribute("loginUser") == null) {
            session.setAttribute("alertMsg", "로그인 후 이용해주세요.");
            ((HttpServletResponse)response).sendRedirect(htRequest.getContextPath());
        } else {
            chain.doFilter(request, response);
        }
    }
}
