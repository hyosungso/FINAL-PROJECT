//package com.kh.pjtMungHub.common.model.vo;
//
//import java.util.concurrent.Executors;
//import java.util.concurrent.ScheduledExecutorService;
//import java.util.concurrent.TimeUnit;
//
//import javax.servlet.http.HttpSession;
//
//import org.aspectj.lang.annotation.After;
//import org.aspectj.lang.annotation.Aspect;
//
//import com.kh.pjtMungHub.member.model.service.MemberServiceImpl;
//import com.kh.pjtMungHub.member.model.vo.Member;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Aspect
//@Slf4j
//public class TimeAspect {
//
//	@After("execution(* com.kh.pjtMungHub.member.model.dao.MemberDao.disableMember(..))")
//	public void afterDisable(HttpSession session) {
//		ScheduledExecutorService schedule=Executors.newSingleThreadScheduledExecutor();
//		Member m=(Member)session.getAttribute("disableUser");
//		long disable=Integer.parseInt((String)session.getAttribute("disable"));
//		session.removeAttribute("disableUser");
//		session.removeAttribute("disable");
//		schedule.schedule(()->{
//			int result=new MemberServiceImpl().enableMember(m);
//			if(result>0) {
//				System.out.println("정지 해제");
//			}
//			schedule.shutdown();
//			},disable,TimeUnit.DAYS);
//	}
//}
