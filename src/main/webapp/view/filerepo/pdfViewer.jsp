<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Secure PDF Viewer</title>
<style>
   html, body {
       margin: 0;
       height: 100%;
       overflow: hidden;
   }

   iframe {
       width: 100%;
       height: 100%;
       border: none;
   }
</style>
</head>
<body>
<%
    String logintype= (String)session.getAttribute("LoginType");
    if (logintype == null) logintype = "U";
%>

<iframe id="pdfFrame"></iframe>

<script>
    const pdfUrl = new URLSearchParams(window.location.search).get("url");

    // Injected from JSP session (role type)
    const userRole = "<%= logintype!=null?StringEscapeUtils.escapeHtml4(logintype): "" %>";

    const iframe = document.getElementById("pdfFrame");

    if (userRole === "A") {
        // Admin - show full toolbar
        iframe.src = pdfUrl;
    } else {
        // Non-admin - restrict toolbar and print/download features
        iframe.src = pdfUrl + "#toolbar=0&navpanes=0&scrollbar=0";

        // Disable Ctrl+P
        document.addEventListener('keydown', function (e) {
            if ((e.ctrlKey || e.metaKey) && (e.key === 'p' || e.key === 'P')) {
                e.preventDefault();
                alert("Printing is disabled for your role.");
            }
        });

        // Disable right-click
        document.addEventListener('contextmenu', function (e) {
            e.preventDefault();
        });

        // Prevent printing completely with @media print
        const style = document.createElement("style");
        style.innerHTML =
            "@media print {" +
            "  body { display: none !important; }" +
            "}";
        document.head.appendChild(style);
    }
</script>

</body>
</html>