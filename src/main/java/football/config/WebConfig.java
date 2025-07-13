package football.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 업로드된 파일들을 정적 리소스로 제공
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:src/main/webapp/uploads/");
        
        // assets 폴더를 정적 리소스로 제공
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/static/assets/");
    }
    
    // 중복 Bean 등록 제거: multipartResolver는 MultipartConfig에서만 등록
} 