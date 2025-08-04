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

    @Column(name = "address")
    private String address;

    public FooterInfo() {}
    
    public FooterInfo(String phone, String email, String address) { 
        this.phone = phone; 
        this.email = email; 
        this.address = address;
    }

    public Integer getUid() { return uid; }
    public void setUid(Integer uid) { this.uid = uid; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
} 