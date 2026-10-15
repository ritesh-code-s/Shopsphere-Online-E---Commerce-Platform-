
package com.shopsphere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {

    private long orderId;
    private long userId;
    private BigDecimal totalAmount;
    private String status;
    private String shippingAddress;
    private Timestamp createdAt;

    // Default constructor
    public Order() {
    }

    // Constructor for creating an order
    public Order(long userId, BigDecimal totalAmount,
            String shippingAddress) {
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.status = "PLACED";
    }

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
