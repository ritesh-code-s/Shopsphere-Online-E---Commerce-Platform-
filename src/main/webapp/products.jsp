<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.shopsphere.model.Product" %>
            <%@ page import="com.shopsphere.util.HtmlUtil" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">

                    <title>Discover Products | ShopSphere</title>

                    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">

                    <style>
                        .store-header {
                            display: flex;
                            align-items: center;
                            justify-content: space-between;
                            gap: 20px;
                            padding: 22px 6%;
                            background: #fff;
                            border-bottom: 1px solid #e7e7ef;
                        }

                        .store-header .brand {
                            color: #202136;
                            text-decoration: none;
                            font-weight: 700;
                            font-size: 22px;
                        }

                        .store-header .brand span {
                            color: #6558e8;
                        }

                        .store-nav {
                            display: flex;
                            align-items: center;
                            gap: 20px;
                            font-size: 14px;
                        }

                        .store-nav a {
                            color: #202136;
                            text-decoration: none;
                        }

                        .store-nav a:hover {
                            color: #6558e8;
                        }

                        .store-main {
                            max-width: 1200px;
                            margin: 0 auto;
                            padding: 55px 24px;
                        }

                        .store-main h1 {
                            margin: 0 0 10px;
                            font-family: 'Manrope', sans-serif;
                            font-size: clamp(30px, 4vw, 44px);
                            letter-spacing: -1.5px;
                        }

                        .store-intro {
                            margin: 0 0 35px;
                            color: #77798b;
                            line-height: 1.7;
                        }

                        .product-grid {
                            display: grid;
                            grid-template-columns: repeat(3, minmax(0, 1fr));
                            gap: 24px;
                        }

                        .product-card {
                            overflow: hidden;
                            border: 1px solid #e7e7ef;
                            border-radius: 16px;
                            background: #fff;
                            transition: transform .2s, box-shadow .2s;
                        }

                        .product-card:hover {
                            transform: translateY(-4px);
                            box-shadow: 0 12px 30px rgba(35, 30, 80, .08);
                        }

                        .product-image {
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            height: 220px;
                            padding: 20px;
                            background: #f0efff;
                        }

                        .product-image img {
                            width: 100%;
                            height: 100%;
                            object-fit: contain;
                        }

                        .product-placeholder {
                            color: #6558e8;
                            font-size: 13px;
                        }

                        .product-info {
                            padding: 20px;
                        }

                        .product-info h2 {
                            margin: 0 0 9px;
                            font-size: 17px;
                        }

                        .product-description {
                            min-height: 42px;
                            margin: 0 0 18px;
                            color: #77798b;
                            font-size: 13px;
                            line-height: 1.6;
                        }

                        .product-bottom {
                            display: flex;
                            align-items: center;
                            justify-content: space-between;
                            gap: 12px;
                        }

                        .product-price {
                            font-size: 20px;
                            font-weight: 700;
                        }

                        /* ADD TO CART BUTTON */

                        .add-cart-form {
                            margin: 0;
                        }

                        .add-cart-btn {
                            border: none;
                            border-radius: 10px;
                            padding: 11px 16px;
                            background: #6558e8;
                            color: white;
                            font-size: 13px;
                            font-weight: 600;
                            cursor: pointer;
                            transition: background .2s, transform .2s;
                        }

                        .add-cart-btn:hover {
                            background: #5146c7;
                            transform: translateY(-1px);
                        }

                        .add-cart-btn:active {
                            transform: translateY(0);
                        }

                        .add-cart-btn:disabled {
                            background: #b8b8c5;
                            cursor: not-allowed;
                        }

                        .stock-label {
                            margin-top: 12px;
                            color: #77798b;
                            font-size: 12px;
                        }

                        .stock-available {
                            color: #278a55;
                        }

                        .stock-unavailable {
                            color: #c14b4b;
                        }

                        .empty-state {
                            padding: 55px 20px;
                            border: 1px dashed #d8d7e8;
                            border-radius: 16px;
                            background: #fff;
                            text-align: center;
                            color: #77798b;
                        }

                        .alert {
                            padding: 15px 18px;
                            margin-bottom: 25px;
                            border-radius: 10px;
                            background: #fff0f0;
                            color: #b33b3b;
                            border: 1px solid #f0cccc;
                        }

                        .store-footer {
                            padding: 25px;
                            color: #77798b;
                            text-align: center;
                            font-size: 12px;
                        }

                        @media (max-width: 850px) {

                            .product-grid {
                                grid-template-columns: repeat(2, minmax(0, 1fr));
                            }

                        }

                        @media (max-width: 560px) {

                            .store-header {
                                padding: 18px 20px;
                            }

                            .store-nav {
                                gap: 12px;
                            }

                            .store-main {
                                padding: 35px 18px;
                            }

                            .product-grid {
                                grid-template-columns: 1fr;
                            }

                            .product-image {
                                height: 240px;
                            }

                        }
                    </style>
                </head>

                <body>

                    <!-- HEADER -->

                    <header class="store-header">

                        <a class="brand" href="${pageContext.request.contextPath}/products">
                            Shop<span>Sphere</span>
                        </a>

                        <nav class="store-nav" aria-label="Main navigation">

                            <a href="${pageContext.request.contextPath}/products">
                                Products
                            </a>

                            <a href="${pageContext.request.contextPath}/cart">
                                🛒 Cart
                            </a>

                            <a href="${pageContext.request.contextPath}/login.jsp">
                                Sign in
                            </a>

                            <a href="${pageContext.request.contextPath}/register.jsp">
                                Join
                            </a>

                        </nav>

                    </header>


                    <!-- MAIN -->

                    <main class="store-main">

                        <p class="eyebrow">
                            THE SHOPSPHERE COLLECTION
                        </p>

                        <h1>
                            Find something you love.
                        </h1>

                        <p class="store-intro">
                            Explore our collection of products, all in one place.
                        </p>


                        <!-- ERROR MESSAGE -->

                        <% if (request.getAttribute("errorMessage") !=null) { %>

                            <div class="alert" role="alert">

                                <%= HtmlUtil.escape( String.valueOf( request.getAttribute("errorMessage") ) ) %>

                            </div>

                            <% } else { %>


                                <!-- GET PRODUCTS -->

                                <% List<Product> products =
                                    (List<Product>) request.getAttribute("products");
                                        %>


                                        <% if (products==null || products.isEmpty()) { %>

                                            <div class="empty-state">

                                                <h2>No products yet</h2>

                                                <p>
                                                    Products will appear here once they're
                                                    added to the catalogue.
                                                </p>

                                            </div>

                                            <% } else { %>


                                                <!-- PRODUCT GRID -->

                                                <div class="product-grid">

                                                    <% for (Product product : products) { %>

                                                        <article class="product-card">


                                                            <!-- PRODUCT IMAGE -->

                                                            <div class="product-image">

                                                                <% if (product.getImageUrl() !=null &&
                                                                    !product.getImageUrl().isBlank()) { %>

                                                                    <img src="<%= HtmlUtil.escape(
                                            product.getImageUrl()
                                        ) %>" alt="<%= HtmlUtil.escape(
                                            product.getName()
                                        ) %>" loading="lazy">

                                                                    <% } else { %>

                                                                        <span class="product-placeholder">
                                                                            Product image coming soon
                                                                        </span>

                                                                        <% } %>

                                                            </div>


                                                            <!-- PRODUCT INFORMATION -->

                                                            <div class="product-info">

                                                                <h2>
                                                                    <%= HtmlUtil.escape( product.getName() ) %>
                                                                </h2>


                                                                <p class="product-description">

                                                                    <%= HtmlUtil.escape( product.getDescription()==null
                                                                        ? "Discover this product from ShopSphere." :
                                                                        product.getDescription() ) %>

                                                                </p>


                                                                <!-- PRICE + ADD TO CART -->

                                                                <div class="product-bottom">

                                                                    <span class="product-price">

                                                                        ₹<%= product.getPrice() .toPlainString() %>

                                                                    </span>


                                                                    <!-- IMPORTANT:
                                         THIS FORM CALLS CartServlet -->

                                                                    <form class="add-cart-form"
                                                                        action="${pageContext.request.contextPath}/cart"
                                                                        method="post">

                                                                        <input type="hidden" name="action" value="add">

                                                                        <input type="hidden" name="productId"
                                                                            value="<%= product.getProductId() %>">

                                                                        <button type="submit" class="add-cart-btn"
                                                                            <%=product.getStockQuantity() <=0
                                                                            ? "disabled" : "" %>
                                                                            >
                                                                            <%= product.getStockQuantity() <=0
                                                                                ? "Unavailable" : "Add to Cart" %>
                                                                        </button>

                                                                    </form>

                                                                </div>


                                                                <!-- STOCK -->

                                                                <p class="stock-label
                                    <%= product.getStockQuantity() > 0
                                        ? " stock-available" : "stock-unavailable" %>">

                                                                    <%= product.getStockQuantity()> 0
                                                                        ? "In stock"
                                                                        : "Currently unavailable" %>

                                                                </p>

                                                            </div>

                                                        </article>

                                                        <% } %>

                                                </div>

                                                <% } %>

                                                    <% } %>

                    </main>


                    <!-- FOOTER -->

                    <footer class="store-footer">

                        ShopSphere — A smarter way to shop.

                    </footer>

                </body>

                </html>