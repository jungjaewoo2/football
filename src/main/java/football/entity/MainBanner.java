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

    @Column(name = "url")
    private String url;

    public MainBanner() {}

    public MainBanner(String imgName, String img) {
        this.imgName = imgName;
        this.img = img;
    }

    public MainBanner(String imgName, String img, String url) {
        this.imgName = imgName;
        this.img = img;
        this.url = url;
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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
} 