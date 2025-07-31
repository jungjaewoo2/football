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
    
    @Column(name = "main")
    private String main;
    
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
    
    // JSP에서 사용할 임시 필드들 (데이터베이스에 저장되지 않음)
    @Transient
    private String mainDisplay;
    
    @Transient
    private String mainNChecked;
    
    @Transient
    private String mainYChecked;
    
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
    
    public String getMain() {
        return main;
    }
    
    public void setMain(String main) {
        this.main = main;
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
    
    // JSP에서 사용할 임시 필드들의 getter/setter
    public String getMainDisplay() {
        return mainDisplay;
    }
    
    public void setMainDisplay(String mainDisplay) {
        this.mainDisplay = mainDisplay;
    }
    
    public String getMainNChecked() {
        return mainNChecked;
    }
    
    public void setMainNChecked(String mainNChecked) {
        this.mainNChecked = mainNChecked;
    }
    
    public String getMainYChecked() {
        return mainYChecked;
    }
    
    public void setMainYChecked(String mainYChecked) {
        this.mainYChecked = mainYChecked;
    }
} 