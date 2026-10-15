
package com.shopsphere.model;

import java.math.BigDecimal;

public class CartItem {

    private long cartItemId;
    private long userId;
    private long productId;
    private int quantity;

    // Optional product details for displaying the cart
    private String productName;
    private BigDecimal productPrice;
    private String imageUrl;

    // Default constructor
    public CartItem() {
    }

    // Constructor for adding a product to the cart
    public CartItem(long userId, long productId, int quantity) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public long getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
