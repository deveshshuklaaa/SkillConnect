package com.skillconnect.models;

public class Rating {
    private int ratingId;
    private int bookingId;
    private int customerId;
    private int workerId;
    private int rating;
    private String feedback;

    // Constructors
    public Rating() {}

    public Rating(int ratingId, int bookingId, int customerId, int workerId, int rating, String feedback) {
        this.ratingId = ratingId;
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.workerId = workerId;
        this.rating = rating;
        this.feedback = feedback;
    }

    // Getters and Setters
    public int getRatingId() { return ratingId; }
    public void setRatingId(int ratingId) { this.ratingId = ratingId; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getWorkerId() { return workerId; }
    public void setWorkerId(int workerId) { this.workerId = workerId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }
}
