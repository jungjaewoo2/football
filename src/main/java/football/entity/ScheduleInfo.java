package football.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "schedule_info")
public class ScheduleInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;

    @Column(name = "game_category", nullable = false)
    private String gameCategory;

    @Column(name = "home_stadium", nullable = false)
    private String homeStadium;

    @Column(name = "home_team", nullable = false)
    private String homeTeam;

    @Column(name = "other_team", nullable = false)
    private String otherTeam;

    @Column(name = "game_date", nullable = false)
    private String gameDate;

    @Column(name = "game_time", nullable = false)
    private String gameTime;

    @Column(name = "fee")
    private Integer fee;

    @Column(name = "seat_price", columnDefinition = "TEXT")
    private String seatPrice;

    @Column(name = "seat_etc", columnDefinition = "TEXT")
    private String seatEtc;

    @Column(name = "orange")
    private Integer orange;

    @Column(name = "yellow")
    private Integer yellow;

    @Column(name = "green")
    private Integer green;

    @Column(name = "blue")
    private Integer blue;

    @Column(name = "purple")
    private Integer purple;

    @Column(name = "red")
    private Integer red;

    @Column(name = "black")
    private Integer black;

    @Column(name = "img")
    private String img;

    @Column(name = "seat_img")
    private String seatImg;

    @Column(name = "seat_img1")
    private String seatImg1;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public ScheduleInfo() {}

    public Integer getUid() { return uid; }
    public void setUid(Integer uid) { this.uid = uid; }
    public String getGameCategory() { return gameCategory; }
    public void setGameCategory(String gameCategory) { this.gameCategory = gameCategory; }
    public String getHomeStadium() { return homeStadium; }
    public void setHomeStadium(String homeStadium) { this.homeStadium = homeStadium; }
    public String getHomeTeam() { return homeTeam; }
    public void setHomeTeam(String homeTeam) { this.homeTeam = homeTeam; }
    public String getOtherTeam() { return otherTeam; }
    public void setOtherTeam(String otherTeam) { this.otherTeam = otherTeam; }
    public String getGameDate() { return gameDate; }
    public void setGameDate(String gameDate) { this.gameDate = gameDate; }
    public String getGameTime() { return gameTime; }
    public void setGameTime(String gameTime) { this.gameTime = gameTime; }
    public Integer getFee() { return fee; }
    public void setFee(Integer fee) { this.fee = fee; }
    public String getSeatPrice() { return seatPrice; }
    public void setSeatPrice(String seatPrice) { this.seatPrice = seatPrice; }
    public String getSeatEtc() { return seatEtc; }
    public void setSeatEtc(String seatEtc) { this.seatEtc = seatEtc; }
    public Integer getOrange() { return orange; }
    public void setOrange(Integer orange) { this.orange = orange; }
    public Integer getYellow() { return yellow; }
    public void setYellow(Integer yellow) { this.yellow = yellow; }
    public Integer getGreen() { return green; }
    public void setGreen(Integer green) { this.green = green; }
    public Integer getBlue() { return blue; }
    public void setBlue(Integer blue) { this.blue = blue; }
    public Integer getPurple() { return purple; }
    public void setPurple(Integer purple) { this.purple = purple; }
    public Integer getRed() { return red; }
    public void setRed(Integer red) { this.red = red; }
    public Integer getBlack() { return black; }
    public void setBlack(Integer black) { this.black = black; }
    public String getImg() { return img; }
    public void setImg(String img) { this.img = img; }
    public String getSeatImg() { return seatImg; }
    public void setSeatImg(String seatImg) { this.seatImg = seatImg; }
    public String getSeatImg1() { return seatImg1; }
    public void setSeatImg1(String seatImg1) { this.seatImg1 = seatImg1; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
} 