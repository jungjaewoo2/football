package football.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class MultipartFilter extends OncePerRequestFilter {
    
    private static final Logger logger = LoggerFactory.getLogger(MultipartFilter.class);
    
    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                   HttpServletResponse response,
                                   FilterChain filterChain)
            throws ServletException, IOException {
        
        if (request.getContentType() != null && 
            request.getContentType().startsWith("multipart/")) {
            
            logger.info("===== Multipart Request Debug Info =====");
            logger.info("Content-Type: " + request.getContentType());
            logger.info("Request URI: " + request.getRequestURI());
            logger.info("Content-Length: " + request.getContentLength());
            logger.info("Request Method: " + request.getMethod());
            
            // Spring Boot의 표준 MultipartFile 방식만 사용하도록 변경
            // request.getParts() 호출을 제거하여 Tomcat의 파일 개수 제한을 우회
            logger.info("Multipart 요청 감지 - Spring Boot 표준 방식으로 처리");
            logger.info("파일 개수 제한 검증은 컨트롤러에서 수행됩니다.");
        }
        
        filterChain.doFilter(request, response);
    }
} 