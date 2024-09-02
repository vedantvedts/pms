<%-- <%@page import="com.vts.pfms.docs.model.PfmsDocTemplate"%> --%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Topics Layout</title>
<style type="text/css">
<
style>label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

h6 {
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
	padding: 4px 20px 3px 20px;
}

.width {
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

.control-label {
	font-weight: bold;
	font-size: 1rem;
	color:#07689f;
}
#doctemplatetable{
border-collapse: collapse;
border: none;width: 60%;
margin-left: 20%;
border: 1px solid black;
}
#doctemplatetable th{
text-align: center;
border: 1px solid black;
padding: 6px;
}
#doctemplatetable td{
border: 1px solid black;
padding: 6px;
}
</style>
</head>
<body>
	<%
	List<Object[]> ProjectList = (List<Object[]>) request.getAttribute("ProjectList");
	List<Object[]> ProjectIntiationList = (List<Object[]>) request.getAttribute("ProjectIntiationList");
	String ProjectId = (String)request.getAttribute("ProjectId");
	String projectname = "";
	String preprojectshortName = (String) request.getAttribute("projectshortName");
	String preprojectName ="";
	String InitiationId =(String)request.getAttribute("InitiationId");
	String ismain =(String) request.getAttribute("ismain");
	Object[] edit= (Object[])request.getAttribute("EditData");
	List<String> fontFamilyList = Arrays.asList("Agency FB","Algerian","Arial","Arial Black","Arial Narrow","Arial Rounded MT Bold","Arial Unicode MS","Baskerville Old Face",
											"Bauhaus 93","Bell MT","Berlin Sans FB","Berlin Sans FB Demi","Bernard MT Condensed","Blackadder ITC","Bodoni MT","Bodoni MT Black","Bodoni MT Condensed",
        									"Bodoni MT Poster","Book Antiqua","Bookman Old Style","Bookshelf Symbol 7","Bradley Hand ITC","Britannic Bold","Broadway", "Calibri (Body)","Calibri Light (Headings)","Century Gothic","Century Schoolbook", "Chiller", "Colonna MT","Comic Sans MS", "Consolas", "Constantia","Cooper Black","Copperplate Gothic Bold", "Copperplate Gothic Light", "Corbel",  "Courier New",  "Curlz MT", "DejaVu Sans","DejaVu Sans Condensed","DejaVu Sans Light","DejaVu Sans Mono","DejaVu Serif","DejaVu Serif Condensed","Edwardian Script ITC",  "Elephant","Engravers MT","Eras Bold ITC", "Eras Demi ITC","Eras Light ITC","Eras Medium ITC","Estrangelo Edessa","Felix Titling","Footlight MT Light","Forte","Franklin Gothic Book","Franklin Gothic Demi","Franklin Gothic Demi Cond","Franklin Gothic Heavy","Franklin Gothic Medium","Franklin Gothic Medium Cond","Freestyle Script","French Script MT","Gabriola","Garamond","Gautami","Georgia","Gigi","Gill Sans MT",
         									"Gill Sans MT Condensed","Gill Sans MT Ext Condensed Bold","Gill Sans Ultra Bold","Gill Sans Ultra Bold Condensed","Gloucester MT Extra Condensed","Goudy Old Style", "Goudy Stout","Gulim","GulimChe","Gungsuh","GungsuhChe","Haettenschweiler","Harlow Solid Italic","Helvetica","Harrington","High Tower Text","Impact","Imprint MT Shadow","Informal Roman", "IrisUPC",
          									"Iskoola Pota","Jokerman","Juice ITC","KaiTi","Kalinga","Kartika","Khmer UI","KodchiangUPC","Kristen ITC","Kunstler Script","Lao UI","Latha","Leelawadee","Leelawadee UI","Levenim MT","LilyUPC","Lucida Bright","Lucida Calligraphy","Lucida Console","Lucida Fax","Lucida Handwriting","Lucida Sans","Lucida Sans Typewriter","Lucida Sans Unicode","Magneto",
           									"Maiandra GD","Malgun Gothic","Franklin Gothic","Mangal","Marlett","Matura MT Script Capitals", "Microsoft Himalaya","Microsoft JhengHei", "Microsoft JhengHei UI","Microsoft New Tai Lue","Microsoft PhagsPa","Microsoft Sans Serif","Microsoft Tai Le", "Microsoft Uighur","Microsoft YaHei","Microsoft YaHei UI","Microsoft Yi Baiti","MingLiU","MingLiU-ExtB","MingLiU_HKSCS","MingLiU_HKSCS-ExtB",
           									"Miriam","Miriam Fixed","Mistral","Modern No. 20","Mongolian Baiti","Monotype Corsiva","MS Gothic","MS Outlook","MS Reference Sans Serif","MS Reference Specialty", "MS UI Gothic","MT Extra","MV Boli","Myanmar Text","Narkisim","Nirmala UI", "Nyala","OCR A Extended","Old English Text MT",
            								"Onyx","Palace Script MT","Palatino Linotype","Papyrus", "Parchment","Perpetua","Perpetua Titling MT","Playbill","Poor Richard","Pristina", "Raavi","Rage Italic","Ravie","Rockwell","Rockwell Condensed","Rockwell Extra Bold","Rod","Roman","Sakkal Majalla","Script MT Bold","Segoe MDL2 Assets","Segoe Print","Segoe Script","Segoe UI",
             								"Segoe UI Historic","Segoe UI Emoji","Segoe UI Light","Segoe UI Semibold","Segoe UI Semilight","Segoe UI Symbol","Shonar Bangla","Showcard Gothic","Shruti","SimSun","SimSun-ExtB","Sitka Small","Snap ITC","Stencil","Sylfaen","Symbol",
				            				"Tahoma","Tempus Sans ITC","Times New Roman","Trebuchet MS","Tw Cen MT","Tw Cen MT Condensed","Tw Cen MT Condensed Extra Bold","Verdana","Viner Hand ITC","Vivaldi","Vladimir Script", "Webdings","Wide Latin","Wingdings", "Wingdings 2", "Wingdings 3"
    										);

	List<String> fontList = Arrays.asList("Normal","Bold","Bolder","Lighter","100","200","300","400","500","600","700","800","900");
