package com.skillconnect.models;

import java.sql.Date;
import java.sql.Time;

public class Booking {
    private int bookingId;
    private int customerId;
    private int workerId;
    private int serviceId;
    private Date bookingDate;
    private Time bookingTime;
    private String status;

    // Constructors
    public Booking() {}

    public Booking(int bookingId, int customerId, int workerId, int serviceId, Date bookingDate, Time bookingTime, String status) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.workerId = workerId;
        this.serviceId = serviceId;
        this.bookingDate = bookingDate;
        this.bookingTime = bookingTime;
        this.status = status;
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getWorkerId() { return workerId; }
    public void setWorkerId(int workerId) { this.workerId = workerId; }

    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public Date getBookingDate() { return bookingDate; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }

    public Time getBookingTime() { return bookingTime; }
    public void setBookingTime(Time bookingTime) { this.bookingTime = bookingTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
