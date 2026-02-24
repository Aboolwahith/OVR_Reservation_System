package com.ovr.model;

/**
 * OVR – Guest Model
 * Maps directly to the `guests` table.
 *
 * guests(guest_id, full_name, address, country,
 *        phone_code, phone_number, created_at)
 */
public class Guest {

    private int    guestId;
    private String fullName;
    private String address;
    private String country;
    private String phoneCode;      // e.g. +94, +1
    private String phoneNumber;
    private String createdAt;      // Stored as String for JSP display

    // ── Constructors ──────────────────────────────────────────
    public Guest() {}

    public Guest(int guestId, String fullName, String address,
                 String country, String phoneCode,
                 String phoneNumber, String createdAt) {
        this.guestId     = guestId;
        this.fullName    = fullName;
        this.address     = address;
        this.country     = country;
        this.phoneCode   = phoneCode;
        this.phoneNumber = phoneNumber;
        this.createdAt   = createdAt;
    }

    // ── Business Helper ───────────────────────────────────────

    /**
     * Returns fully formatted phone number with dial code.
     * Example: +94 771234567
     */
    public String getFullPhone() {
        if (phoneCode != null && !phoneCode.isBlank()) {
            return phoneCode + " " + phoneNumber;
        }
        return phoneNumber;
    }

    /**
     * Returns initials from full name for avatar display.
     * "John Doe" → "JD"
     */
    public String getInitials() {
        if (fullName == null || fullName.isBlank()) return "?";
        String[] parts = fullName.trim().split("\\s+");
        if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
        return (parts[0].substring(0,1) + parts[parts.length-1].substring(0,1)).toUpperCase();
    }

    // ── Getters & Setters ─────────────────────────────────────
    public int    getGuestId()            { return guestId; }
    public void   setGuestId(int v)       { this.guestId = v; }

    public String getFullName()           { return fullName; }
    public void   setFullName(String v)   { this.fullName = v; }

    public String getAddress()            { return address; }
    public void   setAddress(String v)    { this.address = v; }

    public String getCountry()            { return country; }
    public void   setCountry(String v)    { this.country = v; }

    public String getPhoneCode()          { return phoneCode; }
    public void   setPhoneCode(String v)  { this.phoneCode = v; }

    public String getPhoneNumber()        { return phoneNumber; }
    public void   setPhoneNumber(String v){ this.phoneNumber = v; }

    public String getCreatedAt()          { return createdAt; }
    public void   setCreatedAt(String v)  { this.createdAt = v; }

    @Override
    public String toString() {
        return "Guest{id=" + guestId + ", name='" + fullName + "', country='" + country + "'}";
    }
}
