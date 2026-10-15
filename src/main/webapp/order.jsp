<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.time.format.DateTimeFormatter" %>
            <%@ page import="com.shopsphere.model.Order" %>

                <% List<Order> orders =
                    (List<Order>) request.getAttribute("orders");

                        DateTimeFormatter formatter =
                        DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
                        %>

                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>My Orders | ShopSphere</title>

                            <style>
                                * {
                                    box-sizing: border-box;
                                }

                                body {
                                    margin: 0;
                                    font-family: Arial, sans-serif;
                                    background: #f5f7fb;
                                    color: #1f2937;
                                }

                                header {
                                    background: #111827;
                                    color: white;
                                    padding: 20px 7%;
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    gap: 15px;
                                    flex-wrap: wrap;
                                }

                                header h2 {
                                    margin: 0;
                                }

                                header a {
                                    color: white;
                                    text-decoration: none;
                                    margin-left: 18px;
                                }

                                main {
                                    width: 86%;
                                    max-width: 1100px;
                                    margin: 35px auto;
                                }

                                .page-heading {
                                    margin-bottom: 25px;
                                }

                                .page-heading h1 {
                                    margin-bottom: 8px;
                                }

                                .order-card {
                                    background: white;
                                    border-radius: 12px;
                                    padding: 22px;
                                    margin-bottom: 18px;
                                    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.06);
                                }

                                .order-top {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    gap: 15px;
                                    flex-wrap: wrap;
                                    padding-bottom: 16px;
                                    border-bottom: 1px solid #e5e7eb;
                                }

                                .order-top h3 {
                                    margin: 0 0 7px;
                                }

                                .status {
                                    display: inline-block;
                                    padding: 7px 12px;
                                    border-radius: 20px;
                                    background: #dcfce7;
                                    color: #166534;
                                    font-size: 13px;
                                    font-weight: bold;
                                }

                                .order-details {
                                    display: grid;
                                    grid-template-columns: repeat(2, minmax(0, 1fr));
                                    gap: 18px;
                                    padding-top: 18px;
                                }

                                .detail-label {
                                    color: #6b7280;
                                    font-size: 13px;
                                    margin-bottom: 6px;
                                }

                                .detail-value {
                                    font-weight: 600;
                                    overflow-wrap: anywhere;
                                }

                                .empty-state {
                                    background: white;
                                    padding: 45px 20px;
                                    text-align: center;
                                    border-radius: 12px;
                                }

                                .empty-state a,
                                .back-link {
                                    color: #2563eb;
                                    text-decoration: none;
                                    font-weight: bold;
                                }

                                @media (max-width: 600px) {
                                    header {
                                        padding: 18px 5%;
                                    }

                                    header a {
                                        margin-left: 0;
                                        margin-right: 14px;
                                    }

                                    main {
                                        width: 92%;
                                        margin-top: 24px;
                                    }

                                    .order-details {
                                        grid-template-columns: 1fr;
                                    }

                                    .order-card {
                                        padding: 17px;
                                    }
                                }
                            </style>
                        </head>

                        <body>

                            <header>
                                <h2>ShopSphere</h2>

                                <nav>
                                    <a href="<%= request.getContextPath() %>/products">Products</a>
                                    <a href="<%= request.getContextPath() %>/cart">Cart</a>
                                    <a href="<%= request.getContextPath() %>/orders">My Orders</a>
                                </nav>
                            </header>

                            <main>
                                <div class="page-heading">
                                    <h1>My Orders</h1>
                                    <p>View your order history and delivery details.</p>
                                </div>

                                <% if (orders==null || orders.isEmpty()) { %>

                                    <div class="empty-state">
                                        <h2>No orders yet</h2>
                                        <p>Your placed orders will appear here.</p>
                                        <a href="<%= request.getContextPath() %>/products">
                                            Explore Products
                                        </a>
                                    </div>

                                    <% } else { %>

                                        <% for (Order order : orders) { %>

                                            <section class="order-card">

                                                <div class="order-top">
                                                    <div>
                                                        <h3>Order #<%= order.getOrderId() %>
                                                        </h3>

                                                        <div class="detail-label">
                                                            Placed:
                                                            <%= order.getCreatedAt()==null ? "Date unavailable" :
                                                                order.getCreatedAt().toLocalDateTime()
                                                                .format(formatter) %>
                                                        </div>
                                                    </div>

                                                    <span class="status">
                                                        <%= order.getStatus() %>
                                                    </span>
                                                </div>

                                                <div class="order-details">

                                                    <div>
                                                        <div class="detail-label">Order Total</div>
                                                        <div class="detail-value">
                                                            ₹<%= order.getTotalAmount() %>
                                                        </div>
                                                    </div>

                                                    <div>
                                                        <div class="detail-label">Shipping Address</div>
                                                        <div class="detail-value">
                                                            <%= order.getShippingAddress() %>
                                                        </div>
                                                    </div>

                                                </div>
                                            </section>

                                            <% } %>

                                                <% } %>

                                                    <p>
                                                        <a class="back-link"
                                                            href="<%= request.getContextPath() %>/products">
                                                            ← Continue Shopping
                                                        </a>
                                                    </p>
                            </main>

                        </body>

                        </html>