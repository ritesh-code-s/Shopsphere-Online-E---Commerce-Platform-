<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.regex.Pattern" %>

        <% Object orderIdObject=request.getAttribute("orderId"); if (orderIdObject==null) {
            response.sendRedirect(request.getContextPath() + "/products" ); return; } String
            orderId=String.valueOf(orderIdObject); if (!Pattern.matches("\\d+", orderId)) {
            response.sendRedirect(request.getContextPath() + "/products" ); return; } %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <title>Order Placed | ShopSphere</title>

                <style>
                    * {
                        box-sizing: border-box;
                    }

                    body {
                        margin: 0;
                        min-height: 100vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 20px;
                        background: #f5f7fb;
                        font-family: Arial, sans-serif;
                        color: #1e293b;
                    }

                    .success-card {
                        width: 100%;
                        max-width: 520px;
                        padding: 40px 28px;
                        background: white;
                        border-radius: 16px;
                        text-align: center;
                        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.07);
                    }

                    .checkmark {
                        width: 76px;
                        height: 76px;
                        margin: 0 auto 20px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 50%;
                        background: #dcfce7;
                        color: #15803d;
                        font-size: 40px;
                    }

                    h1 {
                        margin: 0 0 12px;
                        font-size: 28px;
                    }

                    p {
                        color: #64748b;
                        line-height: 1.7;
                    }

                    .order-number {
                        margin: 24px 0;
                        padding: 16px;
                        border: 1px solid #e2e8f0;
                        border-radius: 10px;
                        background: #f8fafc;
                    }

                    .order-number strong {
                        display: block;
                        margin-top: 5px;
                        font-size: 22px;
                        overflow-wrap: anywhere;
                    }

                    .button {
                        display: block;
                        width: 100%;
                        padding: 14px;
                        margin-top: 12px;
                        border-radius: 8px;
                        text-decoration: none;
                        font-weight: bold;
                    }

                    .primary {
                        background: #2563eb;
                        color: white;
                    }

                    .secondary {
                        border: 1px solid #cbd5e1;
                        color: #334155;
                    }
                </style>
            </head>

            <body>
                <main class="success-card">
                    <div class="checkmark" aria-hidden="true">&#10003;</div>

                    <h1>Order Placed Successfully!</h1>

                    <p>
                        Thank you for shopping with ShopSphere.
                        Your order has been recorded successfully.
                    </p>

                    <div class="order-number">
                        Order ID
                        <strong>#<%= orderId %></strong>
                    </div>

                    <p>
                        Your order status is initially PLACED.
                        Online payment has not been processed by this page.
                    </p>

                    <a class="button primary" href="<%= request.getContextPath() %>/products">
                        Continue Shopping
                    </a>

                    <a class="button secondary" href="<%= request.getContextPath() %>/orders">
                        View My Orders
                    </a>
                </main>
            </body>

            </html>