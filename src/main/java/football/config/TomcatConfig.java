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
        connector.setMaxParameterCount(10000);
        connector.setMaxPostSize(100 * 1024 * 1024); // 100MB
        connector.setMaxSavePostSize(100 * 1024 * 1024); // 100MB
    }
} 