%>
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
               <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
        <%=ses %>
        </div></div>
        <%} %>
<div class="card" style="/* min-height: 850px; max-height: 1200px; */">
<div class="card-body"
						style="background: white; box-shadow: 2px 2px 2px gray;">
						<div class="row">
							<div class="col-md-3  ">
													<%-- 	<form>
								<span class="caret">System Requirements Document &nbsp; <button class="btn bg-transparent" name="ProjectId" value="<%=ProjectId %>"   type="submit" formaction="RequirementWordDownload.htm" formmethod="get" formtarget="_blank" >
								<i class="fa fa-download" style="color:green;" aria-hidden="true"></i>
								</button></span>							
							
							
							</form> --%>
							</div>
							<div class="col-md-12 border p-2 ">
			<form action="TemplateAttributesAdd.htm" method="post" id="myform1" >
			
								<!-- <form action="TemplateAttributesAdd.htm" method="post"> -->
									<div align="center">
										<label class="control-label"
											style="color: #145374; font: 1.5 rem; text-decoration: underline">Document
											Template Attributes</label>
									</div>


<table id="doctemplatetable" style="">
	<thead>
		<tr>
			<th colspan="2" >Font-size</th>
			<th colspan="2" >Font-weight</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<label class="control-label">Header  (h1)&nbsp;:</label><span class="mandatory" style="color: red;">*</span>
			</td>
			<td style="text-align: left;">
				<input type="number" name="HeaderFontSize" id="HeaderFontSize" required
                	<% if (edit != null) { %> value="<%=edit[0]%>" <% } %> class="form-control" placeholder="E.g. 12 px" min="8" max="50"
                	oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
            </td>
            <td>
            	<label class="control-label">Header : (h1)&nbsp;</label><span class="mandatory" style="color: red;">*</span>
            </td>
            <td style="text-align: left;  width: 200px;">
				<select class="form-control form-control selectdee" name="HeaderFontWeight" required id="HeaderFontWeight">
					<option disabled="disabled" selected="selected" value="">Select...</option>
					<%for(String font : fontList) {%>
						<option value="<%=font %>" <% if(edit!=null && edit[1]!=null && edit[1].toString().equalsIgnoreCase(font)) { %>selected="selected"<% } %>><%=font %></option>
					<%} %>
				</select>
            </td>
		</tr>
		<tr>
		<td>
		<label class="control-label">Sub Header  (h2)&nbsp;:</label><span class="mandatory" style="color: red;">*</span>
		</td>
		<td><input type="number" name="subHeaderFontSize" id="subHeaderFontSize" required
                	<% if (edit != null) { %> value="<%=edit[2]%>" <% } %> class="form-control" placeholder="E.g. 12 px" min="8" max="50"
                	oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
		</td>
		 <td>
		 <label class="control-label">SubHeader : (h2)&nbsp;</label>
											<span class="mandatory" style="color: red;">*</span>
		 </td>
		 <td style="text-align: left;">

		 	<select class="form-control form-control selectdee" name="subHeaderFontWeight" required id="subHeaderFontWeight">
					<option disabled="disabled" selected="selected" value="">Select...</option>
					<%for(String font : fontList) {%>
						<option value="<%=font %>" <% if(edit!=null && edit[3]!=null && edit[3].toString().equalsIgnoreCase(font)) { %>selected="selected"<% } %>><%=font %></option>
					<%} %>
				</select>
		 </td>
		</tr>
			<tr>
			<td>
				<label class="control-label">Super Header  (h3)&nbsp;:</label><span class="mandatory" style="color: red;">*</span>
			</td>
			<td style="text-align: left;">
				<input type="number" name="SuperHeaderFontSize" id="SuperHeaderFontSize" required
					 <% if (edit != null) { %> value="<%=edit[9]%>" <% } %> class="form-control" placeholder="E.g. 12 px" min="8" max="50"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			</td>
			<td>
				<label class="control-label">Super Header : (h3)&nbsp;</label><span class="mandatory" style="color: red;">*</span>
			</td>
			<td style="text-align: left; ">
				<select class="form-control form-control selectdee" name="SuperHeaderFontWeight" required id="SuperHeaderFontWeight">
					<option disabled="disabled" selected="selected" value="" >Select...</option>
					<%for(String font : fontList) {%>
						<option value="<%=font %>" <% if(edit!=null && edit[10]!=null && edit[10].toString().equalsIgnoreCase(font)) { %>selected="selected"<% } %>><%=font %></option>
					<%} %>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<label class="control-label">Paragraph :</label><span class="mandatory" style="color: red;">*</span>
			</td>
			<td style="text-align: left;">
				<input type="number" name="ParaFontSize" id="ParaFontSize" min="8" max="50" required <%if(edit!=null) {%> value="<%=edit[4]%>"<% }%>
					class="form-control"  placeholder="E.g. 12 px" 
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			</td>
			<td>
				<label class="control-label">Paragraph :</label><span class="mandatory" style="color: red;">*</span>
			</td>
			<td style="text-align: left; ">
				<select class="form-control form-control selectdee" name="paraFontWeight" required id="paraFontWeight">
					<option disabled="disabled" selected="selected" value="" >Select...</option>
					<%for(String font : fontList) {%>
						<option value="<%=font %>" <% if(edit!=null && edit[5]!=null && edit[5].toString().equalsIgnoreCase(font)) { %>selected="selected"<% } %>><%=font %></option>
					<%} %>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<label class="control-label">Font Family:</label><span class="mandatory" style="color: red;">*</span>
			</td>
			<td colspan="3">
				<select class="form-control form-control selectdee" name="FontFamily" required id="FontFamily">
           			<option disabled="disabled" selected="selected">Select Font Family...</option>
           			<%for(String fontFamily : fontFamilyList) {%>
           				<option value="<%=fontFamily %>" <% if(edit!=null && edit[11]!=null && edit[11].toString().equalsIgnoreCase(fontFamily)) { %>selected="selected"<% } %>><%=fontFamily %></option>
           			<%} %>
           		</select>
			</td>
		</tr>
		<tr>
			<td>
				<label class="control-label">Restriction On Use:</label><span class="mandatory" style="color: red;">*</span>
			</td>
			<td colspan="3">
			<textarea rows="3" cols="40" class="form-control" name="RestictionOnUse" placeholder="Max 1000 characters" maxlength="1000"><%if(edit[12]!=null) {%> <%=edit[12].toString() %> <%} %></textarea>
			
			</td>
	</tbody>
