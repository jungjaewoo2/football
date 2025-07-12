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
            logger.info("Multipart request received");
            logger.info("Content-Type: " + request.getContentType());
            logger.info("Content-Length: " + request.getContentLength());
            logger.info("Request URI: " + request.getRequestURI());
            logger.info("Request Method: " + request.getMethod());
        }
        
        filterChain.doFilter(request, response);
    }
} 