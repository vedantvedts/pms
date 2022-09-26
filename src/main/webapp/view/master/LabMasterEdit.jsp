<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>LAB MASTER EDIT</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table thead tr th {
	background-color: aliceblue;
	text-align: left;
	width:30%;
}

.table thead tr td {

	text-align: left;
}

label{
	font-size: 15px;
}


table{
	box-shadow: 0 4px 6px -2px gray;
}


 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}





/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}





</style>
</head>
<body>

<%


Object[] LabMasterEditData=(Object[]) request.getAttribute("LabMasterEditData");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("employeelist");
List<Object[]> lablist=(List<Object[]>)request.getAttribute("lablist");

%>

<div class="row"> 
<div class="col-sm-1"></div>

 <div class="col-sm-10"  style="top: 10px;">
<div class="card shadow-nohover" >
<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <h5 class="text-white" ><b>Lab Details Edit</b></h5>
</div>
<div class="card-body">


<form name="myfrm" action="LabMasterEditSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  

<tr>
  <th>
<label >Lab Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td width="">

	<%if(LabMasterEditData[1]!=null){ %> 
 
 	<input  class="form-control" type="text" name="LabCode" required="required" maxlength="255" style="font-size: 15px;"  id="LabCode" 
 	 value="<%=LabMasterEditData[1]%> " >
 
	<%}else{ %>-<%} %>
 
 
</td>

</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  

<tr>
 <th >
<label >Lab Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td width="">

				
			
		<%if(LabMasterEditData[2]!=null){ %>			
					
 	<input  class="form-control form-control" type="text" name="LabName" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;"  
 	 value="<%=LabMasterEditData[2] %>" > 
			
	
	<%}else{ %>-<%} %>			
					
</td>

</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>


  <th>
<label >Lab Address:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
 
 
		<%if(LabMasterEditData[4]!=null){ %>			
					
 	<input  class="form-control form-control" type="text" name="LabAddress" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;width:88%" 
 	  value="<%=LabMasterEditData[4] %>" >
			
		<%}else{ %>-<%} %>
 
</td>

</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>



<th>
<label >Lab City:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

		<%if(LabMasterEditData[5]!=null){ %>			
					
 	<input  class="form-control form-control" type="text" name="LabCity" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;"  
 	 value="<%=LabMasterEditData[5] %>" >  
			
	<%}else{ %>-<%} %>
			
</td>

 <th>
<label >Lab Email:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

		<%if(LabMasterEditData[9]!=null){ %>			
					
 	<input  class="form-control form-control" type="text" name="LabEmail" required="required" maxlength="30" style="font-size: 15px;" 
 	  value="<%=LabMasterEditData[9] %>" >
			
		<%}else{ %>-<%} %>	

</td>

</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>

 <th>
<label >Lab Pin:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

		<%if(LabMasterEditData[6]!=null){ %>			
					
 	<input  class="form-control form-control" type="text" name="LabPin" required="required" maxlength="6" style="font-size: 15px;"  
value="<%=LabMasterEditData[6] %>" > 
			
		<%}else{ %>-<%} %>

</td>




<th>
<label >Lab Unit Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

<%if(LabMasterEditData[3]!=null){ %>		
					
 	<input  class="form-control form-control" type="number" name="LabUnitCode" required="required" maxlength="255" style="font-size: 15px;"  id="LabCode" 
 	 value="<%=LabMasterEditData[3] %>" >  
			
<%}else{ %>-<%} %>
			
</td>

</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed "  >
<thead>
<tr>

 <th>
<label >Lab Telephone:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

		<%if(LabMasterEditData[7]!=null){ %>			
					
 	<input  class="form-control form-control" type="text" name="LabTelephone" required="required" maxlength="15" style="font-size: 15px;"  
 	 value="<%=LabMasterEditData[7] %>" >
			
		<%}else{ %>-<%} %>

</td>




<th>
<label >Lab Fax No:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

			<%if(LabMasterEditData[8]!=null){ %>		
					
 	<input  class="form-control form-control" type="number" name="LabFaxNo" required="required" maxlength="255" style="font-size: 15px;"  id="" 
  value="<%=LabMasterEditData[8] %>" >
			
	<%}else{ %>-<%} %>
			
</td>

</tr>



</thead> 
</table>


<table class="table table-bordered table-hover table-striped table-condensed "  > 
  <thead>
<tr>

 <th>
<label >Lab Authority:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td style="width:20%">
 

					
					
 	<input  class="form-control form-control" type="text" name="LabAuthority" required="required" maxlength="30" style="font-size: 15px;"  
 <%if(LabMasterEditData[10]!=null){ %> value="<%=LabMasterEditData[10] %>" <%}else{ %>value=""<%} %> >
			
		

</td>




<th>
<label >Lab Authority Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
			
			
 	 <select class="form-control selectdee" name="LabAuthorityName" data-container="body" data-live-search="true"  required="required" style="width: 100%">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				
				<% for (  Object[] obj : EmployeeList){ %>
		
				<option value=<%=obj[0]%> <%if(obj[0].toString().equalsIgnoreCase(LabMasterEditData[11].toString())) {%> selected="selected"  <%} %>><%=obj[1]%> </option>
			
				<%} %>

			</select> 
				
				
