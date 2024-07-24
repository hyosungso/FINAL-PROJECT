package com.kh.pjtMungHub.petcare.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public class PetSaveFile {
	
	//파일 업로드 처리 메소드(재활용)
		public static String getSaveFile(MultipartFile upfile,HttpSession session) {
			//파일명 수정작업하기
			//1.원본파일명 추출
			String originName = upfile.getOriginalFilename();
			
			//2.시간형식 문자열로 만들기
			//20240527162730
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			//3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기
			String ext = originName.substring(originName.lastIndexOf("."));
			
			//4.랜덤값 5자리 뽑기
			int ranNum = (int)(Math.random()*90000+10000);
			
			//5.하나로 합쳐주기
			String changeName = currentTime+ranNum+ext;
			
			//6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/petPhoto/");
			
			//7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
			try {
				upfile.transferTo(new File(savePath+changeName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return changeName;
		}
		
		public static String getHospitalFile(MultipartFile upfile,HttpSession session) {
			//파일명 수정작업하기
			//1.원본파일명 추출
			String originName = upfile.getOriginalFilename();
			
			//2.시간형식 문자열로 만들기
			//20240527162730
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			//3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기
			String ext = originName.substring(originName.lastIndexOf("."));
			
			//4.랜덤값 5자리 뽑기
			int ranNum = (int)(Math.random()*90000+10000);
			
			//5.하나로 합쳐주기
			String changeName = currentTime+ranNum+ext;
			
			//6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/hospital/");
			
			//7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
			try {
				upfile.transferTo(new File(savePath+changeName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return changeName;
		}

}
