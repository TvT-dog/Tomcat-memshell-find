<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.connector.Request" %>
<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.tomcat.util.descriptor.web.FilterDef" %>
<%@ page import="org.apache.catalina.Container" %>
<%@ page import="org.apache.catalina.Wrapper" %>
<%@ page import="org.apache.catalina.Pipeline" %>
<%@ page import="org.apache.catalina.Valve" %>
<%@ page contentType="text/html; charset=UTF-8" %>


<style>
    @import url("https://fonts.googleapis.com/css?family=Nunito:400,700");
    body {
        background: #edf5fa;
        margin: 25px;
        font-family: 'Nunito', sans-serif;
    }
    container {
        display: block;
        width: 100%;
        max-width: 800px;
        margin: auto;
        border-radius: 3px;
        position: relative;
        background: white;
        box-shadow: 10px 10px 100px 0 #d9eaf4;
    }
    h2 {

        padding: 20px;
        margin: 0;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        font-size: 1.1em;
    }
    h2:after {
        content: '<%
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        String formattedDateTime = now.format(formatter);
        out.print(formattedDateTime);
    %>';
        float: right;
        font-size: 0.9em;
        font-family: monospace;
        color: #aaa;
        line-height: 1.5em;
    }
    details {
        width: 100%;
        overflow: hidden;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }
    details:last-of-type {
        border-bottom: none;
    }
    details summary {
        display: block;
        user-select: none;
        outline: none;
        padding: 20px;
        margin-bottom: 0px;
        transition: all 600ms cubic-bezier(0.23, 1, 0.32, 1);
        transition-property: margin, background;
        font-weight: 600;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }
    details summary:last-of-type {
        border-bottom: none;
    }
    details summary::-webkit-details-marker {
        display: none;
    }
    details summary:before {
        font: normal normal normal 1em/1 FontAwesome;
        font-weight: 900;
        content: '';
        margin-right: 0.5em;
    }
    details summary:hover {
        background: #f6f8fb;
        cursor: pointer;
    }
    details summary.success:before {
        color: #9cc320;
        content: "\f058";
    }
    details summary.warning:before {
        color: #ffa50a;
        content: "\f06a";
    }
    details summary.failure:before {
        color: #da281e;
        content: "\f057";
    }
    details ul {
        padding: 0;
        margin-left: 1em;
    }
    details ul li {
        list-style: none;
        padding: 1em 1em 1em 3em;
        font-weight: bold;
        position: relative;
    }
    details ul li:before {
        position: absolute;
        top: 0;
        left: 0;
        display: block;
        float: left;
        content: '';
        width: 0em;
        height: 1.5em;
        border-left: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
    }
    details ul li:after {
        position: absolute;
        top: 0;
        left: 0;
        display: block;
        float: left;
        content: '';
        width: 1em;
        height: 100%;
        border-left: 1px solid #ccc;
    }
    details ul li:last-child:after {
        display: none;
    }
    details ul li div {
        opacity: 0;
    }
    details ul li div:before {
        font: normal normal normal 1em/1 FontAwesome;
        font-weight: 900;
        position: absolute;
        top: 1em;
        left: 1em;
        padding: 0 0.5em;
        display: block;
        float: left;
        content: "";
        width: 1em;
        height: 100%;
    }
    details ul li div.success:before {
        color: #9cc320;
        content: "\f058";
    }
    details ul li div.warning:before {
        color: #ffa50a;
        content: "\f06a";
    }
    details ul li div.failure:before {
        color: #da281e;
        content: "\f057";
    }
    details ul li span {
        display: block;
        font-size: 0.9em;
        font-weight: normal;
    }
    details ul li span:before {
        opacity: 0.3;
        font-weight: bold;
    }
    details ul li span.status:before {
        content: 'status: ';
    }
    details ul li span.info:before {
        content: 'info: ';
    }
    details[open] summary {
        margin-bottom: 20px;
        padding-bottom: 20px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }
    details[open] summary ~ ul li:nth-child(1) div,
    details[open] summary ~ ul li:nth-child(1) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0s;
    }
    details[open] summary ~ ul li:nth-child(1):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.1s;
    }
    details[open] summary ~ ul li:nth-child(2) div,
    details[open] summary ~ ul li:nth-child(2) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.1s;
    }
    details[open] summary ~ ul li:nth-child(2):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.2s;
    }
    details[open] summary ~ ul li:nth-child(3) div,
    details[open] summary ~ ul li:nth-child(3) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.2s;
    }
    details[open] summary ~ ul li:nth-child(3):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.3s;
    }
    details[open] summary ~ ul li:nth-child(4) div,
    details[open] summary ~ ul li:nth-child(4) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.3s;
    }
    details[open] summary ~ ul li:nth-child(4):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.4s;
    }
    details[open] summary ~ ul li:nth-child(5) div,
    details[open] summary ~ ul li:nth-child(5) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.4s;
    }
    details[open] summary ~ ul li:nth-child(5):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.5s;
    }
    details[open] summary ~ ul li:nth-child(6) div,
    details[open] summary ~ ul li:nth-child(6) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.5s;
    }
    details[open] summary ~ ul li:nth-child(6):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.6s;
    }
    details[open] summary ~ ul li:nth-child(7) div,
    details[open] summary ~ ul li:nth-child(7) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.6s;
    }
    details[open] summary ~ ul li:nth-child(7):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.7s;
    }
    details[open] summary ~ ul li:nth-child(8) div,
    details[open] summary ~ ul li:nth-child(8) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.7s;
    }
    details[open] summary ~ ul li:nth-child(8):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.8s;
    }
    details[open] summary ~ ul li:nth-child(9) div,
    details[open] summary ~ ul li:nth-child(9) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.8s;
    }
    details[open] summary ~ ul li:nth-child(9):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 0.9s;
    }
    details[open] summary ~ ul li:nth-child(10) div,
    details[open] summary ~ ul li:nth-child(10) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 0.9s;
    }
    details[open] summary ~ ul li:nth-child(10):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1s;
    }
    details[open] summary ~ ul li:nth-child(11) div,
    details[open] summary ~ ul li:nth-child(11) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1s;
    }
    details[open] summary ~ ul li:nth-child(11):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.1s;
    }
    details[open] summary ~ ul li:nth-child(12) div,
    details[open] summary ~ ul li:nth-child(12) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.1s;
    }
    details[open] summary ~ ul li:nth-child(12):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.2s;
    }
    details[open] summary ~ ul li:nth-child(13) div,
    details[open] summary ~ ul li:nth-child(13) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.2s;
    }
    details[open] summary ~ ul li:nth-child(13):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.3s;
    }
    details[open] summary ~ ul li:nth-child(14) div,
    details[open] summary ~ ul li:nth-child(14) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.3s;
    }
    details[open] summary ~ ul li:nth-child(14):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.4s;
    }
    details[open] summary ~ ul li:nth-child(15) div,
    details[open] summary ~ ul li:nth-child(15) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.4s;
    }
    details[open] summary ~ ul li:nth-child(15):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.5s;
    }
    details[open] summary ~ ul li:nth-child(16) div,
    details[open] summary ~ ul li:nth-child(16) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.5s;
    }
    details[open] summary ~ ul li:nth-child(16):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.6s;
    }
    details[open] summary ~ ul li:nth-child(17) div,
    details[open] summary ~ ul li:nth-child(17) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.6s;
    }
    details[open] summary ~ ul li:nth-child(17):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.7s;
    }
    details[open] summary ~ ul li:nth-child(18) div,
    details[open] summary ~ ul li:nth-child(18) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.7s;
    }
    details[open] summary ~ ul li:nth-child(18):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.8s;
    }
    details[open] summary ~ ul li:nth-child(19) div,
    details[open] summary ~ ul li:nth-child(19) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.8s;
    }
    details[open] summary ~ ul li:nth-child(19):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 1.9s;
    }
    details[open] summary ~ ul li:nth-child(20) div,
    details[open] summary ~ ul li:nth-child(20) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 1.9s;
    }
    details[open] summary ~ ul li:nth-child(20):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2s;
    }
    details[open] summary ~ ul li:nth-child(21) div,
    details[open] summary ~ ul li:nth-child(21) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2s;
    }
    details[open] summary ~ ul li:nth-child(21):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.1s;
    }
    details[open] summary ~ ul li:nth-child(22) div,
    details[open] summary ~ ul li:nth-child(22) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.1s;
    }
    details[open] summary ~ ul li:nth-child(22):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.2s;
    }
    details[open] summary ~ ul li:nth-child(23) div,
    details[open] summary ~ ul li:nth-child(23) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.2s;
    }
    details[open] summary ~ ul li:nth-child(23):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.3s;
    }
    details[open] summary ~ ul li:nth-child(24) div,
    details[open] summary ~ ul li:nth-child(24) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.3s;
    }
    details[open] summary ~ ul li:nth-child(24):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.4s;
    }
    details[open] summary ~ ul li:nth-child(25) div,
    details[open] summary ~ ul li:nth-child(25) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.4s;
    }
    details[open] summary ~ ul li:nth-child(25):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.5s;
    }
    details[open] summary ~ ul li:nth-child(26) div,
    details[open] summary ~ ul li:nth-child(26) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.5s;
    }
    details[open] summary ~ ul li:nth-child(26):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.6s;
    }
    details[open] summary ~ ul li:nth-child(27) div,
    details[open] summary ~ ul li:nth-child(27) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.6s;
    }
    details[open] summary ~ ul li:nth-child(27):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.7s;
    }
    details[open] summary ~ ul li:nth-child(28) div,
    details[open] summary ~ ul li:nth-child(28) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.7s;
    }
    details[open] summary ~ ul li:nth-child(28):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.8s;
    }
    details[open] summary ~ ul li:nth-child(29) div,
    details[open] summary ~ ul li:nth-child(29) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.8s;
    }
    details[open] summary ~ ul li:nth-child(29):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 2.9s;
    }
    details[open] summary ~ ul li:nth-child(30) div,
    details[open] summary ~ ul li:nth-child(30) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 2.9s;
    }
    details[open] summary ~ ul li:nth-child(30):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3s;
    }
    details[open] summary ~ ul li:nth-child(31) div,
    details[open] summary ~ ul li:nth-child(31) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3s;
    }
    details[open] summary ~ ul li:nth-child(31):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.1s;
    }
    details[open] summary ~ ul li:nth-child(32) div,
    details[open] summary ~ ul li:nth-child(32) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.1s;
    }
    details[open] summary ~ ul li:nth-child(32):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.2s;
    }
    details[open] summary ~ ul li:nth-child(33) div,
    details[open] summary ~ ul li:nth-child(33) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.2s;
    }
    details[open] summary ~ ul li:nth-child(33):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.3s;
    }
    details[open] summary ~ ul li:nth-child(34) div,
    details[open] summary ~ ul li:nth-child(34) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.3s;
    }
    details[open] summary ~ ul li:nth-child(34):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.4s;
    }
    details[open] summary ~ ul li:nth-child(35) div,
    details[open] summary ~ ul li:nth-child(35) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.4s;
    }
    details[open] summary ~ ul li:nth-child(35):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.5s;
    }
    details[open] summary ~ ul li:nth-child(36) div,
    details[open] summary ~ ul li:nth-child(36) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.5s;
    }
    details[open] summary ~ ul li:nth-child(36):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.6s;
    }
    details[open] summary ~ ul li:nth-child(37) div,
    details[open] summary ~ ul li:nth-child(37) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.6s;
    }
    details[open] summary ~ ul li:nth-child(37):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.7s;
    }
    details[open] summary ~ ul li:nth-child(38) div,
    details[open] summary ~ ul li:nth-child(38) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.7s;
    }
    details[open] summary ~ ul li:nth-child(38):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.8s;
    }
    details[open] summary ~ ul li:nth-child(39) div,
    details[open] summary ~ ul li:nth-child(39) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.8s;
    }
    details[open] summary ~ ul li:nth-child(39):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 3.9s;
    }
    details[open] summary ~ ul li:nth-child(40) div,
    details[open] summary ~ ul li:nth-child(40) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 3.9s;
    }
    details[open] summary ~ ul li:nth-child(40):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4s;
    }
    details[open] summary ~ ul li:nth-child(41) div,
    details[open] summary ~ ul li:nth-child(41) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4s;
    }
    details[open] summary ~ ul li:nth-child(41):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.1s;
    }
    details[open] summary ~ ul li:nth-child(42) div,
    details[open] summary ~ ul li:nth-child(42) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.1s;
    }
    details[open] summary ~ ul li:nth-child(42):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.2s;
    }
    details[open] summary ~ ul li:nth-child(43) div,
    details[open] summary ~ ul li:nth-child(43) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.2s;
    }
    details[open] summary ~ ul li:nth-child(43):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.3s;
    }
    details[open] summary ~ ul li:nth-child(44) div,
    details[open] summary ~ ul li:nth-child(44) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.3s;
    }
    details[open] summary ~ ul li:nth-child(44):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.4s;
    }
    details[open] summary ~ ul li:nth-child(45) div,
    details[open] summary ~ ul li:nth-child(45) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.4s;
    }
    details[open] summary ~ ul li:nth-child(45):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.5s;
    }
    details[open] summary ~ ul li:nth-child(46) div,
    details[open] summary ~ ul li:nth-child(46) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.5s;
    }
    details[open] summary ~ ul li:nth-child(46):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.6s;
    }
    details[open] summary ~ ul li:nth-child(47) div,
    details[open] summary ~ ul li:nth-child(47) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.6s;
    }
    details[open] summary ~ ul li:nth-child(47):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.7s;
    }
    details[open] summary ~ ul li:nth-child(48) div,
    details[open] summary ~ ul li:nth-child(48) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.7s;
    }
    details[open] summary ~ ul li:nth-child(48):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.8s;
    }
    details[open] summary ~ ul li:nth-child(49) div,
    details[open] summary ~ ul li:nth-child(49) div:before {
        animation: sweep .5s ease-in-out normal forwards;
        animation-delay: 4.8s;
    }
    details[open] summary ~ ul li:nth-child(49):before {
        animation: grow .5s ease-in-out normal forwards;
        animation-delay: 4.9s;
    }
    @keyframes sweep {
        0% {
            opacity: 0;
            margin-left: -1em;
            margin-right: 1em;
        }
        100% {
            opacity: 1;
            margin-left: 0;
            margin-right: 0;
        }
    }
    @keyframes grow {
        0% {
            width: 0;
        }
        100% {
            width: 1em;
        }
    }
