package football.config;

import org.apache.tomcat.util.http.fileupload.impl.FileCountLimitExceededException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MultipartException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ControllerAdvice
public class GlobalExceptionHandler {
    
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    
    @ExceptionHandler(FileCountLimitExceededException.class)
    public ResponseEntity<String> handleFileCountLimitExceededException(FileCountLimitExceededException ex) {
        logger.error("File count limit exceeded: {}", ex.getMessage());
        return new ResponseEntity<>("파일 개수 제한을 초과했습니다. 최대 1개 파일만 업로드 가능합니다.", HttpStatus.BAD_REQUEST);
    }
    
    @ExceptionHandler(MultipartException.class)
    public ResponseEntity<String> handleMultipartException(MultipartException ex) {
        logger.error("Multipart exception: {}", ex.getMessage());
        if (ex.getCause() instanceof FileCountLimitExceededException) {
            return new ResponseEntity<>("파일 개수 제한을 초과했습니다. 최대 1개 파일만 업로드 가능합니다.", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("파일 업로드 중 오류가 발생했습니다.", HttpStatus.BAD_REQUEST);
    }
} 