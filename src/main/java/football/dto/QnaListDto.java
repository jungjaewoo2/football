package football.dto;

import java.time.LocalDateTime;

public class QnaListDto {
    private Integer uid;
    private String name;
    private String title;
    private String content;
    private String notice;
    private LocalDateTime regdate;
    private LocalDateTime createdAt;
    private Integer ref;
    private Integer parentPostId;
    private int replyCount;
    private boolean isReply;
    
    // 생성자
    public QnaListDto() {}
    
    public QnaListDto(Integer uid, String name, String title, String content, String notice, 
                      LocalDateTime regdate, LocalDateTime createdAt, Integer ref, 
                      Integer parentPostId, int replyCount, boolean isReply) {
        this.uid = uid;
        this.name = name;
        this.title = title;
        this.content = content;
        this.notice = notice;
        this.regdate = regdate;
        this.createdAt = createdAt;
        this.ref = ref;
        this.parentPostId = parentPostId;
        this.replyCount = replyCount;
        this.isReply = isReply;
    }
    
    // Getter와 Setter
    public Integer getUid() {
        return uid;
    }
    
    public void setUid(Integer uid) {
        this.uid = uid;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public String getNotice() {
        return notice;
    }
    
    public void setNotice(String notice) {
        this.notice = notice;
    }
    
    public LocalDateTime getRegdate() {
        return regdate;
    }
    
    public void setRegdate(LocalDateTime regdate) {
        this.regdate = regdate;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public Integer getRef() {
        return ref;
    }
    
    public void setRef(Integer ref) {
        this.ref = ref;
    }
    
    public Integer getParentPostId() {
        return parentPostId;
    }
    
    public void setParentPostId(Integer parentPostId) {
        this.parentPostId = parentPostId;
    }
    
    public int getReplyCount() {
        return replyCount;
    }
    
    public void setReplyCount(int replyCount) {
        this.replyCount = replyCount;
    }
    
    public boolean isReply() {
        return isReply;
    }
    
    public void setIsReply(boolean reply) {
        isReply = reply;
    }
}
