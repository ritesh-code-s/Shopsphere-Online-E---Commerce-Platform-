<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In | ShopSphere</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
    </head>

    <body>
        <main class="auth-layout">

            <section class="auth-brand">
                <a class="brand" href="${pageContext.request.contextPath}/">
                    Shop<span>Sphere</span>
                </a>

                <div class="brand-copy">
                    <p class="eyebrow">WELCOME BACK</p>
                    <h1>Your next<br>great find awaits.</h1>
                    <p>Sign in to continue your shopping journey with ShopSphere.</p>
                </div>

                <p class="brand-footer">A smarter way to shop.</p>
            </section>

            <section class="auth-panel">
                <div class="auth-card">
                    <p class="eyebrow">YOUR ACCOUNT</p>
                    <h2>Welcome back</h2>
                    <p class="subheading">Enter your details to sign in.</p>

                    <% if (request.getAttribute("errorMessage") !=null) { %>
                        <div class="alert" role="alert">
                            <%= com.shopsphere.util.HtmlUtil.escape(
                                String.valueOf(request.getAttribute("errorMessage"))) %>
                        </div>
                        <% } %>

                            <form action="${pageContext.request.contextPath}/login" method="post">

                                <label for="email">Email address</label>
                                <input type="email" id="email" name="email" placeholder="you@example.com"
                                    autocomplete="email" maxlength="150" required>

                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" placeholder="Enter your password"
                                    autocomplete="current-password" required>

                                <button type="submit" class="primary-button">
                                    Sign in <span aria-hidden="true">→</span>
                                </button>
                            </form>

                            <p class="auth-switch">
                                New to ShopSphere?
                                <a href="${pageContext.request.contextPath}/register.jsp">
                                    Create an account
                                </a>
                            </p>

                            <p class="legal-note">
                                Your shopping journey starts here.
                            </p>
                </div>
            </section>

        </main>
    </body>

    </html>