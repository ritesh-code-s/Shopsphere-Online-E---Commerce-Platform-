<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account | ShopSphere</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
    </head>

    <body>
        <main class="auth-layout">
            <section class="auth-brand">
                <a class="brand" href="${pageContext.request.contextPath}/">
                    Shop<span>Sphere</span>
                </a>

                <div class="brand-copy">
                    <p class="eyebrow">YOUR EVERYDAY MARKETPLACE</p>
                    <h1>Good finds.<br>Better living.</h1>
                    <p>Discover products you'll love and enjoy a simpler shopping experience.</p>
                </div>

                <p class="brand-footer">A smarter way to shop.</p>
            </section>

            <section class="auth-panel">
                <div class="auth-card">
                    <p class="eyebrow">GET STARTED</p>
                    <h2>Create your account</h2>
                    <p class="subheading">Join ShopSphere and start exploring.</p>


                    <% if (request.getAttribute("errorMessage") !=null) { %>
                        <div class="alert" role="alert">
                            <%= com.shopsphere.util.HtmlUtil.escape(
                                String.valueOf(request.getAttribute("errorMessage"))) %>
                        </div>
                        <% } %>


                            <form action="${pageContext.request.contextPath}/register" method="post">

                                <label for="fullName">Full name</label>
                                <input type="text" id="fullName" name="fullName" placeholder="Enter your full name"
                                    autocomplete="name" maxlength="100" required>

                                <label for="email">Email address</label>
                                <input type="email" id="email" name="email" placeholder="you@example.com"
                                    autocomplete="email" maxlength="150" required>

                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" placeholder="At least 8 characters"
                                    autocomplete="new-password" minlength="8" required>

                                <button type="submit" class="primary-button">
                                    Create account <span aria-hidden="true">→</span>
                                </button>
                            </form>

                            <p class="auth-switch">
                                Already have an account?
                                <a href="${pageContext.request.contextPath}/login.jsp">Sign in</a>
                            </p>

                            <p class="legal-note">
                                By creating an account, you agree to use ShopSphere responsibly.
                            </p>
                </div>
            </section>
        </main>
    </body>

    </html>