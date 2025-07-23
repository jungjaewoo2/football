package football.dto;

public class SeatPriceItem {
    private String seatName;
    private String price;
    
    public SeatPriceItem() {}
    
    public SeatPriceItem(String seatName, String price) {
        this.seatName = seatName;
        this.price = price;
    }
    
    public String getSeatName() {
        return seatName;
    }
    
    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }
    
    public String getPrice() {
        return price;
    }
    
    public void setPrice(String price) {
        this.price = price;
    }
} 