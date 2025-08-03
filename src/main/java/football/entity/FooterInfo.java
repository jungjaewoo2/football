package football.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "footer_info")
public class FooterInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Integer uid;

    @Column(name = "phone")
    private String phone;

    @Column(name = "email")
    private String email;

    public FooterInfo() {}
    
    public FooterInfo(String phone, String email) { 
        this.phone = phone; 
        this.email = email; 
    }

    public Integer getUid() { return uid; }
    public void setUid(Integer uid) { this.uid = uid; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
} 