<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.math.BigDecimal" %>
            <%@ page import="com.shopsphere.model.CartItem" %>

                <%! private String escapeHtml(String value) { if (value==null) return "" ; return
                    value.replace("&", "&amp;" ) .replace("<", "&lt;" ) .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
                    }
                    %>

                    <% List<CartItem> items =
                        (List<CartItem>) request.getAttribute("cartItems");

                            BigDecimal total =
                            (BigDecimal) request.getAttribute("totalAmount");

                            if (items == null || total == null) {
                            response.sendRedirect(
                            request.getContextPath() + "/checkout");
                            return;
                            }

                            String errorMessage =
                            (String) request.getAttribute("errorMessage");
                            %>

                            <!DOCTYPE html>
                            <html lang="en">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                                <title>Checkout | ShopSphere</title>

                                <style>
                                    * {
                                        box-sizing: border-box;
                                        margin: 0;
                                        padding: 0;
                                    }

                                    body {
                                        font-family: Arial, sans-serif;
                                        background: #f5f7fb;
                                        color: #202938;
                                        line-height: 1.6;
                                    }

                                    header {
                                        background: #172554;
                                        color: white;
                                        padding: 18px 7%;
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        gap: 15px;
                                    }

                                    header h1 {
                                        font-size: 25px;
                                    }

                                    header a {
                                        color: white;
                                        text-decoration: none;
                                    }

                                    .container {
                                        max-width: 1050px;
                                        width: 92%;
                                        margin: 35px auto;
                                    }

                                    .page-heading {
                                        margin-bottom: 25px;
                                    }

                                    .page-heading h2 {
                                        font-size: 30px;
                                        margin-bottom: 5px;
                                    }

                                    .page-heading p {
                                        color: #64748b;
                                    }

                                    .checkout-layout {
                                        display: grid;
                                        grid-template-columns: 1.3fr 1fr;
                                        gap: 25px;
                                        align-items: start;
                                    }

                                    .panel {
                                        background: white;
                                        padding: 25px;
                                        border-radius: 12px;
                                        box-shadow: 0 4px 18px rgba(0, 0, 0, 0.05);
                                    }

                                    .panel h3 {
                                        margin-bottom: 20px;
                                        font-size: 21px;
                                    }

                                    label {
                                        display: block;
                                        font-weight: bold;
                                        margin-bottom: 8px;
                                    }

                                    textarea {
                                        width: 100%;
                                        min-height: 125px;
                                        padding: 13px;
                                        border: 1px solid #cbd5e1;
                                        border-radius: 7px;
                                        font: inherit;
                                        resize: vertical;
                                    }

                                    textarea:focus {
                                        outline: 2px solid #93c5fd;
                                        border-color: #2563eb;
                                    }

                                    .hint {
                                        font-size: 13px;
                                        color: #64748b;
                                        margin-top: 7px;
                                    }

                                    .error {
                                        background: #fef2f2;
                                        color: #b91c1c;
                                        border: 1px solid #fecaca;
                                        padding: 12px;
                                        border-radius: 7px;
                                        margin-bottom: 18px;
                                    }

                                    .item {
                                        display: flex;
                                        justify-content: space-between;
                                        gap: 15px;
                                        padding: 13px 0;
                                        border-bottom: 1px solid #e2e8f0;
                                    }

                                    .item-name {
                                        font-weight: bold;
                                        overflow-wrap: anywhere;
                                    }

                                    .item-details {
                                        color: #64748b;
                                        font-size: 14px;
                                    }

                                    .item-price {
                                        white-space: nowrap;
                                        font-weight: bold;
                                    }

                                    .total {
                                        display: flex;
                                        justify-content: space-between;
                                        gap: 12px;
                                        font-size: 20px;
                                        font-weight: bold;
                                        margin: 22px 0;
                                    }

                                    .button {
                                        display: block;
                                        width: 100%;
                                        padding: 14px;
                                        border: none;
                                        border-radius: 8px;
                                        text-align: center;
                                        text-decoration: none;
                                        font-size: 16px;
                                        font-weight: bold;
                                        cursor: pointer;
                                    }

                                    .place-order {
                                        background: #2563eb;
                                        color: white;
                                    }

                                    .place-order:hover {
                                        background: #1d4ed8;
                                    }

                                    .back {
                                        display: block;
                                        text-align: center;
                                        margin-top: 15px;
                                        color: #2563eb;
                                        text-decoration: none;
                                    }

                                    .notice {
                                        margin-top: 15px;
                                        font-size: 13px;
                                        color: #64748b;
                                        text-align: center;
                                    }

                                    @media (max-width: 720px) {
                                        header {
                                            padding: 16px 5%;
                                        }

                                        .checkout-layout {
                                            grid-template-columns: 1fr;
                                        }

                                        .container {
                                            margin: 25px auto;
                                        }

                                        .page-heading h2 {
                                            font-size: 25px;
                                        }
                                    }
                                </style>
                            </head>

                            <body>

                                <header>
                                    <h1>ShopSphere</h1>
                                    <a href="<%= request.getContextPath() %>/cart">
                                        Back to Cart
                                    </a>
                                </header>

                                <main class="container">

                                    <div class="page-heading">
                                        <h2>Checkout</h2>
                                        <p>Review your order and enter your delivery address.</p>
                                    </div>

                                    <div class="checkout-layout">

                                        <section class="panel">
                                            <h3>Shipping Information</h3>

                                            <% if (errorMessage !=null) { %>
                                                <div class="error">
                                                    <%= escapeHtml(errorMessage) %>
                                                </div>
                                                <% } %>

                                                    <form method="post"
                                                        action="<%= request.getContextPath() %>/checkout">

                                                        <label for="shippingAddress">
                                                            Full Shipping Address
                                                        </label>

                                                        <textarea id="shippingAddress" name="shippingAddress"
                                                            maxlength="500" required
                                                            placeholder="House/Flat number, street, city, state, PIN code"><%= request.getAttribute("submittedAddress") == null ? "" : escapeHtml((String) request.getAttribute("submittedAddress")) %></textarea>

                                                        <p class="hint">
                                                            Enter the address where you want your order delivered.
                                                        </p>

                                                        <br>

                                                        <button type="submit" class="button place-order">
                                                            Place Order
                                                        </button>
                                                    </form>

                                                    <p class="notice">
                                                        This checkout places an order; it does not process an online
                                                        payment.
                                                    </p>
                                        </section>

                                        <section class="panel">
                                            <h3>Order Summary</h3>

                                            <% for (CartItem item : items) { BigDecimal
                                                lineTotal=item.getProductPrice().multiply(
                                                BigDecimal.valueOf(item.getQuantity())); %>

                                                <div class="item">
                                                    <div>
                                                        <div class="item-name">
                                                            <%= escapeHtml(item.getProductName()) %>
                                                        </div>

                                                        <div class="item-details">
                                                            Quantity: <%= item.getQuantity() %>
                                                        </div>

                                                        <div class="item-details">
                                                            Unit price: &#8377;<%= item.getProductPrice() %>
                                                        </div>
                                                    </div>

                                                    <div class="item-price">
                                                        &#8377;<%= lineTotal %>
                                                    </div>
                                                </div>

                                                <% } %>

                                                    <div class="total">
                                                        <span>Total</span>
                                                        <span>&#8377;<%= total %></span>
                                                    </div>

                                                    <a class="back" href="<%= request.getContextPath() %>/cart">
                                                        Edit Cart
                                                    </a>
                                        </section>

                                    </div>
                                </main>

                            </body>

                            </html>