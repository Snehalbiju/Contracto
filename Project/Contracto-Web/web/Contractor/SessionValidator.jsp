<%
        response.setHeader("Cache-Control", "no-cache, no-store");
        if(session.getAttribute("c_id") == null)
        {
            response.sendRedirect("../Guest/Login.jsp");
        }
    %>