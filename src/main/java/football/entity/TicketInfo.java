package football.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "ticket_info")
public class TicketInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    public TicketInfo() {}
    public TicketInfo(String content) { this.content = content; }

    public Integer getUid() { return uid; }
    public void setUid(Integer uid) { this.uid = uid; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
} 