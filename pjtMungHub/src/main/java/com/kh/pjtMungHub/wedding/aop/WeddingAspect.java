package com.kh.pjtMungHub.wedding.aop;

import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kh.pjtMungHub.member.model.service.MemberService;
import com.kh.pjtMungHub.member.model.vo.Member;

@Aspect
@Component
public class WeddingAspect {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HttpSession session;
	
	@Before("execution(* com.kh.pjtMungHub.wedding.controller.WeddingController.weddingList(..))")
	public void checkAccess()throws Exception {
		Member m = (Member)session.getAttribute("loginUser");
		if(m!=null) {
			int userNo = m.getUserNo();
			if(memberService.isUserRestricted(userNo)) {
				LocalDateTime restrictedUntil = memberService.getRestrictedUntil(userNo);
				throw new AccessRestrictedException("이미 확정된 만남을 취소하셔서, 취소한 날로부터 14일간 해당 서비스 사용이 제한되어있습니다",restrictedUntil);
			}
		}else {
			throw new AccessRestrictedException("로그인이 필요합니다.",null);
		}
	}
	
}
