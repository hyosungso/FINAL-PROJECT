package com.kh.pjtMungHub.kindergarten.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pjtMungHub.kindergarten.model.service.KindergartenService;
import com.kh.pjtMungHub.kindergarten.model.vo.Kindergarten;
import com.kh.pjtMungHub.kindergarten.model.vo.Registration;
import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.pet.model.vo.Pet;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class KindergartenController {

	@Autowired
	private KindergartenService service;

	// 지도 반환리스트

	@RequestMapping("map.do")
	public String selectMap(Model model) {

		ArrayList<Kindergarten> mapList = service.selectMap();

		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < mapList.size(); i++) {
			JSONObject jobj = new JSONObject();
			jobj.put("kindNo", mapList.get(i).getKindNo());
			jobj.put("directorId", mapList.get(i).getDirectorId());
			jobj.put("regionName", mapList.get(i).getRegionName());
			jobj.put("kindAddress", mapList.get(i).getKindAddress());
			jobj.put("kindName", mapList.get(i).getKindName());
			jobj.put("kindContact", mapList.get(i).getKindContact());
			jobj.put("placeX", mapList.get(i).getPlaceX());
			jobj.put("placeY", mapList.get(i).getPlaceY());
			jobj.put("status", mapList.get(i).getStatus());
			jsonArray.add(jobj);
		}
		model.addAttribute("mapList", jsonArray);
		return "kindergarten/kindergartenMapView";
	}

	@GetMapping("reg.do")
	public String regForm(int kindNo, int ownerNo, Model model, HttpSession session) {

		ArrayList<Pet> pet = service.selectPets(ownerNo);
		Kindergarten kindergarten = service.selectKindergarten(kindNo);
		model.addAttribute("petList", pet);
		model.addAttribute("kindergarten", kindergarten);
		return "kindergarten/insertRegView";
	}

