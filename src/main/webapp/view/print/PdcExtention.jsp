<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/print/pdcExtention.css" var="pdcExtention" />     
<link href="${pdcExtention}" rel="stylesheet" />

</head>
<body>
<%
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");

%>
<div class="container-fluid" id="print-section">
    <div class="row">
        <div class="col-md-12">
            <div class="row card-header">
                <div class="col-md-6">
                    <table class="project-table">
                        <tr>
                            <td><h4>Project :</h4></td>
                            <td>
                                <form method="post" action="ProjectSanctionPreview.htm">
                                    <select class="form-control selectdee project-select"  
                                            data-container="body" data-live-search="true"  
                                            name="projectinitiationid" required="required"  
                                            onchange="this.form.submit()">
                                        <option disabled selected value="">Choose...</option>
                                        <% if(projectslist!=null){ for(Object[] obj : projectslist){ %>
                                            <option value="<%=obj[0]%>">
                                                <%= obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>
                                            </option>
                                        <% }} %>
                                    </select>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </form>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-6 justify-content-end">
                    <a class="btn btn-info btn-sm shadow-nohover back-btn" href="ProjectDocs.htm"> Back</a>
                </div>
            </div>
        </div>
    </div>
</div>

<form action="" method="post">
    <div>
        <h4 class="sheet-heading">SHEET_15</h4>

        <div class="letter-header">
            No.__________/___/D(R&D)<br>
            Government of India <br>
            Ministry of Defence<br>
            Dept. of Defence Res & Dev<br>
            DRDO HQ,<br>
            New Delhi - 110 011<br>
            Date______ Month, Year
        </div>

        <p class="recipient">To,<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Chairman <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Defense Research & Development Organizations<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DRDO HQ, New Delhi - 110 011
        </p>

        <p class="note">(For projects, where CFA is Lab Director / Cluster DG, addressee will be Lab Director / cluster DG and corresponding entries will be change accordingly).</p>

        <p class="subject">Subject: PDC extension of Project (Name) _______(No)____</p>

        <p class="justified-text">1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am directed to convey the sanction of the competent authority for PDC extension of Project (Name) _______ (No) sanction vide Govt. letter no. ______ dated _______ as amended vide corrigendum no. _____ dated _____, from ______ months (DD/MM/YYYY) to ____ months (DD/MM/YYYY). (List all amendments)</p>

        <p class="justified-text">2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; All other entries remain same. </p>

        <p class="justified-text">3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Unique sanction code: 
            <input type="text" name="USC" required="required">
        </p>

        <p class="justified-text">4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This issues with the concurrence of Ministry of Defense (Finance / R&D) vide their Dy. No 
            <input type="text" name="USC" required="required">  
            /MoD (Fin)/R&D dated 
            <input class="form-control date-input" 
                   id="currentdate" data-date-format="dd/mm/yyyy" readonly 
                   name="startDate">
        </p>

        <p class="signature">Yours faithfully,()<br>Authorized signatory of CFA</p>

        <div align="center">
            <table class="copy-table">
                <tr>
                    <td><b><u>Ink Signed Copy to :</u></b></td>
                    <td><b><u>Copy to </u></b></td>
                </tr>
                <tr>
                    <td>DG (Cluster) <br>
                        Director Lab <br>
                        Director P&C <br>
                        CGDA, New Delhi<br>
                        PCDA (R&D), New Delhi<br>
                        CDA (R&D), Concerned<br>
                        File copy<br>
                    </td>
                    <td>The Director of Audit, Defence Services, New Delhi<br>
                        Addl FA & JS or IFA (R&D), Concerned (as the case may be)<br>
                        Director FMM<br>
                        Director CW&E<br>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <br>
    <div align="center">
        <button type="submit" class="btn btn-sm submit submit-btn">Submit</button>
    </div>
</form>

<script type="text/javascript">
$('#currentdate,#datepicker').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script>
</body>
</html>