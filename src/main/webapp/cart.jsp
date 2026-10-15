<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.math.BigDecimal" %>
            <%@ page import="com.shopsphere.model.CartItem" %>
                <%@ page import="com.shopsphere.util.HtmlUtil" %>

                    <% Object sessionUserId=session.getAttribute("userId"); if (sessionUserId==null) {
                        response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } List<CartItem>
                        cartItems =
                        (List<CartItem>) request.getAttribute("cartItems");

                            if (cartItems == null) {
                            response.sendRedirect(request.getContextPath() + "/cart");
                            return;
                            }

                            BigDecimal total = BigDecimal.ZERO;

                            for (CartItem item : cartItems) {
                            if (item.getProductPrice() != null && item.getQuantity() > 0) {
                            total = total.add(
                            item.getProductPrice().multiply(
                            BigDecimal.valueOf(item.getQuantity())
                            )
                            );
                            }
                            }
                            %>

                            <!DOCTYPE html>
                            <html lang="en">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                                <title>Shopping Cart | ShopSphere</title>

                                <style>
                                    * {
                                        box-sizing: border-box;
                                    }

                                    body {
                                        margin: 0;
                                        font-family: Arial, sans-serif;
                                        background: #f5f7fb;
                                        color: #202938;
                                    }

                                    header {
                                        background: #172554;
                                        color: white;
                                        padding: 18px 6%;
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        gap: 15px;
                                        flex-wrap: wrap;
                                    }

                                    header h1 {
                                        margin: 0;
                                        font-size: 25px;
                                    }

                                    header nav {
                                        display: flex;
                                        gap: 20px;
                                        flex-wrap: wrap;
                                    }

                                    header a {
                                        color: white;
                                        text-decoration: none;
                                    }

                                    header a:hover {
                                        text-decoration: underline;
                                    }

                                    main {
                                        max-width: 1050px;
                                        margin: 35px auto;
                                        padding: 0 18px;
                                    }

                                    h2 {
                                        margin-bottom: 22px;
                                    }

                                    .cart-item {
                                        background: white;
                                        border-radius: 12px;
                                        padding: 20px;
                                        margin-bottom: 16px;
                                        display: flex;
                                        align-items: center;
                                        gap: 20px;
                                        box-shadow: 0 3px 12px #0000000a;
                                    }

                                    .product-image {
                                        width: 105px;
                                        height: 105px;
                                        flex-shrink: 0;
                                        object-fit: contain;
                                        border-radius: 8px;
                                        background: #f8fafc;
                                    }

                                    .image-placeholder {
                                        display: flex;
                                        justify-content: center;
                                        align-items: center;
                                        color: #64748b;
                                        font-size: 12px;
                                        text-align: center;
                                        padding: 8px;
                                    }

                                    .details {
                                        flex: 1;
                                        min-width: 0;
                                    }

                                    .details h3 {
                                        margin-top: 0;
                                        overflow-wrap: anywhere;
                                    }

                                    .price {
                                        font-weight: bold;
                                        color: #1d4ed8;
                                    }

                                    .subtotal {
                                        color: #475569;
                                    }

                                    form {
                                        margin: 0;
                                    }

                                    .quantity {
                                        width: 75px;
                                        padding: 9px;
                                        border: 1px solid #cbd5e1;
                                        border-radius: 6px;
                                    }

                                    button,
                                    .button {
                                        border: 0;
                                        border-radius: 6px;
                                        padding: 10px 14px;
                                        cursor: pointer;
                                        text-decoration: none;
                                        display: inline-block;
                                        font-size: 14px;
                                        transition: background 0.2s ease;
                                    }

                                    .update {
                                        background: #dbeafe;
                                        color: #1d4ed8;
                                    }

                                    .update:hover {
                                        background: #bfdbfe;
                                    }

                                    .remove {
                                        background: #fee2e2;
                                        color: #b91c1c;
                                        margin-top: 8px;
                                    }

                                    .remove:hover {
                                        background: #fecaca;
                                    }

                                    .summary {
                                        background: white;
                                        border-radius: 12px;
                                        padding: 24px;
                                        margin-top: 24px;
                                        text-align: right;
                                        box-shadow: 0 3px 12px #0000000a;
                                    }

                                    .total {
                                        font-size: 24px;
                                        font-weight: bold;
                                        color: #172554;
                                    }

                                    .continue {
                                        background: #e2e8f0;
                                        color: #172554;
                                    }

                                    .continue:hover {
                                        background: #cbd5e1;
                                    }

                                    .checkout {
                                        background: #2563eb;
                                        color: white;
                                        margin-left: 8px;
                                    }

                                    .checkout:hover {
                                        background: #1d4ed8;
                                    }

                                    .empty {
                                        background: white;
                                        border-radius: 12px;
                                        padding: 45px 20px;
                                        text-align: center;
                                        box-shadow: 0 3px 12px #0000000a;
                                    }

                                    .empty h3 {
                                        font-size: 22px;
                                    }

                                    .empty p {
                                        color: #64748b;
                                        margin-bottom: 24px;
                                    }

                                    footer {
                                        text-align: center;
                                        padding: 25px 15px;
                                        color: #64748b;
                                        font-size: 13px;
                                    }

                                    @media (max-width: 600px) {
                                        header {
                                            padding: 16px 5%;
                                        }

                                        main {
                                            margin: 25px auto;
                                            padding: 0 12px;
                                        }

                                        .cart-item {
                                            align-items: flex-start;
                                            flex-wrap: wrap;
                                            gap: 12px;
                                            padding: 15px;
                                        }

                                        .product-image {
                                            width: 80px;
                                            height: 80px;
                                        }

                                        .details {
                                            flex-basis: calc(100% - 100px);
                                        }

                                        .cart-actions {
                                            width: 100%;
                                        }

                                        .cart-actions form:first-child {
                                            display: flex;
                                            align-items: center;
                                            gap: 8px;
                                            flex-wrap: wrap;
                                        }

                                        .summary {
                                            text-align: center;
                                            padding: 20px 15px;
                                        }

                                        .summary .button {
                                            margin: 6px 0;
                                        }

                                        .checkout {
                                            margin-left: 0;
                                        }
                                    }
                                </style>
                            </head>

                            <body>

                                <header>
                                    <h1>ShopSphere</h1>

                                    <nav>
                                        <a href="<%= request.getContextPath() %>/products">Products</a>
                                        <a href="<%= request.getContextPath() %>/cart">Cart</a>
                                    </nav>
                                </header>

                                <main>

                                    <h2>My Shopping Cart</h2>

                                    <% if (cartItems.isEmpty()) { %>

                                        <div class="empty">

                                            <h3>Your cart is empty</h3>

                                            <p>Discover something you'll love.</p>

                                            <a class="button checkout" href="<%= request.getContextPath() %>/products">
                                                Browse Products
                                            </a>

                                        </div>

                                        <% } else { %>

                                            <% for (CartItem item : cartItems) { BigDecimal
                                                itemPrice=item.getProductPrice(); BigDecimal subtotal=itemPrice==null ?
                                                BigDecimal.ZERO : itemPrice.multiply(
                                                BigDecimal.valueOf(item.getQuantity()) ); %>

                                                <div class="cart-item">

                                                    <% if (item.getImageUrl() !=null && !item.getImageUrl().isBlank()) {
                                                        %>

                                                        <img class="product-image"
                                                            src="<%= HtmlUtil.escape(item.getImageUrl()) %>" alt="<%= HtmlUtil.escape(
                                 item.getProductName() == null
                                 ? " Product" : item.getProductName() ) %>"
                                                        loading="lazy"
                                                        onerror="this.style.display='none';
                                                        this.nextElementSibling.style.display='flex';">

                                                        <div class="product-image image-placeholder"
                                                            style="display:none;"
                                                            aria-label="Product image unavailable">
                                                            Image unavailable
                                                        </div>

                                                        <% } else { %>

                                                            <div class="product-image image-placeholder" role="img"
                                                                aria-label="Product image unavailable">
                                                                No image available
                                                            </div>

                                                            <% } %>


                                                                <div class="details">

                                                                    <h3>
                                                                        <%= HtmlUtil.escape( item.getProductName()==null
                                                                            ? "Unnamed Product" : item.getProductName()
                                                                            ) %>
                                                                    </h3>

                                                                    <p class="price">
                                                                        &#8377;<%= itemPrice==null ? "0.00" :
                                                                            itemPrice.toPlainString() %>
                                                                    </p>

                                                                    <p class="subtotal">
                                                                        Subtotal:
                                                                        &#8377;<%= subtotal.toPlainString() %>
                                                                    </p>

                                                                </div>


                                                                <div class="cart-actions">

                                                                    <!-- UPDATE QUANTITY -->

                                                                    <form action="<%= request.getContextPath() %>/cart"
                                                                        method="post">

                                                                        <input type="hidden" name="action"
                                                                            value="update">

                                                                        <input type="hidden" name="cartItemId"
                                                                            value="<%= item.getCartItemId() %>">

                                                                        <label>
                                                                            Quantity:

                                                                            <input class="quantity" type="number"
                                                                                name="quantity" min="1" max="99"
                                                                                value="<%= item.getQuantity() %>"
                                                                                required>
                                                                        </label>

                                                                        <button class="update" type="submit">
                                                                            Update
                                                                        </button>

                                                                    </form>


                                                                    <!-- REMOVE ITEM -->

                                                                    <form action="<%= request.getContextPath() %>/cart"
                                                                        method="post"
                                                                        onsubmit="return confirm('Remove this item from your cart?');">

                                                                        <input type="hidden" name="action"
                                                                            value="remove">

                                                                        <input type="hidden" name="cartItemId"
                                                                            value="<%= item.getCartItemId() %>">

                                                                        <button class="remove" type="submit">
                                                                            Remove
                                                                        </button>

                                                                    </form>

                                                                </div>

                                                </div>

                                                <% } %>


                                                    <!-- CART SUMMARY -->

                                                    <div class="summary">

                                                        <p>Cart total</p>

                                                        <p class="total">
                                                            &#8377;<%= total.toPlainString() %>
                                                        </p>

                                                        <a class="button continue"
                                                            href="<%= request.getContextPath() %>/products">
                                                            Continue Shopping
                                                        </a>

                                                        <a class="button checkout"
                                                            href="<%= request.getContextPath() %>/checkout">
                                                            Proceed to Checkout
                                                        </a>

                                                    </div>

                                                    <% } %>

                                </main>


                                <footer>
                                    &copy; 2026 ShopSphere. All rights reserved.
                                </footer>

                            </body>

                            </html>