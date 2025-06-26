package football.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "seat_fee")
public class SeatFee {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;
    
    @Column(name = "seat_name", nullable = false)
    private String seatName;
    
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
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // 기본 생성자
    public SeatFee() {}
    
    // 생성자
    public SeatFee(String seatName, Integer orange, Integer yellow, Integer green, 
                   Integer blue, Integer purple, Integer red, Integer black) {
        this.seatName = seatName;
        this.orange = orange;
        this.yellow = yellow;
        this.green = green;
        this.blue = blue;
        this.purple = purple;
        this.red = red;
        this.black = black;
    }
    
    // Getter와 Setter 메서드들
    public Integer getUid() {
        return uid;
    }
    
    public void setUid(Integer uid) {
        this.uid = uid;
    }
    
    public String getSeatName() {
        return seatName;
    }
    
    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }
    
    public Integer getOrange() {
        return orange;
    }
    
    public void setOrange(Integer orange) {
        this.orange = orange;
    }
    
    public Integer getYellow() {
        return yellow;
    }
    
    public void setYellow(Integer yellow) {
        this.yellow = yellow;
    }
    
    public Integer getGreen() {
        return green;
    }
    
    public void setGreen(Integer green) {
        this.green = green;
    }
    
    public Integer getBlue() {
        return blue;
    }
    
    public void setBlue(Integer blue) {
        this.blue = blue;
    }
    
    public Integer getPurple() {
        return purple;
    }
    
    public void setPurple(Integer purple) {
        this.purple = purple;
    }
    
    public Integer getRed() {
        return red;
    }
    
    public void setRed(Integer red) {
        this.red = red;
    }
    
    public Integer getBlack() {
        return black;
    }
    
    public void setBlack(Integer black) {
        this.black = black;
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