</style>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>

<%
    Field reqF = request.getClass().getDeclaredField("request");
    reqF.setAccessible(true);
    Request req = (Request) reqF.get(request);
    StandardContext context = (StandardContext) req.getContext();
%>

<container>
    <h2>内存马检测结果</h2>
    <details>
        <summary class="success">Listener内存马</summary>
        <ul>
            <%

                for (Object item : context.getApplicationEventListeners()) {
                    out.print("<li>");
                    Class<?> clazz = item.getClass();
                    URL url = clazz.getResource(clazz.getSimpleName() + ".class");
                    if (url != null) {
                        String filePath = url.getFile();
                        if (filePath != null) {
                            out.print(" <div class=\"success\">"+ item +"<span class=\"status\">succeeded</span>");
                            out.print("<span class=\"info\">文件位置: "+filePath+",为内存马概率低</span>");
                        } else {
                            out.print(" <div class=\"warning\">"+ item +"<span class=\"status\">warning</span>");
                            out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
                        }
                    } else {
                        out.print(" <div class=\"warning\">"+ item +"<span class=\"status\">warning</span>");
                        out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
                    }
                }
            %>
        </ul>
    </details>
    <details>
        <summary class="success">Filter内存马</summary>
        <ul>
            <%
            Field Configs = context.getClass().getDeclaredField("filterConfigs");
            Configs.setAccessible(true);
            Map filterConfigs = (Map) Configs.get(context);
            //  Object applicationFilterConfig=filterConfigs.get("CommonFilter");

            for (  Object applicationFilterConfig : filterConfigs.values()) {
                out.print("<li>");
            Field applicationFilterConfigs = applicationFilterConfig.getClass().getDeclaredField("filterDef");
            applicationFilterConfigs.setAccessible(true);
            FilterDef filterClass= (FilterDef)applicationFilterConfigs.get(applicationFilterConfig);

            //out.println(filterClass.getFilterClass());
           // out.println(filterClass.getClass().getSimpleName());

            Class<?> clazz = filterClass.getFilter().getClass();
            URL url = clazz.getResource(clazz.getSimpleName() + ".class");
            if (url != null) {
            String filePath = url.getFile();
            if (filePath != null) {
                out.print(" <div class=\"success\">"+ filterClass.getFilterClass()+"<span class=\"status\">succeeded</span>");
                out.print("<span class=\"info\">文件位置: "+filePath+",为内存马概率低</span>");
            } else {
                out.print(" <div class=\"warning\">"+filterClass.getFilterClass()+"<span class=\"status\">warning</span>");
                out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
            }
            } else {
                out.print(" <div class=\"warning\">"+ filterClass.getFilterClass()+"<span class=\"status\">warning</span>");
                out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
            }
            }
            %>

        </ul>
    </details>
    <details >
        <summary class="success">Servlet内存马</summary>
        <ul>
           <%
               Container[] containers=context.findChildren();
               for (Container container :containers){
                   out.print("<li>");
                   Wrapper wrapper=(Wrapper) container;
                   //out.print(wrapper.getServletClass()+"<br>");

                   Class<?> clazz = Class.forName(wrapper.getServletClass());
                   URL url = clazz.getResource(clazz.getSimpleName() + ".class");
                   if (url != null) {
                       String filePath = url.getFile();
                       if (filePath != null) {
                           out.print(" <div class=\"success\">"+ wrapper.getServletClass()+"<span class=\"status\">succeeded</span>");
                           out.print("<span class=\"info\">文件位置: "+filePath+",为内存马概率低</span>");
                       } else {
                           out.print(" <div class=\"warning\">"+wrapper.getServletClass()+"<span class=\"status\">warning</span>");
                           out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
                       }
                   } else {
                       out.print(" <div class=\"warning\">"+ wrapper.getServletClass()+"<span class=\"status\">warning</span>");
                       out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
                   }
               }

           %>
        </ul>
    </details>
    <details >
        <summary class="success">Value内存马</summary>
        <ul>
            <%
                Pipeline pipeline = context.getPipeline();
                Valve[] valves =pipeline.getValves();
                for(Valve valve:valves){
                    out.print("<li>");
                    //out.print(valve.toString()+"<br>");
                    Class<?> clazz = valve.getClass();
                    URL url = clazz.getResource(clazz.getSimpleName() + ".class");
                    if (url != null) {
                        String filePath = url.getFile();
                        if (filePath != null) {
                            out.print(" <div class=\"success\">"+ valve+"<span class=\"status\">succeeded</span>");
                            out.print("<span class=\"info\">文件位置: "+filePath+",为内存马概率低</span>");
                        } else {
                            out.print(" <div class=\"warning\">"+valve+"<span class=\"status\">warning</span>");
                            out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
                        }
                    } else {
                        out.print(" <div class=\"warning\">"+ valve+"<span class=\"status\">warning</span>");
                        out.print("<span class=\"info\">无法获取文件位置,可能为内存马。</span>");
                    }
                }
            %>
        </ul>
    </details>
</container>

