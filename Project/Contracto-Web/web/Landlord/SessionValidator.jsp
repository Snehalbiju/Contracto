<%
        response.setHeader("Cache-Control", "no-cache, no-store");
        if(session.getAttribute("l_id") == null)
        {
            response.sendRedirect("../Guest/Login.jsp");
        }
    %>