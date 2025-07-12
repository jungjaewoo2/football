package football.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "main_banner")
public class MainBanner {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer uid;

    @Column(name = "img_name", nullable = false)
    private String imgName;

    @Column(name = "img", nullable = false)
    private String img;

    public MainBanner() {}

    public MainBanner(String imgName, String img) {
        this.imgName = imgName;
        this.img = img;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getImgName() {
        return imgName;
    }

    public void setImgName(String imgName) {
        this.imgName = imgName;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
} 