</td>

</tr>



</thead> 
</table>


<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>

 <th style="width:20%">
<label >Lab :
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee" name="labid" data-container="body" data-live-search="true"  required="required" style="width: 100%">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				
				<% for (  Object[] obj : lablist){ %>
		
				<option value="<%=obj[0]%>,<%=obj[1]%>" <%if(obj[0].toString().equalsIgnoreCase(LabMasterEditData[14].toString())) {%> selected="selected"  <%} %>><%=obj[2]%> (<%=obj[3]%>) </option>
			
				<%} %>

			</select> 
				
</td>

</tr>


</thead> 
</table>



<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>

 <th style="width:20%">
<label >Lab RFP Website:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

		<%if(LabMasterEditData[12]!=null){ %>			
					
 	<input  class="form-control form-control" type="text" name="LabRFPEmail" required="required" maxlength="30" style="font-size: 15px;"  
 	 value="<%=LabMasterEditData[12] %>" >
			
		<%}else{ %>-<%} %>

</td>

</tr>


</thead> 
</table>



</div>
</div>

	  <div id="LabAddSubmit" align="center"><input type="submit"  class="btn btn-primary btn-sm submit"  id="submit_button"       /></div>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
								<input type="hidden" name="LabMasterId" value="<%= LabMasterEditData[0]%>">
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	  
	 <div class="col-sm-1"></div>
	  
	  </div>
<script type="text/javascript">

$(document).ready(function(){
	  $("#check").click(function(){
	  
	  });
	});
$("#UsernameSubmit").hide();
$(document)
.ready(function(){
	 $("#check").click(function(){
			// SUBMIT FORM

		$('#UserName').val("");
		 $("#UsernameSubmit").hide();
			var $UserName = $("#UserNameCheck").val();
if($UserName!=""&&$UserName.length>=4){
			
			$
					.ajax({

						type : "GET",
						url : "UserNamePresentCount.htm",
						data : {
							UserName : $UserName
						},
						datatype : 'json',
						success : function(result) {

							var result = JSON.parse(result);
						
							var s = '';
							if(result>0){
								s = "UserName Not Available";	
								$('#UserNameMsg').html(s);
							
								 $("#UsernameSubmit").hide();
							}else{
								$('#UserName').val($UserName);
								
								 $("#UsernameSubmit").show();
							}
							
							
							
							
						}
					});

}
		});
});


$(document)
.on(
		"change",
		"#LoginType",

		function() {
			// SUBMIT FORM

	
			var $LoginType = this.value;

		
		
			if($LoginType=="D"||$LoginType=="G"||$LoginType=="T"||$LoginType=="O"||$LoginType=="B"||$LoginType=="S"||$LoginType=="C"||$LoginType=="P"||$LoginType=="U"){
			
				$("#Employee").prop('required',true);
			}
			else{
				$("#Employee").prop('required',false);
			}
	
		});

</script>
<script type="text/javascript" defer>
    function readURL(input) {
    	
    	var fileElement = document.getElementById("LabLogo");
        var fileExtension = "";
        if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
        }
        if (fileExtension.toLowerCase() == "jpg") {
        	
        	if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result)
                };
                reader.readAsDataURL(input.files[0]);
                setTimeout(initCropper, 1000);
            }
        	
            return true;
        }
        else {
            alert("You must select a JPG file for upload");
            return false;
        }

    }
    
    function initCropper(){
        var image = document.getElementById('blah');
        var cropper = new Cropper(image, {
          aspectRatio: 1 / 1,
          crop: function(e) {
            console.log(e.detail.x);
            console.log(e.detail.y);
          }
        });

        // On crop button clicked
        document.getElementById('submit_button').addEventListener('click', function(){
            var imgurl =  cropper.getCroppedCanvas().toDataURL();
            var img = document.createElement("img");
            img.src = imgurl;
       		
            var block = imgurl.split(";");
            // Get the content type
            var contentType = block[0].split(":")[1];// In this case "image/gif"
            // get the real base64 content of the file
            var realData = block[1].split(",")[1];// In this case "iVBORw0KGg...."

            // Convert to blob
            var blob = b64toBlob(realData, contentType);

           
            
            // Create a FormData and append the file
            var fd = new FormData(form);
            fd.append("image", blob);
     
          
            
        })
    }
    
    function b64toBlob(b64Data, contentType, sliceSize) {
    	
    	
        contentType = contentType || '';
        sliceSize = sliceSize || 512;

        var byteCharacters = atob(b64Data);
        var byteArrays = [];

        for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
            var slice = byteCharacters.slice(offset, offset + sliceSize);

            var byteNumbers = new Array(slice.length);
            for (var i = 0; i < slice.length; i++) {
                byteNumbers[i] = slice.charCodeAt(i);
            }

            var byteArray = new Uint8Array(byteNumbers);

            byteArrays.push(byteArray);
        }

      var blob = new Blob(byteArrays, {type: contentType});
      return blob;
    }
    
    
</script>








</body>
</html>