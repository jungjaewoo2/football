package football.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "popup")
public class Popup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer uid;

    @Column(name = "popup_name", nullable = false)
    private String popupName;

    @Column(name = "img", nullable = false)
    private String img;

    public Popup() {}

    public Popup(String popupName, String img) {
        this.popupName = popupName;
        this.img = img;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getPopupName() {
        return popupName;
    }

    public void setPopupName(String popupName) {
        this.popupName = popupName;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
} 