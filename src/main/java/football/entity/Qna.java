package football.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "qna")
public class Qna {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer uid;
    
    @Column(name = "user_id")
    private Integer userId;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "passwd", nullable = false, length = 100, columnDefinition = "VARCHAR(100) DEFAULT 'admin'")
    private String passwd = "admin";
    

    
    @Column(name = "title", nullable = false, length = 200)
    private String title;
    
    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;
    
    @Column(name = "notice", nullable = false, length = 1, columnDefinition = "CHAR(1) DEFAULT 'N'")
    private String notice = "N";
    
    @Column(name = "regdate", nullable = false)
    private LocalDateTime regdate;
    
    @Column(name = "parent_post_id")
    private Integer parentPostId;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @Column(name = "ref", columnDefinition = "INT DEFAULT 0")
    private Integer ref = 0;
    
    // 생성자
    public Qna() {
        this.notice = "N";
        this.passwd = "admin";
    }
    
    public Qna(String name, String title, String content) {
        this();
        this.name = name;
        this.title = title;
        this.content = content;
        this.passwd = "admin"; // 기본 비밀번호 설정
        this.notice = "N"; // 기본 공지사항 설정
        this.regdate = LocalDateTime.now();
    }
    
    public Qna(String name, String title, String content, String notice) {
        this();
        this.name = name;
        this.title = title;
        this.content = content;
        this.passwd = "admin"; // 기본 비밀번호 설정
        this.notice = notice != null ? notice : "N"; // 공지사항 설정
        this.regdate = LocalDateTime.now();
    }
    
    // Getter와 Setter
    public Integer getUid() {
        return uid;
    }
    
    public void setUid(Integer uid) {
        this.uid = uid;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getPasswd() {
        return passwd;
    }
    
    public void setPasswd(String passwd) {
        this.passwd = passwd;
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
    
    public Integer getParentPostId() {
        return parentPostId;
    }
    
    public void setParentPostId(Integer parentPostId) {
        this.parentPostId = parentPostId;
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
    
    public Integer getRef() {
        return ref;
    }
    
    public void setRef(Integer ref) {
        this.ref = ref;
    }
    
    @Override
    public String toString() {
        return "Qna{" +
                "uid=" + uid +
                ", userId=" + userId +
                ", name='" + name + '\'' +
                ", passwd='" + passwd + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", notice='" + notice + '\'' +
                ", regdate=" + regdate +
                ", parentPostId=" + parentPostId +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", ref=" + ref +
                '}';
    }
} 