package football.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "faq")
public class Faq {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "title", nullable = false, length = 200)
    private String title;
    
    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;
    
    @Column(name = "notice", nullable = false, length = 1, columnDefinition = "CHAR(1) DEFAULT 'N'")
    private String notice = "N";
    
    @Column(name = "regdate", columnDefinition = "DATETIME(6)")
    private LocalDateTime regdate;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // 기본 생성자
    public Faq() {
        // regdate는 서비스에서 설정하므로 여기서는 설정하지 않음
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.notice = "N";
    }
    
    // 생성자
    public Faq(String name, String title, String content) {
        this();
        this.name = name;
        this.title = title;
        this.content = content;
    }
    
    // Getter와 Setter
    public Integer getUid() {
        return uid;
    }
    
    public void setUid(Integer uid) {
        this.uid = uid;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public String getNotice() {
        return notice;
    }
    
    public void setNotice(String notice) {
        this.notice = notice;
    }
    
    public LocalDateTime getRegdate() {
        return regdate;
    }
    
    public void setRegdate(LocalDateTime regdate) {
        this.regdate = regdate;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "Faq{" +
                "uid=" + uid +
                ", name='" + name + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", notice='" + notice + '\'' +
                ", regdate=" + regdate +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
} 