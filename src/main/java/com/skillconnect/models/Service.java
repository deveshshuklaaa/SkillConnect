package com.skillconnect.models;

public class Service {
    private int serviceId;
    private int workerId;
    private String serviceName;
    private double price;
    private String status;
    private int categoryId;

    // Constructors
    public Service() {}

    public Service(int serviceId, int workerId, String serviceName, double price, String status, int categoryId) {
        this.serviceId = serviceId;
        this.workerId = workerId;
        this.serviceName = serviceName;
        this.price = price;
        this.status = status;
        this.categoryId = categoryId;
    }

    // Getters and Setters
    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public int getWorkerId() { return workerId; }
    public void setWorkerId(int workerId) { this.workerId = workerId; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
}
