package com.ovr.model;

import java.math.BigDecimal;

public class RoomType {

    private int        roomTypeId;
    private String     roomCode;
    private String     typeName;
    private BigDecimal pricePerNight;

    public RoomType() {}

    public RoomType(int roomTypeId, String roomCode, String typeName, BigDecimal pricePerNight) {
        this.roomTypeId    = roomTypeId;
        this.roomCode      = roomCode;
        this.typeName      = typeName;
        this.pricePerNight = pricePerNight;
    }

    public int        getRoomTypeId()               { return roomTypeId; }
    public void       setRoomTypeId(int id)         { this.roomTypeId = id; }

    public String     getRoomCode()                 { return roomCode; }
    public void       setRoomCode(String c)         { this.roomCode = c; }

    public String     getTypeName()                 { return typeName; }
    public void       setTypeName(String n)         { this.typeName = n; }

    public BigDecimal getPricePerNight()            { return pricePerNight; }
    public void       setPricePerNight(BigDecimal p){ this.pricePerNight = p; }
}
