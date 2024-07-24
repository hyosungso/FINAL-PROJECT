package com.kh.pjtMungHub.common.controller;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.kh.pjtMungHub.wedding.aop.AccessRestrictedException;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(AccessRestrictedException.class)
	public String handleAccessRestrictedException(AccessRestrictedException ex,Model model) {
		model.addAttribute("message",ex.getMessage());
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime restrictedUntil = ex.getRestrictedUntil();
		
		long daysUntil = ChronoUnit.DAYS.between(now, restrictedUntil);
		long hoursUntil = ChronoUnit.HOURS.between(now, restrictedUntil)%24;
		long minutesUntil = ChronoUnit.MINUTES.between(now, restrictedUntil)%60;
		
		model.addAttribute("restrictedUntil",restrictedUntil);
		model.addAttribute("daysUntil",daysUntil);
		model.addAttribute("hoursUntil",hoursUntil);
		model.addAttribute("minutesUntil",minutesUntil);
		
		return "common/accessRestricted";
	}
}