</table>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<%-- <input type="hidden" name="projectid" value="<%=ProjectId%>" >
						<input type="hidden" name="initiationid" value="<%=InitiationId%>" >
						<input type="hidden" name="ismain" value="<%=ismain%>" > --%>
						<input type="hidden" name="AttributId" <% if(edit != null ) { %> value="<%= edit[8] %>" <% } %> >
						<br>
						<div align="center">
							<%if(edit!=null) {%>
							<button type="submit" class="btn btn-sm btn-warning edit" formaction="TemplateAttributesEdit.htm" formmethod="post" onclick="return confirm('Are you sure to update?')">UPDATE</button>
							<%} else{%>
								<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
							<%} %>
						</div></form>
						</div>
							</div>
	</div>
</div>
<script type="text/javascript">
$('#HeaderFontSize').attr('max', maxValue);
$('#HeaderFontSize').attr('min', minValue);
$('#subHeaderFontSize').attr('max', maxValue);
$('#subHeaderFontSize').attr('min', minValue);
$('#ParaFontSize').attr('max', maxValue);
$('#ParaFontSize').attr('min', minValue);
$('#SuperHeaderFontSize').attr('max', maxValue);
$('#SuperHeaderFontSize').attr('min', minValue);
$('#HeaderFontSize').on('input', function() {
    var enteredValue = parseInt($(this).val()); // Parse the entered value as an integer
    if (enteredValue < minValue) {
        $(this).val(minValue); // Set the input field value to the minimum value
    }
    else if (enteredValue > maxValue) {
        $(this).val(maxValue); // Set the input field value to the maximum value
    }
});
});
$('#subHeaderFontSize').on('input', function() {
   var enteredValue = parseInt($(this).val()); // Parse the entered value as an integer
   if (enteredValue < minValue) {
       $(this).val(minValue); // Set the input field value to the minimum value
   }
   else if (enteredValue > maxValue) {
       $(this).val(maxValue); // Set the input field value to the maximum value
   }
});
});
$('#ParaFontSize').on('input', function() {
   var enteredValue = parseInt($(this).val()); // Parse the entered value as an integer
   // Check if the entered value is less than the minimum value
   if (enteredValue < minValue) {
       $(this).val(minValue); // Set the input field value to the minimum value
   }
   // Check if the entered value is greater than the maximum value
   else if (enteredValue > maxValue) {
       $(this).val(maxValue); // Set the input field value to the maximum value
   }
});
});
$('#SuperHeaderFontSize').on('input', function() {
   var enteredValue = parseInt($(this).val()); // Parse the entered value as an integer
   // Check if the entered value is less than the minimum value
   if (enteredValue < minValue) {
       $(this).val(minValue); // Set the input field value to the minimum value
   }
   // Check if the entered value is greater than the maximum value
   else if (enteredValue > maxValue) {
       $(this).val(maxValue); // Set the input field value to the maximum value
   }
});
});
</script>
</body>
</html>