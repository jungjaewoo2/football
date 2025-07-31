package football.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "main_img")
public class MainImg {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer uid;

    @Column(name = "img_name", nullable = false)
    private String imgName;

    @Column(name = "img", nullable = false)
    private String img;

    @Column(name = "link_url")
    private String linkUrl;

    public MainImg() {}

    public MainImg(String imgName, String img) {
        this.imgName = imgName;
        this.img = img;
    }

    public MainImg(String imgName, String img, String linkUrl) {
        this.imgName = imgName;
        this.img = img;
        this.linkUrl = linkUrl;
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

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }
} 