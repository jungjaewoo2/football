package football.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "tsc")
public class Tsc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    public Tsc() {}
    public Tsc(String content) { this.content = content; }

    public Integer getUid() { return uid; }
    public void setUid(Integer uid) { this.uid = uid; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
} 