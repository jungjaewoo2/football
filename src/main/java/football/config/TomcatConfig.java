package football.config;

import org.apache.catalina.connector.Connector;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TomcatConfig {

    @Bean
    public ServletWebServerFactory servletContainer() {
        TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory();
        tomcat.addConnectorCustomizers(this::customizeConnector);
        return tomcat;
    }

    private void customizeConnector(Connector connector) {
        // 파일 개수 제한 해제 (FileCountLimitExceededException 해결)
        connector.setMaxPostSize(-1); // 무제한
        connector.setMaxParameterCount(10000); // 파라미터 개수 증가
        connector.setMaxSavePostSize(-1); // 무제한
        
        // Tomcat 추가 설정
        connector.setProperty("maxSwallowSize", "-1");
        connector.setProperty("maxHttpFormPostSize", "-1");
    }
} 