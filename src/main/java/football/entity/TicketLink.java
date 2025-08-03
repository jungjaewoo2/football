package football.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "ticket_link")
public class TicketLink {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;

    @Column(name = "ticket_name", nullable = false)
    private String ticketName;

    @Column(name = "ticket_sub_title")
    private String ticketSubTitle;

    @Column(name = "ticket_img")
    private String ticketImg;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @Column(name = "link")
    private String link;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public TicketLink() {}

    public TicketLink(String ticketName, String ticketSubTitle, String ticketImg, String content, String link) {
        this.ticketName = ticketName;
        this.ticketSubTitle = ticketSubTitle;
        this.ticketImg = ticketImg;
        this.content = content;
        this.link = link;
    }

    // Getters and Setters
    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getTicketName() {
        return ticketName;
    }

    public void setTicketName(String ticketName) {
        this.ticketName = ticketName;
    }

    public String getTicketSubTitle() {
        return ticketSubTitle;
    }

    public void setTicketSubTitle(String ticketSubTitle) {
        this.ticketSubTitle = ticketSubTitle;
    }

    public String getTicketImg() {
        return ticketImg;
    }

    public void setTicketImg(String ticketImg) {
        this.ticketImg = ticketImg;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
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
} 