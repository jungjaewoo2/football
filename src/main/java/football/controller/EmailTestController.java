package football.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import football.service.EmailService;

@RestController
public class EmailTestController {
    
    @Autowired
    private EmailService emailService;
    
    @GetMapping("/test-email")
    public String testEmail(@RequestParam(required = false, defaultValue = "test@example.com") String email) {
        try {
            System.out.println("=== EmailTestController 시작 ===");
            System.out.println("컨트롤러에서 받은 이메일: " + email);
            System.out.println("EmailService 객체: " + emailService);
            
            String subject = "[테스트] 이메일 발송 테스트";
            String content = "<h1>이메일 발송 테스트</h1>" +
                           "<p>안녕하세요!</p>" +
                           "<p>이것은 이메일 발송 테스트입니다.</p>" +
                           "<p>이 메일을 받으셨다면 이메일 설정이 정상적으로 작동하고 있습니다.</p>" +
                           "<br/>" +
                           "<p>유로풋볼투어</p>";
            
            System.out.println("EmailService.sendReservationEmail 호출 전");
            
            if (emailService == null) {
                System.out.println("!!! 오류: EmailService가 null입니다 !!!");
                return "EmailService가 null입니다.";
            }
            
            System.out.println("EmailService 메소드 호출 시작...");
            emailService.sendReservationEmail(email, subject, content);
            System.out.println("EmailService.sendReservationEmail 호출 후");
            
            System.out.println("=== EmailTestController 완료 ===");
            return "이메일 테스트 발송 요청이 완료되었습니다. 콘솔 로그를 확인해주세요.";
            
        } catch (Exception e) {
            System.err.println("=== EmailTestController 오류: " + e.getMessage() + " ===");
            e.printStackTrace();
            return "이메일 테스트 실패: " + e.getMessage();
        }
    }
}
