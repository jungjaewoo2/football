package football.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "team_info")
public class TeamInfo {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;
    
    @Column(name = "team_name", nullable = false)
    private String teamName;
    
    @Column(name = "logo_img")
    private String logoImg;
    
    @Column(name = "stadium")
    private String stadium;
    
    @Column(name = "city")
    private String city;
    
    @Column(name = "seat_img")
    private String seatImg;
    
    @Column(name = "seat_img1")
    private String seatImg1;
    
    @Column(name = "content", columnDefinition = "TEXT")
    private String content;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // 기본 생성자
    public TeamInfo() {}
    
    // 생성자
    public TeamInfo(String teamName, String logoImg, 
                   String stadium, String city, String seatImg, String content) {
        this.teamName = teamName;
        this.logoImg = logoImg;
        this.stadium = stadium;
        this.city = city;
        this.seatImg = seatImg;
        this.content = content;
    }
    
    // Getter와 Setter 메서드들
    public Integer getUid() {
        return uid;
    }
    
    public void setUid(Integer uid) {
        this.uid = uid;
    }
    
    public String getTeamName() {
        return teamName;
    }
    
    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }
    

    
    public String getLogoImg() {
        return logoImg;
    }
    
    public void setLogoImg(String logoImg) {
        this.logoImg = logoImg;
    }
    
    public String getStadium() {
        return stadium;
    }
    
    public void setStadium(String stadium) {
        this.stadium = stadium;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getSeatImg() {
        return seatImg;
    }
    
    public void setSeatImg(String seatImg) {
        this.seatImg = seatImg;
    }
    
    public String getSeatImg1() {
        return seatImg1;
    }
    
    public void setSeatImg1(String seatImg1) {
        this.seatImg1 = seatImg1;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
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