//	트랜잭션 방식 수정할 것
	@PostMapping("reg.do")
	public String insertReg(Registration reg, MultipartFile upFile,ArrayList<MultipartFile>vacCert, Model model, HttpSession session) {

		if (!upFile.getOriginalFilename().equals("")) {
			String changeName = saveFile(upFile, session);
			reg.setOriginName(upFile.getOriginalFilename());
			reg.setChangeName("resources/uploadFiles/kindergarten/" + changeName);
		}
		int result1 = service.insertReg(reg);
		reg.setApproval("N");
		ArrayList<Vaccine> vacList = new ArrayList<Vaccine>();
		for(MultipartFile m:vacCert) {
			vacList.add(Vaccine.builder()
					.petNo(reg.getPetNo())
					.originName(m.getOriginalFilename())
					.changeName("resources/uploadFiles/kindergarten/"+saveFile(m, session))
					.build());
		}
		int result2 = service.insertVac(vacList);
		if (result1*result2 > 0) {
			ArrayList<Pet> pet = service.selectPets(reg.getUserNo());
			Kindergarten kindergarten = service.selectKindergarten(reg.getKindNo());
			model.addAttribute("pet", pet);
			model.addAttribute("kindergarten", kindergarten);
			model.addAttribute("registration", reg);
			session.setAttribute("alertMsg", "상담 신청 성공! 승인 결과를 기다려주세요~!");
			return "redirect:/regList.do";
		} else {
			session.setAttribute("alertMsg", "상담 신청 실패... 다시 시도해주세요...!");
			return "kindergarten/insertRegView";
		}

	}

	@RequestMapping("regDetail.do")
	public ModelAndView selectReg(int reservNo, HttpSession session, ModelAndView mv) {
		Registration r = service.selectRegistration(reservNo);
		if (r != null) {
			Pet pet = service.selectPetByNo(Integer.parseInt(r.getPetNo()));
			Kindergarten k = service.selectKindergarten(r.getKindNo());
			mv.addObject("registration", r);
			mv.addObject("pet", pet);
			mv.addObject("kindergarten", k);
			mv.setViewName("kindergarten/regDetailView");
		} else {
			session.setAttribute("alertMsg", "상세조회실패... 다시 시도해주세요");
			mv.setViewName("redirect:/map.do");
		}
		return mv;
	}

	/* 예약내역보기(견주) */
	@GetMapping("regList.do")
	public String regList(Model model, HttpSession session) {
		Member member = (Member) session.getAttribute("loginUser");
		int userNo = member.getUserNo();
		ArrayList<Registration> regList = service.selectRegList(userNo);
		ArrayList<Kindergarten> kindergartenList = new ArrayList<Kindergarten>();
		for (int i = 0; i < regList.size(); i++) {
			kindergartenList.add(service.selectKindergarten(regList.get(i).getKindNo()));
		}
		model.addAttribute("kindergartenList", kindergartenList);
		model.addAttribute("regList", regList);
		return "kindergarten/regListView";
	}

	/* 예약내역보기(원장님) */
	@GetMapping("regList2.do")
	public String regList2(Model model, HttpSession session) {
		Member member = (Member) session.getAttribute("loginUser");
		int userNo = member.getUserNo();
		ArrayList<Registration> regList = service.selectRegList2(userNo);
		model.addAttribute("regList", regList);
		return "kindergarten/regListView2";
	}

	// 파일 업로드 처리 메소드(재활용)
	public String saveFile(MultipartFile upfile, HttpSession session) {

		// 파일명 수정작업하기
		// 1.원본파일명 추출
		String originName = upfile.getOriginalFilename();

		// 2.시간형식 문자열로 만들기
		// 20240527162730
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		// 3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기
		String ext = originName.substring(originName.lastIndexOf("."));

		// 4.랜덤값 5자리 뽑기
		int ranNum = (int) (Math.random() * 90000 + 10000);

		// 5.하나로 합쳐주기
		String changeName = currentTime + ranNum + ext;

		// 6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/kindergarten/");

		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}

	@RequestMapping("deleteReg.do")
	public String deleteReg(int reservNo, HttpSession session) {
		int result = service.deleteReg(reservNo);
		if (result > 0) {
			session.setAttribute("alertMsg", "상담이 정상적으로 취소되었습니다.");
			return "redirect:/regList.do";
		} else {
			session.setAttribute("alertMsg", "처리 실패... 다시 시도바랍니다.");
			return "kindergarten/regListView";
		}
	}

	@GetMapping("updateReg.do")
	public String updateRegView(int reservNo, Model model) {
		Registration r = service.selectRegistration(reservNo);
		Pet p = service.selectPetByNo(Integer.parseInt(r.getPetNo()));
		model.addAttribute("registration", r);
		model.addAttribute("pet", p);
		return "kindergarten/regUpdateView";
	}

	@PostMapping("updateReg.do")
	public String updateReg(Registration reg, MultipartFile reupFile, HttpSession session) {
		boolean flag = false;
		String deleteFile = "";
		if (!reupFile.getOriginalFilename().equals("")) {
			if (reg.getOriginName() != null) {
				flag = true;
				deleteFile = reg.getChangeName();
			}
			String changeName = saveFile(reupFile, session);
			reg.setOriginName(reupFile.getOriginalFilename());
			reg.setChangeName("resources/uploadFiles/kindergarten/" + changeName);
		}
		int result = service.updateReg(reg);
		String msg = "";
		if (result > 0) {
			msg = "신청서 수정 성공! 승인을 대기해주세요~";
			if (flag) {
				File file = new File(session.getServletContext().getRealPath(deleteFile));
				file.delete();
			}
		} else {
			msg = "신청서 수정 실패... 다시 시도해주세요!";
		}
		session.setAttribute("alertMsg", msg);
		return "redirect:/regDetail.do?reservNo=" + reg.getReservNo();
	}

	// 등록상담신청승인 메소드
	@PostMapping("approve.do")
	public String approveReg(int reservNo, HttpSession session) {
		int result = service.approveReg(reservNo);
		if (result > 0) {
			session.setAttribute("alertMsg", "상담이 정상적으로 승인되었습니다.");
			return "redirect:/regList2.do";
		} else {
			session.setAttribute("alertMsg", "상담 승인 실패. 다시 시도해주세요.");
			return "redirect:/regList2.do";
		}
	}
	
	//등록상담거절 메소드
	@PostMapping("reject.do")
	public String rejectReg(Registration r,HttpSession session) {
		int result = service.rejectReg(r);
		if(result>0) {
			session.setAttribute("alertMsg", "상담이 정상적으로 거절되었습니다.");
			return "redirect:/regList2.do";
		}else {
			session.setAttribute("alertMsg", "처리 실패. 다시 시도해주세요.");
			return "redirect:/regList2.do";
		}
	}
	
}
