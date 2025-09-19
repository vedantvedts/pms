package com.vts.pfms.cfg;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Set;

@Component
@Order(0) // ensure it runs before Spring Security headers
public class CspNonceFilter implements Filter {

	private static final Set<String> STATIC_EXTENSIONS = Set.of(
            ".js", ".css", ".png", ".jpg", ".jpeg", ".gif", ".ico", ".woff", ".woff2", ".ttf", ".map"
    );

    private static final SecureRandom secureRandom = new SecureRandom();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (request instanceof HttpServletRequest req && response instanceof HttpServletResponse res) {

            String path = req.getRequestURI().toLowerCase();
            boolean isStatic = STATIC_EXTENSIONS.stream().anyMatch(path::endsWith);

            if (!isStatic && path.startsWith("/pms/")) {

                // Wrap the response to capture output
                CharResponseWrapper wrappedResponse = new CharResponseWrapper(res);

                // Continue filter chain
                chain.doFilter(request, wrappedResponse);

                // Generate nonce
                String nonce = generateNonce();

                // Capture the original HTML
                String html = wrappedResponse.getCaptureAsString();

                // Inject nonce into all <script> tags
                html = html.replaceAll("(?i)<script(?![^>]*nonce)", "<script nonce=\"" + nonce + "\"");

    res.setHeader("Content-Security-Policy",
                "default-src 'self'; " +
                "script-src 'self'; " +                      // ✅ only scripts from same origin
                "style-src 'self'; " +                       // ✅ only CSS from same origin
                "img-src 'self'; " +                         // ✅ only images from same origin
                "font-src 'self'; " +                        // ✅ only fonts from same origin
                "connect-src 'self'; " +                     // ✅ restrict AJAX/WebSocket
                "media-src 'none'; " +                       // 🚫 no audio/video
                "object-src 'none'; " +                      // 🚫 no Flash/Java/etc.
                "worker-src 'none'; " +                      // 🚫 block web workers
                "child-src 'none'; " +                       // 🚫 block <frame>/<iframe>
                "frame-src 'none'; " +                       // 🚫 explicitly block frames
                "frame-ancestors 'none'; " +                 // 🚫 cannot be embedded anywhere
                "base-uri 'self'; " +                        // ✅ restrict <base>
                "form-action 'self'; " +                     // ✅ restrict form submits
                "upgrade-insecure-requests; " +              // ✅ force HTTPS for all requests
                "block-all-mixed-content; " +                // ✅ block mixed content
                "report-uri /csp-report;"                    // ✅ violations logged here
        );

                // Other security headers
                res.setHeader("X-Frame-Options", "SAMEORIGIN");
                res.setHeader("X-Content-Type-Options", "nosniff");

                // Write modified HTML to response
                res.getWriter().write(html);
                return; // Do not continue, already written
            }
        }

        // Static files or non-PMS paths pass through
        chain.doFilter(request, response);
    }
    private String generateNonce() {
        byte[] bytes = new byte[16];
        secureRandom.nextBytes(bytes);
        return java.util.Base64.getEncoder().encodeToString(bytes);
    }

}
