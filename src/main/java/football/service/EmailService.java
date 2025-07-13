package football.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
    
    @Autowired
    private JavaMailSender mailSender;
    
    public void sendReservationEmail(String to, String subject, String content) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(content, true); // HTML 형식으로 설정
            
            mailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("이메일 발송 실패", e);
        }
    }
    
    public String createHtmlEmailContent(String homeTeam, String awayTeam, String gameDate, 
                                       String gameTime, String selectedColor, String seatPrice,
                                       String customerName, String customerEmail, String customerPhone,
                                       String customerBirth, String customerPassport, String customerAddress,
                                       String customerDetailAddress, String customerEnglishAddress,
                                       String customerKakaoId, String customerGender, // 추가
                                       String paymentMethod, String seatReplacement, String consecutiveSeats, // 추가
                                       String specialRequests) {
        
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>");
        html.append("<html>");
        html.append("<head>");
        html.append("<meta charset=\"UTF-8\">");
        html.append("<style>");
        html.append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }");
        html.append(".container { max-width: 600px; margin: 0 auto; padding: 20px; }");
        html.append(".header { background-color: #e41b23; color: white; padding: 20px; text-align: center; }");
        html.append(".section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }");
        html.append(".section h3 { color: #e41b23; margin-top: 0; }");
        html.append(".info-row { margin: 10px 0; }");
        html.append(".label { font-weight: bold; color: #555; }");
        html.append(".value { margin-left: 10px; }");
        html.append(".footer { background-color: #f5f5f5; padding: 15px; text-align: center; margin-top: 20px; }");
        html.append(".highlight { background-color: #fff3cd; padding: 10px; border-radius: 5px; margin: 10px 0; }");
        html.append("</style>");
        html.append("</head>");
        html.append("<body>");
        html.append("<div class=\"container\">");
        html.append("<div class=\"header\">");
        html.append("<h1>유로풋볼투어</h1>");
        html.append("<h2>축구 티켓 예약 확인</h2>");
        html.append("</div>");
        
        html.append("<div class=\"highlight\">");
        html.append("<strong>안녕하세요, ").append(customerName).append("님!</strong><br>");
        html.append("축구 티켓 예약이 완료되었습니다.");
        html.append("</div>");
        
        html.append("<div class=\"section\">");
        html.append("<h3>경기 정보</h3>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">홈팀:</span>");
        html.append("<span class=\"value\">").append(homeTeam).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">원정팀:</span>");
        html.append("<span class=\"value\">").append(awayTeam).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">경기일:</span>");
        html.append("<span class=\"value\">").append(gameDate).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">경기시간:</span>");
        html.append("<span class=\"value\">").append(gameTime).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">선택좌석:</span>");
        html.append("<span class=\"value\">").append(selectedColor).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">좌석가격:</span>");
        html.append("<span class=\"value\">").append(seatPrice).append("원</span>");
        html.append("</div>");
        html.append("</div>");
        
        html.append("<div class=\"section\">");
        html.append("<h3>고객 정보</h3>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">이름:</span>");
        html.append("<span class=\"value\">").append(customerName).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">성별:</span>");
        html.append("<span class=\"value\">").append(customerGender != null ? customerGender : "").append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">이메일:</span>");
        html.append("<span class=\"value\">").append(customerEmail).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">전화번호:</span>");
        html.append("<span class=\"value\">").append(customerPhone).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">생년월일:</span>");
        html.append("<span class=\"value\">").append(customerBirth).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">여권번호:</span>");
        html.append("<span class=\"value\">").append(customerPassport).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">주소:</span>");
        html.append("<span class=\"value\">").append(customerAddress).append(" ").append(customerDetailAddress).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">영문주소:</span>");
        html.append("<span class=\"value\">").append(customerEnglishAddress).append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">카카오톡ID:</span>");
        html.append("<span class=\"value\">").append(customerKakaoId).append("</span>");
        html.append("</div>");
        html.append("</div>");
        
        html.append("<div class=\"section\">");
        html.append("<h3>예약 옵션</h3>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">좌석 대체 확보:</span>");
        html.append("<span class=\"value\">").append(seatReplacement != null ? seatReplacement : "").append("</span>");
        html.append("</div>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">연석희망여부:</span>");
        html.append("<span class=\"value\">").append(consecutiveSeats != null ? consecutiveSeats : "").append("</span>");
        html.append("</div>");
        html.append("</div>");
        
        html.append("<div class=\"section\">");
        html.append("<h3>결제 정보</h3>");
        html.append("<div class=\"info-row\">");
        html.append("<span class=\"label\">결제방법:</span>");
        html.append("<span class=\"value\">").append(paymentMethod).append("</span>");
        html.append("</div>");
        html.append("</div>");
        
        if (specialRequests != null && !specialRequests.trim().isEmpty()) {
            html.append("<div class=\"section\">");
            html.append("<h3>특별 요청사항</h3>");
            html.append("<div class=\"info-row\">");
            html.append("<span class=\"value\">").append(specialRequests).append("</span>");
            html.append("</div>");
            html.append("</div>");
        }
        
        html.append("<div class=\"section\">");
        html.append("<h3>안내사항</h3>");
        html.append("<ul>");
        html.append("<li>티켓은 경기 1-3일 전에 이메일로 발송됩니다.</li>");
        html.append("<li>모바일 e-티켓으로 QR코드를 스캔하여 입장하시면 됩니다.</li>");
        html.append("<li>문의사항이 있으시면 070-7779-9614로 연락주세요.</li>");
        html.append("<li>예약 변경 및 취소는 경기 7일 전까지 가능합니다.</li>");
        html.append("</ul>");
        html.append("</div>");
        
        html.append("<div class=\"footer\">");
        html.append("<p><strong>감사합니다.</strong></p>");
        html.append("<p>유로풋볼투어</p>");
        html.append("<p>premierticket7@gmail.com | 070-7779-9614</p>");
        html.append("</div>");
        html.append("</div>");
        html.append("</body>");
        html.append("</html>");
        
        return html.toString();
    }
} 