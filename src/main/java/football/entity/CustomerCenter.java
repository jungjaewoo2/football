package football.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "customer_center")
public class CustomerCenter {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;
    
    @Column(name = "content", columnDefinition = "TEXT")
    private String content;
    
    // 기본 생성자
    public CustomerCenter() {}
    
    // 생성자
    public CustomerCenter(String content) {
        this.content = content;
    }
    
    // Getter와 Setter
    public Integer getUid() {
        return uid;
    }
    
    public void setUid(Integer uid) {
        this.uid = uid;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
} 