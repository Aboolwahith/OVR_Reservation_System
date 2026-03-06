package com.ovr.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Reservation {

    private int reservationId;
    private String reservationNumber;
    private String guestName;
    private String address;
    private String contactNumber;
    private int roomTypeId;
    private Date checkIn;
    private Date checkOut;
    private Timestamp createdAt;

    public Reservation() {}

    public Reservation(String reservationNumber, String guestName, String address,
                       String contactNumber, int roomTypeId, Date checkIn, Date checkOut) {
        this.reservationNumber = reservationNumber;
        this.guestName         = guestName;
        this.address           = address;
        this.contactNumber     = contactNumber;
        this.roomTypeId        = roomTypeId;
        this.checkIn           = checkIn;
        this.checkOut          = checkOut;
    }

    public int    getReservationId()            { return reservationId; }
    public void   setReservationId(int id)      { this.reservationId = id; }

    public String getReservationNumber()                   { return reservationNumber; }
    public void   setReservationNumber(String n)           { this.reservationNumber = n; }

    public String getGuestName()                { return guestName; }
    public void   setGuestName(String n)        { this.guestName = n; }

    public String getAddress()                  { return address; }
    public void   setAddress(String a)          { this.address = a; }

    public String getContactNumber()            { return contactNumber; }
    public void   setContactNumber(String c)    { this.contactNumber = c; }

    public int    getRoomTypeId()               { return roomTypeId; }
    public void   setRoomTypeId(int id)         { this.roomTypeId = id; }

    public Date   getCheckIn()                  { return checkIn; }
    public void   setCheckIn(Date d)            { this.checkIn = d; }

    public Date   getCheckOut()                 { return checkOut; }
    public void   setCheckOut(Date d)           { this.checkOut = d; }

    public Timestamp getCreatedAt()             { return createdAt; }
    public void      setCreatedAt(Timestamp t)  { this.createdAt = t; }
}
