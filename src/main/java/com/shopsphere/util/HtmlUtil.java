
package com.shopsphere.util;

public final class HtmlUtil {

    private HtmlUtil() {
        // Utility class; do not instantiate.
    }

    public static String escape(String value) {
        if (value == null) {
            return "";
        }

        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}
