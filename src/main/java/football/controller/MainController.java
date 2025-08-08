package football.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import football.dto.ReservationEmailDto;
import football.dto.SeatPriceItem;
import football.entity.RegisterSchedule;
import football.entity.ScheduleInfo;
import football.entity.SeatFee;
import football.entity.TeamInfo;
import football.entity.TicketInfo;
import football.service.EmailService;
import football.service.RegisterScheduleService;
import football.service.ScheduleInfoService;
import football.service.SeatFeeService;
import football.service.TeamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jakarta.servlet.http.HttpServletRequest;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import football.entity.Faq;
import football.service.FaqService;
import org.springframework.data.domain.Page;
import java.util.stream.Collectors;
import football.entity.Tour;
import football.service.TourService;
import football.entity.MainImg;
import football.service.MainImgService;
import football.entity.MainBanner;
import football.service.MainBannerService;
import football.entity.Popup;
import football.service.PopupService;
import football.service.TicketInfoService;
import football.entity.Tsc;
import football.service.TscService;
import football.service.TicketLinkService;
import football.entity.TicketLink;
import football.service.FooterInfoService;
import football.entity.FooterInfo;
import football.service.PersonService;
import football.entity.Person;

@Controller
public class MainController {
    
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);
    
    @Autowired
    private ScheduleInfoService scheduleInfoService;
    
    @Autowired
    private SeatFeeService seatFeeService;
    
    @Autowired
    private TeamInfoService teamInfoService;
    
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private RegisterScheduleService registerScheduleService;
    
    @Autowired
    private FaqService faqService;
    
    @Autowired
    private TourService tourService;
    
    @Autowired
    private MainImgService mainImgService;
    
    @Autowired
    private MainBannerService mainBannerService;
    
    @Autowired
    private PopupService popupService;
    
    @Autowired
    private TicketInfoService ticketInfoService;
    
    @Autowired
    private TscService tscService;
    
    @Autowired
    private TicketLinkService ticketLinkService;
    
    @Autowired
    private FooterInfoService footerInfoService;
    
    @Autowired
    private PersonService personService;
    
    // JSON 값을 안전하게 가져오는 헬퍼 메서드
    private String getJsonValue(com.fasterxml.jackson.databind.JsonNode jsonNode, String fieldName, String defaultValue) {
        if (jsonNode.has(fieldName) && !jsonNode.get(fieldName).isNull()) {
            return jsonNode.get(fieldName).asText();
        }
        return defaultValue;
    }
    
    @GetMapping("/")
    public String index(Model model) {
        try {
            logger.info("메인 페이지 데이터 로드 시작");
            
            // main_img 테이블에서 모든 이미지 데이터 가져오기
            List<MainImg> mainImgs = mainImgService.getAllMainImgs();
            model.addAttribute("mainImgs", mainImgs);
            logger.info("메인 이미지 데이터 로드 완료: {}개", mainImgs.size());

            // main_banner 테이블에서 모든 배너 데이터 가져오기
            List<MainBanner> mainBanners = mainBannerService.getAllMainBanners();
            model.addAttribute("mainBanners", mainBanners);
            logger.info("메인 배너 데이터 로드 완료: {}개", mainBanners.size());

            // popup 테이블에서 모든 팝업 데이터 가져오기
            List<Popup> popups = popupService.getAllPopups();
            model.addAttribute("popups", popups);
            logger.info("팝업 데이터 로드 완료: {}개", popups.size());

            // team_info 테이블에서 main 칼럼이 "Y"인 팀정보 데이터만 가져오기 (내림차순)
            logger.info("팀정보 데이터 로드 시작");
            List<TeamInfo> teamInfos = teamInfoService.findByMain("Y");
            logger.info("팀정보 데이터 조회 완료: {}개", teamInfos.size());
            
            // 각 팀정보의 상세 내용 로그 출력
            for (TeamInfo teamInfo : teamInfos) {
                logger.info("팀정보: uid={}, teamName={}, content={}, stadium={}, logoImg={}", 
                    teamInfo.getUid(), teamInfo.getTeamName(), 
                    teamInfo.getContent() != null ? teamInfo.getContent() : "null",
                    teamInfo.getStadium() != null ? teamInfo.getStadium() : "null",
                    teamInfo.getLogoImg() != null ? teamInfo.getLogoImg() : "null");
            }
            
            model.addAttribute("teamInfos", teamInfos);
            logger.info("팀정보 데이터 로드 완료: {}개", teamInfos.size());

        } catch (Exception e) {
            logger.error("메인 페이지 데이터 로드 중 오류 발생", e);
            model.addAttribute("mainImgs", List.of());
            model.addAttribute("mainBanners", List.of());
            model.addAttribute("popups", List.of());
            model.addAttribute("teamInfos", List.of());
        }
        
        // footer_info 데이터 추가
        try {
            FooterInfo footerInfo = footerInfoService.getFooterInfo();
            model.addAttribute("footerInfo", footerInfo);
        } catch (Exception e) {
            logger.error("footer_info 데이터 로드 중 오류 발생", e);
            model.addAttribute("footerInfo", null);
        }
        
        return "index";
    }
    
    @GetMapping("/about")
    public String about(Model model) {
        // 현재 날짜 정보 추가
        LocalDate now = LocalDate.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        Tour tour = tourService.getTour();
        model.addAttribute("tour", tour);
        
        // footer_info 데이터 추가
        try {
            FooterInfo footerInfo = footerInfoService.getFooterInfo();
            model.addAttribute("footerInfo", footerInfo);
        } catch (Exception e) {
            logger.error("footer_info 데이터 로드 중 오류 발생", e);
            model.addAttribute("footerInfo", null);
        }
        
        return "about";
    }
    
    @GetMapping("/person")
    public String person(Model model) {
        logger.info("=== person 페이지 요청 ===");
        
        try {
            // person 테이블에서 데이터를 가져옴
            Optional<Person> person = personService.findFirst();
            if (person.isPresent() && person.get().getContent() != null && !person.get().getContent().isEmpty()) {
                model.addAttribute("person", person.get());
                logger.info("person 데이터 로드 완료");
            } else {
                model.addAttribute("person", null);
                logger.info("person 데이터가 없습니다.");
            }
        } catch (Exception e) {
            logger.error("person 데이터 로드 중 오류 발생", e);
            model.addAttribute("person", null);
        }
        
        // 현재 날짜 정보 추가
        LocalDate now = LocalDate.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        logger.info("person 페이지 반환");
        return "person";
    }
    
    @GetMapping("/privacy")
    public String privacy(Model model) {
        // 현재 날짜 정보 추가
        LocalDate now = LocalDate.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        return "person";
    }
    
    @GetMapping("/private")
    public String privatePage(Model model) {
        // 현재 날짜 정보 추가
        LocalDate now = LocalDate.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        return "person";
    }
    
    @GetMapping("/account")
    public String account(Model model) {
        try {
            // ticket_link 테이블에서 데이터를 가져와서 올림차순으로 정렬
            List<TicketLink> ticketLinks = ticketLinkService.findAll();
            // 올림차순 정렬 (오래된 등록순)
            ticketLinks.sort((a, b) -> a.getUid().compareTo(b.getUid()));
            model.addAttribute("ticketLinks", ticketLinks);
            logger.info("티켓바로가기 데이터 로드 완료: {}개", ticketLinks.size());
        } catch (Exception e) {
            logger.error("티켓바로가기 데이터 로드 중 오류 발생", e);
            model.addAttribute("ticketLinks", new ArrayList<>());
        }
        
        // footer_info 데이터 추가
        try {
            FooterInfo footerInfo = footerInfoService.getFooterInfo();
            model.addAttribute("footerInfo", footerInfo);
        } catch (Exception e) {
            logger.error("footer_info 데이터 로드 중 오류 발생", e);
            model.addAttribute("footerInfo", null);
        }
        
        return "account";
    }
    
    @GetMapping("/account-list")
    public String accountList(@RequestParam(defaultValue = "0") int page,
                            @RequestParam(required = false) String team, 
                            @RequestParam(required = false) String yearMonth,
                            @RequestParam(required = false) String category,
                            HttpServletRequest request,
                            Model model) {
        
        int size = 10; // 한 페이지당 10개로 고정
        Page<ScheduleInfo> schedulePage;
        
        if (yearMonth != null && !yearMonth.isEmpty() && category != null && !category.isEmpty()) {
            // 연월과 카테고리 모두 있는 경우 (페이징, ID 내림차순)
            schedulePage = scheduleInfoService.getSchedulesByYearMonthAndCategory(yearMonth, category, page, size);
            logger.info("연월+카테고리별 일정 조회: yearMonth={}, category={}, count={}, totalPages={}", yearMonth, category, schedulePage.getContent().size(), schedulePage.getTotalPages());
        } else if (category != null && !category.isEmpty()) {
            // 카테고리만 있는 경우 (페이징, ID 내림차순)
            schedulePage = scheduleInfoService.searchByCategory(category, page, size);
            logger.info("카테고리별 일정 조회: category={}, count={}, totalPages={}", category, schedulePage.getContent().size(), schedulePage.getTotalPages());
        } else if (team != null && !team.isEmpty()) {
            // 홈팀/원정팀에서 유사 검색 (페이징, 경기날짜 내림차순)
            schedulePage = scheduleInfoService.searchByTeamName(team, page, size);
            logger.info("팀별 일정 조회: team={}, count={}, totalPages={}", team, schedulePage.getContent().size(), schedulePage.getTotalPages());
        } else if (yearMonth != null && !yearMonth.isEmpty()) {
            // 특정 년월의 일정 데이터 가져오기 (페이징)
            schedulePage = scheduleInfoService.getSchedulesByMonthWithPaging(yearMonth, page, size);
            logger.info("월별 일정 조회: yearMonth={}, count={}, totalPages={}", yearMonth, schedulePage.getContent().size(), schedulePage.getTotalPages());
        } else {
            // 전체 일정 데이터 가져오기 (페이징) - 현재 월 조건 제거
            schedulePage = scheduleInfoService.getAllSchedules(page, size);
            logger.info("전체 일정 조회: count={}, totalPages={}", schedulePage.getContent().size(), schedulePage.getTotalPages());
        }
        
        // 각 일정의 홈팀에 해당하는 orange 가격 조회
        for (ScheduleInfo schedule : schedulePage.getContent()) {
            List<SeatFee> seatFees = seatFeeService.findBySeatName(schedule.getHomeTeam());
            if (!seatFees.isEmpty()) {
                schedule.setOrange(seatFees.get(0).getOrange());
                logger.info("팀 {}의 orange 가격 설정: {}", schedule.getHomeTeam(), seatFees.get(0).getOrange());
            } else {
                logger.warn("팀 {}의 좌석 요금 정보를 찾을 수 없음", schedule.getHomeTeam());
                schedule.setOrange(null);
            }
        }
        
        // 현재 날짜 정보
        LocalDate now = LocalDate.now();
        String currentYearMonth = now.format(DateTimeFormatter.ofPattern("yyyy년 MM월"));
        
        // 1년간의 월별 탭 데이터 생성
        List<String> monthTabs = generateMonthTabs(now);
        logger.info("생성된 월별 탭: {}", monthTabs);
        
        // 현재 날짜 정보를 JSP로 전달
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        model.addAttribute("schedules", schedulePage.getContent());
        model.addAttribute("currentPage", page);
        // totalPages 보정: 실제 데이터가 1개 이하일 때 1로 고정
        int totalPages = schedulePage.getTotalPages();
        if (schedulePage.getTotalElements() <= size) {
            totalPages = 1;
        }
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalItems", schedulePage.getTotalElements());
        model.addAttribute("hasNext", schedulePage.hasNext());
        model.addAttribute("hasPrevious", schedulePage.hasPrevious());
        model.addAttribute("currentYearMonth", currentYearMonth);
        model.addAttribute("selectedTeam", team);
        model.addAttribute("selectedYearMonth", yearMonth);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("monthTabs", monthTabs != null ? monthTabs : new ArrayList<>());
        
        // 현재 URL과 ticket_link의 link 매칭 처리
        try {
            // 현재 페이지의 URL 구성 (도메인 + 경로 + 쿼리 스트링)
            String currentUrl = request.getRequestURL().toString();
            String queryString = request.getQueryString();
            if (queryString != null && !queryString.isEmpty()) {
                currentUrl += "?" + queryString;
            }
            
            logger.info("현재 URL: {}", currentUrl);
            
            // ticket_link 테이블에서 link와 매칭되는 데이터 조회
            TicketLink matchedTicketLink = ticketLinkService.findByLink(currentUrl);
            if (matchedTicketLink != null) {
                model.addAttribute("matchedTicketName", matchedTicketLink.getTicketName());
                logger.info("매칭된 티켓: {}", matchedTicketLink.getTicketName());
            } else {
                logger.info("매칭되는 티켓 링크가 없습니다.");
            }
        } catch (Exception e) {
            logger.error("URL 매칭 처리 중 오류 발생", e);
        }
        
        return "account-list";
    }
    
    // 1년간의 월별 탭 데이터 생성 메서드
    private List<String> generateMonthTabs(LocalDate currentDate) {
        List<String> monthTabs = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        
        for (int i = 0; i < 12; i++) {
            LocalDate monthDate = currentDate.plusMonths(i);
            String yearMonth = monthDate.format(formatter);
            monthTabs.add(yearMonth);
        }
        
        return monthTabs;
    }
    
    @GetMapping("/account-detail")
    public String accountDetail(@RequestParam Integer uid, Model model) {
        logger.info("account-detail 요청: uid={}", uid);
        
        try {
            // uid로 해당 일정 정보 조회
            Optional<ScheduleInfo> scheduleInfo = scheduleInfoService.findById(uid);
            logger.info("schedule 조회 결과: present={}", scheduleInfo.isPresent());
            
            if (scheduleInfo.isPresent()) {
                ScheduleInfo schedule = scheduleInfo.get();
                logger.info("일정 정보 조회 성공: uid={}, homeTeam={}, otherTeam={}, gameDate={}", 
                    schedule.getUid(), schedule.getHomeTeam(), schedule.getOtherTeam(), schedule.getGameDate());
                
                // schedule의 fee 값으로 seat_fee 테이블에서 해당하는 데이터 조회
                if (schedule.getFee() != null) {
                    logger.info("좌석 요금 조회 시도: fee={}", schedule.getFee());
                    Optional<SeatFee> seatFee = seatFeeService.getSeatFeeById(schedule.getFee());
                    if (seatFee.isPresent()) {
                        SeatFee fee = seatFee.get();
                        
                        // seat_etc와 seat_price 데이터 처리
                        String seatEtc = schedule.getSeatEtc();
                        String seatPrice = schedule.getSeatPrice();
                        
                        // seat_etc가 있으면 그것을 사용, 없으면 seat_price 사용
                        String priceData = (seatEtc != null && !seatEtc.trim().isEmpty()) ? seatEtc : seatPrice;
                        
                        if (priceData != null && !priceData.trim().isEmpty()) {
                            String[] items = priceData.split(",");
                            List<SeatPriceItem> seatPriceItems = new ArrayList<>();
                            
                            for (String item : items) {
                                String trimmedItem = item.trim();
                                if (!trimmedItem.isEmpty()) {
                                    // 콜론(:)으로 좌석명과 가격 분리
                                    String[] parts = trimmedItem.split(":");
                                    if (parts.length >= 2) {
                                        String seatName = parts[0].trim();
                                                                                 try {
                                             int price = Integer.parseInt(parts[1].trim());
                                             seatPriceItems.add(new SeatPriceItem(seatName, String.valueOf(price)));
                                         } catch (NumberFormatException e) {
                                             logger.warn("가격 파싱 실패: {}", parts[1]);
                                         }
                                    } else {
                                                                                 // 콜론이 없는 경우 기본값으로 처리
                                         try {
                                             int price = Integer.parseInt(trimmedItem);
                                             seatPriceItems.add(new SeatPriceItem("좌석", String.valueOf(price)));
                                         } catch (NumberFormatException e) {
                                             logger.warn("가격 파싱 실패: {}", trimmedItem);
                                         }
                                    }
                                }
                            }
                            
                            model.addAttribute("seatPriceItems", seatPriceItems);
                            logger.info("좌석 가격 데이터 처리 완료: seat_etc={}, seat_price={}, 처리된 데이터={}, 좌석 수={}", 
                                seatEtc, seatPrice, priceData, seatPriceItems.size());
                        }
                        
                        logger.info("좌석 요금 조회 성공: fee={}", schedule.getFee());
                    } else {
                        logger.warn("좌석 요금 정보를 찾을 수 없음: fee={}", schedule.getFee());
                    }
                } else {
                    logger.warn("일정의 fee 값이 null임: uid={}", uid);
                }
                
                // 홈팀의 좌석 이미지 조회
                List<TeamInfo> teamInfoList = teamInfoService.findByTeamName(schedule.getHomeTeam());
                if (!teamInfoList.isEmpty()) {
                    TeamInfo teamInfo = teamInfoList.get(0);
                    if (teamInfo.getSeatImg() != null) {
                        model.addAttribute("homeTeamSeatImg", teamInfo.getSeatImg());
                        logger.info("홈팀 좌석 이미지 조회 성공: team={}, seatImg={}", 
                            schedule.getHomeTeam(), teamInfo.getSeatImg());
                    }
                    if (teamInfo.getSeatImg1() != null) {
                        model.addAttribute("homeTeamSeatImg1", teamInfo.getSeatImg1());
                        logger.info("홈팀 좌석 이미지1 조회 성공: team={}, seatImg1={}", 
                            schedule.getHomeTeam(), teamInfo.getSeatImg1());
                    }
                } else {
                    logger.warn("홈팀 좌석 이미지를 찾을 수 없음: team={}", schedule.getHomeTeam());
                }
                
                // 티켓 정보 조회
                TicketInfo ticketInfo = ticketInfoService.getTicketInfo();
                model.addAttribute("ticketInfo", ticketInfo);
                logger.info("티켓 정보 조회 완료: content={}", ticketInfo.getContent());
                
                // 현재 날짜 정보 추가 (좌측 메뉴용)
                LocalDate now = LocalDate.now();
                model.addAttribute("currentYear", now.getYear());
                model.addAttribute("currentMonth", now.getMonthValue());
                model.addAttribute("currentDate", now);
                
                model.addAttribute("schedule", schedule);
                logger.info("account-detail 페이지 렌더링 준비 완료");
                return "account-detail";
            } else {
                logger.warn("일정 정보를 찾을 수 없음: uid={}", uid);
                // 일정을 찾을 수 없는 경우 account-list로 리다이렉트
                return "redirect:/account-list";
            }
        } catch (Exception e) {
            logger.error("account-detail 처리 중 오류 발생: uid={}, error={}", uid, e.getMessage(), e);
            return "redirect:/account-list";
        }
    }

    @GetMapping("/account-detail-2")
    public String accountDetail2(
        @RequestParam(required = false) String scheduleId,
        @RequestParam(required = false) String homeTeam,
        @RequestParam(required = false) String awayTeam,
        @RequestParam(required = false) String gameDate,
        @RequestParam(required = false) String gameTime,
        @RequestParam(required = false) String selectedColor,
        @RequestParam(required = false) String seatPrice,
        Model model
    ) {
        // 현재 날짜 정보 추가 (좌측 메뉴용)
        LocalDate now = LocalDate.now();
        model.addAttribute("currentYear", now.getYear());
        model.addAttribute("currentMonth", now.getMonthValue());
        model.addAttribute("currentDate", now);
        
        // tsc 테이블에서 약관 데이터 가져오기
        Tsc tsc = tscService.getTsc();
        model.addAttribute("tsc", tsc);
        
        model.addAttribute("scheduleId", scheduleId);
        model.addAttribute("homeTeam", homeTeam);
        model.addAttribute("awayTeam", awayTeam);
        model.addAttribute("gameDate", gameDate);
        model.addAttribute("gameTime", gameTime);
        model.addAttribute("selectedColor", selectedColor);
        model.addAttribute("seatPrice", seatPrice);
        return "account-detail-2";
    }

    @GetMapping("/account-detail-3")
    public String accountDetail3(@RequestParam(required = false) Integer uid,
                                @RequestParam(required = false) String homeTeam,
                                @RequestParam(required = false) String awayTeam,
                                @RequestParam(required = false) String gameDate,
                                @RequestParam(required = false) String gameTime,
                                @RequestParam(required = false) String selectedColor,
                                @RequestParam(required = false) String seatPrice,
                                Model model) {
        try {
            logger.info("account-detail-3 페이지 요청: uid={}", uid);
            
            // 현재 날짜 정보 추가 (좌측 메뉴용)
            LocalDate now = LocalDate.now();
            model.addAttribute("currentYear", now.getYear());
            model.addAttribute("currentMonth", now.getMonthValue());
            model.addAttribute("currentDate", now);
            
            if (uid != null) {
                // schedule_info 테이블에서 uid로 데이터 조회
                Optional<ScheduleInfo> scheduleInfo = scheduleInfoService.findById(uid);
                if (scheduleInfo.isPresent()) {
                    ScheduleInfo schedule = scheduleInfo.get();
                    model.addAttribute("scheduleInfo", schedule);
                    
                    // 홈팀 이름을 기준으로 team_info 테이블에서 좌석 이미지 조회
                    List<TeamInfo> teamInfoList = teamInfoService.findByTeamName(schedule.getHomeTeam());
                    if (!teamInfoList.isEmpty() && teamInfoList.get(0).getSeatImg() != null) {
                        model.addAttribute("homeTeamSeatImg", teamInfoList.get(0).getSeatImg());
                        logger.info("팀 정보 좌석 이미지 조회 성공: homeTeam={}, image={}", 
                            schedule.getHomeTeam(), teamInfoList.get(0).getSeatImg());
                    } else {
                        logger.warn("팀 정보 좌석 이미지를 찾을 수 없음: homeTeam={}", schedule.getHomeTeam());
                        model.addAttribute("homeTeamSeatImg", "all.jpg"); // 기본 이미지
                    }
                    
                    // 선택된 색상에 따른 가격 설정
                    Integer price = null;
                    switch (selectedColor != null ? selectedColor.toLowerCase() : "") {
                        case "orange":
                            price = schedule.getOrange();
                            break;
                        case "yellow":
                            price = schedule.getYellow();
                            break;
                        case "green":
                            price = schedule.getGreen();
                            break;
                        case "blue":
                            price = schedule.getBlue();
                            break;
                        case "purple":
                            price = schedule.getPurple();
                            break;
                        case "red":
                            price = schedule.getRed();
                            break;
                        case "black":
                            price = schedule.getBlack();
                            break;
                        default:
                            price = schedule.getFee(); // 기본 가격
                    }
                    
                    model.addAttribute("selectedColor", selectedColor);
                    model.addAttribute("seatPrice", price != null ? price : 0);
                }
            } else {
                // URL 파라미터로 전달된 정보 사용
                model.addAttribute("homeTeam", homeTeam);
                model.addAttribute("awayTeam", awayTeam);
                model.addAttribute("gameDate", gameDate);
                model.addAttribute("gameTime", gameTime);
                model.addAttribute("selectedColor", selectedColor);
                model.addAttribute("seatPrice", seatPrice != null ? Integer.parseInt(seatPrice) : 0);
                
                // 홈팀의 좌석 이미지 조회
                if (homeTeam != null) {
                    List<TeamInfo> teamInfoList = teamInfoService.findByTeamName(homeTeam);
                    if (!teamInfoList.isEmpty() && teamInfoList.get(0).getSeatImg() != null) {
                        model.addAttribute("homeTeamSeatImg", teamInfoList.get(0).getSeatImg());
                    } else {
                        model.addAttribute("homeTeamSeatImg", "all.jpg"); // 기본 이미지
                    }
                }
            }
            
            return "account-detail-3";
        } catch (Exception e) {
            logger.error("account-detail-3 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지 로드 중 오류가 발생했습니다.");
            return "account-detail-3";
        }
    }
    
    @PostMapping("/send-reservation-email")
    @ResponseBody
    public String sendReservationEmail(ReservationEmailDto emailDto) {
        try {
            logger.info("이메일 발송 요청: uid={}, customerEmail={}", emailDto.getUid(), emailDto.getCustomerEmail());
            
            // 이메일 제목 생성
            String subject = "[유로풋볼투어] 축구 티켓 예약 확인";
            
            // HTML 이메일 내용 생성
            String htmlContent = emailService.createHtmlEmailContent(
                emailDto.getHomeTeam(),
                emailDto.getAwayTeam(),
                emailDto.getGameDate(),
                emailDto.getGameTime(),
                emailDto.getSelectedColor(),
                emailDto.getSeatPrice(),
                emailDto.getCustomerName(),
                emailDto.getCustomerEmail(),
                emailDto.getCustomerPhone(),
                emailDto.getCustomerBirth(),
                emailDto.getCustomerPassport(),
                emailDto.getCustomerAddress(),
                emailDto.getCustomerDetailAddress(),
                emailDto.getCustomerEnglishAddress(),
                emailDto.getCustomerKakaoId(),
                emailDto.getCustomerGender(), // 추가
                emailDto.getPaymentMethod(),
                emailDto.getSeatReplacement(), // 추가
                emailDto.getConsecutiveSeats(), // 추가
                emailDto.getSpecialRequests()
            );
            
            // 이메일 발송
            emailService.sendReservationEmail(emailDto.getCustomerEmail(), subject, htmlContent);
            
            logger.info("이메일 발송 성공: {}", emailDto.getCustomerEmail());
            return "success";
            
        } catch (Exception e) {
            logger.error("이메일 발송 실패: {}", e.getMessage(), e);
            return "error";
        }
    }
    
    @PostMapping("/save-reservation")
    @ResponseBody
    public String saveReservation(@org.springframework.web.bind.annotation.RequestBody String requestBody) {
        try {
            logger.info("예약 저장 요청 시작");
            logger.info("요청 데이터: {}", requestBody);
            
            ObjectMapper objectMapper = new ObjectMapper();
            var jsonNode = objectMapper.readTree(requestBody);
            
            // 받은 JSON 데이터의 모든 필드를 로깅
            logger.info("=== 받은 JSON 데이터 필드들 ===");
            jsonNode.fieldNames().forEachRemaining(fieldName -> {
                logger.info("필드: {} = {}", fieldName, jsonNode.get(fieldName));
            });
            logger.info("=== JSON 데이터 로깅 완료 ===");
            
            // RegisterSchedule 엔티티 생성
            RegisterSchedule registerSchedule = new RegisterSchedule();
            
            try {
                // 일정 정보 설정 - 예약번호 자동 생성
                String generatedUid = registerScheduleService.generateReservationUid();
                registerSchedule.setUid(generatedUid);
                registerSchedule.setHomeTeam(getJsonValue(jsonNode, "homeTeam", ""));
                registerSchedule.setAwayTeam(getJsonValue(jsonNode, "awayTeam", ""));
                registerSchedule.setGameDate(getJsonValue(jsonNode, "gameDate", ""));
                registerSchedule.setGameTime(getJsonValue(jsonNode, "gameTime", ""));
                registerSchedule.setSelectedColor(getJsonValue(jsonNode, "selectedColor", ""));
                registerSchedule.setSeatPrice(getJsonValue(jsonNode, "seatPrice", ""));
                
                logger.info("일정 정보 설정 완료: uid={}, homeTeam={}, awayTeam={}", 
                    registerSchedule.getUid(), registerSchedule.getHomeTeam(), registerSchedule.getAwayTeam());
                
                // 예약자 정보 설정
                registerSchedule.setCustomerName(getJsonValue(jsonNode, "customerName", ""));
                registerSchedule.setCustomerGender(getJsonValue(jsonNode, "customerGender", ""));
                registerSchedule.setCustomerPassport(getJsonValue(jsonNode, "customerPassport", ""));
                registerSchedule.setCustomerPhone(getJsonValue(jsonNode, "customerPhone", ""));
                registerSchedule.setCustomerEmail(getJsonValue(jsonNode, "customerEmail", ""));
                
                // 생년월일 처리 (null 체크 추가)
                String customerBirthStr = getJsonValue(jsonNode, "customerBirth", "");
                if (customerBirthStr != null && !customerBirthStr.isEmpty()) {
                    registerSchedule.setCustomerBirth(java.time.LocalDate.parse(customerBirthStr));
                } else {
                    registerSchedule.setCustomerBirth(java.time.LocalDate.now()); // 기본값 설정
                }
                
                registerSchedule.setCustomerAddress(getJsonValue(jsonNode, "customerAddress", ""));
                registerSchedule.setCustomerAddressDetail(getJsonValue(jsonNode, "customerAddressDetail", ""));
                registerSchedule.setCustomerDetailAddress(getJsonValue(jsonNode, "customerDetailAddress", ""));
                registerSchedule.setCustomerEnglishAddress(getJsonValue(jsonNode, "customerEnglishAddress", ""));
                
                // 카카오톡 ID는 선택사항이므로 null 체크
                registerSchedule.setCustomerKakaoId(getJsonValue(jsonNode, "customerKakaoId", ""));
                
                logger.info("예약자 정보 설정 완료: customerName={}, customerEmail={}", 
                    registerSchedule.getCustomerName(), registerSchedule.getCustomerEmail());
                
                // 티켓 예약 정보 설정
                String ticketQuantityStr = getJsonValue(jsonNode, "ticketQuantity", "1");
                registerSchedule.setTicketQuantity(Integer.parseInt(ticketQuantityStr));
                registerSchedule.setTotalPrice(getJsonValue(jsonNode, "totalPrice", ""));
                registerSchedule.setPaymentMethod(getJsonValue(jsonNode, "paymentMethod", ""));
                registerSchedule.setSeatAlternative(getJsonValue(jsonNode, "seatAlternative", ""));
                registerSchedule.setAdjacentSeat(getJsonValue(jsonNode, "adjacentSeat", ""));
                
                // 추가 요청사항은 선택사항이므로 null 체크
                registerSchedule.setAdditionalRequests(getJsonValue(jsonNode, "additionalRequests", ""));
                
                logger.info("티켓 예약 정보 설정 완료: ticketQuantity={}, totalPrice={}", 
                    registerSchedule.getTicketQuantity(), registerSchedule.getTotalPrice());
                
                // 동행자 정보 JSON으로 저장
                if (jsonNode.has("companions") && !jsonNode.get("companions").isNull()) {
                    registerSchedule.setCompanions(jsonNode.get("companions").toString());
                    logger.info("동행자 정보 설정 완료: companions={}", registerSchedule.getCompanions());
                } else {
                    registerSchedule.setCompanions("[]");
                    logger.info("동행자 정보 없음 - 빈 배열로 설정");
                }
                
            } catch (Exception e) {
                logger.error("데이터 매핑 중 오류 발생: {}", e.getMessage(), e);
                return "error: 데이터 매핑 실패 - " + e.getMessage();
            }
            
            // 필수 필드 검증
            if (registerSchedule.getCustomerName() == null || registerSchedule.getCustomerName().isEmpty()) {
                logger.error("예약자 이름이 누락되었습니다.");
                return "error: 예약자 이름이 누락되었습니다.";
            }
            
            if (registerSchedule.getCustomerEmail() == null || registerSchedule.getCustomerEmail().isEmpty()) {
                logger.error("예약자 이메일이 누락되었습니다.");
                return "error: 예약자 이메일이 누락되었습니다.";
            }
            
            if (registerSchedule.getCustomerPhone() == null || registerSchedule.getCustomerPhone().isEmpty()) {
                logger.error("예약자 전화번호가 누락되었습니다.");
                return "error: 예약자 전화번호가 누락되었습니다.";
            }
            
            if (registerSchedule.getHomeTeam() == null || registerSchedule.getHomeTeam().isEmpty()) {
                logger.error("홈팀 정보가 누락되었습니다.");
                return "error: 홈팀 정보가 누락되었습니다.";
            }
            
            if (registerSchedule.getAwayTeam() == null || registerSchedule.getAwayTeam().isEmpty()) {
                logger.error("원정팀 정보가 누락되었습니다.");
                return "error: 원정팀 정보가 누락되었습니다.";
            }
            
            // 데이터베이스에 저장
            try {
                logger.info("데이터베이스 저장 시작");
                RegisterSchedule savedReservation = registerScheduleService.saveReservation(registerSchedule);
                logger.info("예약 저장 성공: ID={}", savedReservation.getId());
                
                // 저장된 데이터 확인
                logger.info("저장된 예약 정보: uid={}, customerName={}, customerEmail={}", 
                    savedReservation.getUid(), savedReservation.getCustomerName(), savedReservation.getCustomerEmail());
                
            } catch (Exception e) {
                logger.error("데이터베이스 저장 중 오류 발생: {}", e.getMessage(), e);
                return "error: 데이터베이스 저장 실패 - " + e.getMessage();
            }
            
            // 이메일 발송
            try {
                logger.info("이메일 발송 시작");
                ReservationEmailDto emailDto = new ReservationEmailDto();
                emailDto.setCustomerEmail(registerSchedule.getCustomerEmail());
                emailDto.setCustomerName(registerSchedule.getCustomerName());
                emailDto.setHomeTeam(registerSchedule.getHomeTeam());
                emailDto.setAwayTeam(registerSchedule.getAwayTeam());
                emailDto.setGameDate(registerSchedule.getGameDate());
                emailDto.setGameTime(registerSchedule.getGameTime());
                emailDto.setSelectedColor(registerSchedule.getSelectedColor());
                emailDto.setSeatPrice(registerSchedule.getSeatPrice());
                emailDto.setPaymentMethod(registerSchedule.getPaymentMethod());
                emailDto.setSeatReplacement(registerSchedule.getSeatAlternative());
                emailDto.setConsecutiveSeats(registerSchedule.getAdjacentSeat());
                emailDto.setSpecialRequests(registerSchedule.getAdditionalRequests());
                
                // 이메일 제목 생성
                String subject = "[유로풋볼투어] 축구 티켓 예약 확인";
                
                // HTML 이메일 내용 생성
                String htmlContent = emailService.createHtmlEmailContent(
                    emailDto.getHomeTeam(),
                    emailDto.getAwayTeam(),
                    emailDto.getGameDate(),
                    emailDto.getGameTime(),
                    emailDto.getSelectedColor(),
                    emailDto.getSeatPrice(),
                    emailDto.getCustomerName(),
                    emailDto.getCustomerEmail(),
                    emailDto.getCustomerPhone(),
                    emailDto.getCustomerBirth(),
                    emailDto.getCustomerPassport(),
                    emailDto.getCustomerAddress(),
                    emailDto.getCustomerDetailAddress(),
                    emailDto.getCustomerEnglishAddress(),
                    emailDto.getCustomerKakaoId(),
                    emailDto.getCustomerGender(),
                    emailDto.getPaymentMethod(),
                    emailDto.getSeatReplacement(),
                    emailDto.getConsecutiveSeats(),
                    emailDto.getSpecialRequests()
                );
                
                // 이메일 발송
                emailService.sendReservationEmail(emailDto.getCustomerEmail(), subject, htmlContent);
                logger.info("예약 이메일 발송 완료");
                
            } catch (Exception e) {
                logger.error("이메일 발송 중 오류 발생: {}", e.getMessage(), e);
                // 이메일 발송 실패해도 예약은 성공했으므로 계속 진행
            }
            
            logger.info("예약 저장 및 이메일 발송 완료");
            return "success";
            
        } catch (Exception e) {
            logger.error("예약 저장 중 오류 발생: {}", e.getMessage(), e);
            return "error: " + e.getMessage();
        }
    }

    // 이메일 발송 테스트 엔드포인트
    @GetMapping("/test-email")
    @ResponseBody
    public String testEmail() {
        try {
            logger.info("이메일 발송 테스트 시작");
            
            // 테스트용 이메일 데이터 생성
            ReservationEmailDto emailDto = new ReservationEmailDto();
            emailDto.setCustomerName("테스트 사용자");
            emailDto.setCustomerEmail("premierticket7@gmail.com"); // 실제 이메일로 변경
            emailDto.setHomeTeam("맨유");
            emailDto.setAwayTeam("첼시");
            emailDto.setGameDate("2025-07-15");
            emailDto.setGameTime("16:30");
            emailDto.setSelectedColor("yellow");
            emailDto.setSeatPrice("320000");
            emailDto.setCustomerPhone("010-1234-5678");
            emailDto.setCustomerBirth("1990-01-01");
            emailDto.setCustomerPassport("TEST KIM");
            emailDto.setCustomerAddress("12345");
            emailDto.setCustomerAddressDetail("서울시 강남구");
            emailDto.setCustomerDetailAddress("123-456");
            emailDto.setCustomerEnglishAddress("Seoul Gangnam-gu");
            emailDto.setCustomerKakaoId("testkakao");
            emailDto.setCustomerGender("남");
            emailDto.setTicketQuantity("1");
            emailDto.setTotalPrice("320000");
            emailDto.setPaymentMethod("신용카드");
            emailDto.setSeatAlternative("아니오");
            emailDto.setAdjacentSeat("아니오");
            emailDto.setAdditionalRequests("테스트 예약");
            
            // 이메일 발송
            emailService.sendReservationEmail(emailDto);
            
            logger.info("이메일 발송 테스트 성공");
            return "이메일 발송 테스트 성공!";
            
        } catch (Exception e) {
            logger.error("이메일 발송 테스트 실패: {}", e.getMessage(), e);
            return "이메일 발송 테스트 실패: " + e.getMessage();
        }
    }

    // FAQ 목록 페이지
    @GetMapping("/faq")
    public String faq(@RequestParam(defaultValue = "0") int page, 
                     @RequestParam(required = false) String keyword,
                     @RequestParam(defaultValue = "all") String searchType,
                     Model model) {
        try {
            logger.info("FAQ 페이지 요청 - page: {}, keyword: {}, searchType: {}", page, keyword, searchType);
            
            // 페이지 번호가 음수인 경우 0으로 설정
            if (page < 0) {
                page = 0;
            }
            
            Page<Faq> faqPage;
            if (keyword != null && !keyword.trim().isEmpty()) {
                // 검색이 있는 경우
                logger.info("FAQ 검색 실행 - keyword: {}", keyword);
                switch (searchType) {
                    case "title":
                        faqPage = faqService.searchByTitle(keyword, page, 10);
                        break;
                    case "name":
                        faqPage = faqService.searchByName(keyword, page, 10);
                        break;
                    default:
                        faqPage = faqService.searchByTitleOrName(keyword, page, 10);
                        break;
                }
                model.addAttribute("keyword", keyword);
                model.addAttribute("searchType", searchType);
            } else {
                // 검색이 없는 경우
                logger.info("FAQ 전체 목록 조회 - page: {}", page);
                faqPage = faqService.getAllFaqs(page, 10);
            }
            
            logger.info("FAQ 조회 결과 - 총 개수: {}, 현재 페이지: {}, 총 페이지: {}", 
                       faqPage.getTotalElements(), page, faqPage.getTotalPages());
            
            // 데이터가 없고 페이지가 0이 아닌 경우 0페이지로 리다이렉트
            if (faqPage.getTotalElements() == 0 && page > 0) {
                logger.info("데이터가 없고 페이지가 0이 아님 - 0페이지로 리다이렉트");
                return "redirect:/faq?page=0";
            }
            
            // 현재 날짜 정보 추가 (좌측 메뉴용)
            LocalDate now = LocalDate.now();
            model.addAttribute("currentYear", now.getYear());
            model.addAttribute("currentMonth", now.getMonthValue());
            model.addAttribute("currentDate", now);
            
            // FaqDto로 변환
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            var faqDtos = faqPage.getContent().stream()
                .map(faq -> new FaqDto(
                    faq.getUid(),
                    faq.getTitle(),
                    faq.getNotice(),
                    faq.getRegdate() != null ? faq.getRegdate().format(formatter) : "-",
                    faq.getName()
                ))
                .collect(Collectors.toList());
            
            model.addAttribute("faqs", faqDtos);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", Math.max(0, faqPage.getTotalPages()));
            model.addAttribute("totalItems", faqPage.getTotalElements());
            model.addAttribute("hasNext", faqPage.hasNext());
            model.addAttribute("hasPrevious", faqPage.hasPrevious());
            
            // footer_info 데이터 추가
            try {
                FooterInfo footerInfo = footerInfoService.getFooterInfo();
                model.addAttribute("footerInfo", footerInfo);
            } catch (Exception e) {
                logger.error("footer_info 데이터 로드 중 오류 발생", e);
                model.addAttribute("footerInfo", null);
            }
            
            logger.info("FAQ 페이지 모델 설정 완료");
            return "faq";
        } catch (Exception e) {
            logger.error("FAQ 페이지 처리 중 오류 발생", e);
            model.addAttribute("error", "FAQ 목록을 불러오는 중 오류가 발생했습니다.");
            
            // 오류 발생 시 기본값 설정
            LocalDate now = LocalDate.now();
            model.addAttribute("currentYear", now.getYear());
            model.addAttribute("currentMonth", now.getMonthValue());
            model.addAttribute("currentDate", now);
            model.addAttribute("faqs", new ArrayList<>());
            model.addAttribute("currentPage", 0);
            model.addAttribute("totalPages", 0);
            model.addAttribute("totalItems", 0L);
            model.addAttribute("hasNext", false);
            model.addAttribute("hasPrevious", false);
            
            return "faq";
        }
    }
    
    // FAQ 상세 보기
    @GetMapping("/faq-detail")
    public String faqDetail(@RequestParam Integer uid, Model model) {
        logger.info("FAQ 상세 보기 요청 - uid: {}", uid);
        
        try {
            Optional<Faq> faq = faqService.getFaqById(uid);
            if (faq.isPresent()) {
                logger.info("FAQ 조회 성공 - uid: {}, title: {}, name: {}", 
                    faq.get().getUid(), faq.get().getTitle(), faq.get().getName());
                
                // 실제 content 데이터 로그 추가
                String content = faq.get().getContent();
                logger.info("FAQ content 데이터: {}", content);
                
                // 현재 날짜 정보 추가 (좌측 메뉴용)
                LocalDate now = LocalDate.now();
                model.addAttribute("currentYear", now.getYear());
                model.addAttribute("currentMonth", now.getMonthValue());
                model.addAttribute("currentDate", now);
                
                // FaqDto로 변환
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                FaqDto faqDto = new FaqDto(
                    faq.get().getUid(),
                    faq.get().getTitle(),
                    faq.get().getNotice(),
                    faq.get().getRegdate() != null ? faq.get().getRegdate().format(formatter) : "-",
                    faq.get().getName(),
                    content  // 원본 content 그대로 전달
                );
                
                logger.info("FaqDto 생성 완료 - uid: {}, title: {}, content 길이: {}", 
                    faqDto.getUid(), faqDto.getTitle(), 
                    faqDto.getContent() != null ? faqDto.getContent().length() : 0);
                
                model.addAttribute("faq", faqDto);
                
                // footer_info 데이터 추가
                try {
                    FooterInfo footerInfo = footerInfoService.getFooterInfo();
                    model.addAttribute("footerInfo", footerInfo);
                } catch (Exception e) {
                    logger.error("footer_info 데이터 로드 중 오류 발생", e);
                    model.addAttribute("footerInfo", null);
                }
                
                return "faq-detail";
            } else {
                logger.warn("FAQ를 찾을 수 없음 - uid: {}", uid);
                return "redirect:/faq";
            }
        } catch (Exception e) {
            logger.error("FAQ 상세 보기 처리 중 오류 발생 - uid: {}", uid, e);
            return "redirect:/faq";
        }
    }

    // FaqDto 내부 클래스 추가
    public static class FaqDto {
        private Integer uid;
        private String title;
        private String notice;
        private String regdate;
        private String name;
        private String content;
        
        public FaqDto(Integer uid, String title, String notice, String regdate, String name) {
            this.uid = uid;
            this.title = title;
            this.notice = notice;
            this.regdate = regdate;
            this.name = name;
        }
        
        public FaqDto(Integer uid, String title, String notice, String regdate, String name, String content) {
            this.uid = uid;
            this.title = title;
            this.notice = notice;
            this.regdate = regdate;
            this.name = name;
            this.content = content;
        }
        
        public Integer getUid() { return uid; }
        public String getTitle() { return title; }
        public String getNotice() { return notice; }
        public String getRegdate() { return regdate; }
        public String getName() { return name; }
        public String getContent() { return content; }
    }
} 