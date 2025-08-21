<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="jakarta.persistence.criteria.CriteriaBuilder.In"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
  
<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>



	<title>EDIT NOTICE</title>
	<style type="text/css">
		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
		
		input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    /* display: none; <- Crashes Chrome on hover */
    -webkit-appearance: none;
    margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}
		
	</style>
</head>

<body>


<%
Object[] notice=(Object[])request.getAttribute("NoticeEditData");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
%> 





    <br />
    
    
	<div class="container">

		<div class="row">

			<div class="col-md-12">

				<div class="card shadow-nohover">
					<div class="card-header"
						style=" background-color: #055C9D;margin-top: ">

						<h3 class="text-white">Edit Notice</h3>

					</div>
						<div class="card-body">
				
					
					
						
     
                       	<form action="NoticeEditSubmit.htm" method="post" name="addcommitteefrm" id="addcommitteefrm" onsubmit="return confirm('Are you sure to submit ?');" >
									     	<div class="row">
									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">From </label>
											 <input  class="form-control"  data-date-format="dd/mm/yyyy" value="<%=notice[3]!=null?sdf.format(notice[3]):""%>"  readonly="readonly" id="fdate" name="fdate"  required="required" >
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label class="control-label">To </label> 
											<input  class="form-control"  data-date-format="dd/mm/yyyy" readonly="readonly" value="<%=notice[4]!=null?sdf.format(notice[4]):""%>" id="tdate" name="tdate"  required="required">
										</div>
									</div>
										 
                                     <div class="col-md-8">
										<div class="form-group">
											<label class="control-label">Notice</label> 
										    <textarea class="form-control" name="noticeFiled" style="height: 9rem;" maxlength="255" required="required" placeholder="Enter Notice here with max 255 characters" ><%=notice[2]!=null?StringEscapeUtils.escapeHtml4(notice[2].toString()): ""%></textarea>
										</div>
									</div>     
									      <input type="hidden"  id="noticeId" name="noticeId" value="<%=notice[0]%>"/>  
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									
									</div>		
									<div align="center">
									    <input type="submit" class="btn btn-primary btn-sm submit "id="sub" value="SUBMIT" name="sub">
									    		<a class="btn btn-primary btn-sm back" href="IndividualNoticeList.htm" >BACK</a>
									 </div>
									 </form>
							 
					
						
					</div>
					
					
		
			
			
					</div>
					<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
					</div>
				</div>
			</div>
		</div>

	
<script type='text/javascript'> 
$(document).ready(function() {
    $('#selectDesig').select2();
});
</script>	
<script>
$("#mobile").blur(function(){
	
	 var phoneno = /^\d{10}$/;
	 var inputtxt=document.getElementById("mobile").value;
	
	 if (/^\d{10}$/.test(inputtxt)) {
		   
		} else {
		    alert("Invalid number; must be ten digits");
		    mobile.focus();
		    return false;
		}	  
	});

</script>

<!-- <script>
$("#ExpertNo").blur(function(){
	
	
	 var inputtxt=document.getElementById("ExpertNo").value;
	
	 if (/^\b[A-Z]{1}\d{4}$/.test(inputtxt)) {
		   
		} else {
		    alert("Expert No; must be like this ex = E0000 ");
		    ExpertNo.focus();
		    return false;
		}	  
	});

</script> -->




	<script type="text/javascript">
	

var fromDate=null;
$("#fdate").change(function(){
	
	 fromDate = $("#fdate").val();


$('#tdate').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	
	"minDate":fromDate,
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
		
});
});
$('#fdate').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
    "startDate":"<%=sdf.format(notice[2])%>",
	"minDate":"<%=sdf.format(notice[2])%>",
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
});

$('#tdate').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	 "startDate":"<%=sdf.format(notice[3])%>",
		"minDate":"<%=sdf.format(notice[2])%>",
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
		
});
</script>

</body>

</html>