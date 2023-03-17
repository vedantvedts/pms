<%-- <%@page import="com.vts.pfms.docs.model.PfmsDocTemplate"%> --%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Topics Layout</title>
<style type="text/css">

	
 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
@page {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black;  
            
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          
      
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "Document Template";
          }            
          
}
 
 table tr td ,table tr th
 {
 	padding-top: 5px;
 	padding-bottom: 5px;
 	padding-right: 5px; 	
 }
 
</style>
</head>
<body>
<%-- 
<%
	Object[] doc = (Object[])request.getAttribute("docdata");
	List<PfmsDocTemplate> docitemslist=(List<PfmsDocTemplate>)request.getAttribute("doctemplatelist");
%>

<div style="max-width: 650px; min-width: 650px;" >
	<table style=" margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; min-width: 650px;font-size: 16px; border-collapse:collapse;"  >
		<tr>
			<th style="width: 100% ; text-align: center; " ><%=doc[2] %></th>			
		</tr>
			
			<%	int count =1;
				for(PfmsDocTemplate item : docitemslist)
				{ 
					if(item.getLevelNo()==1)
					{ %>
						<tr>
							<td><%=count %> )&nbsp; <%=item.getItemName() %></td>							
						</tr>	
						
						<%	int count1=1;
							for(PfmsDocTemplate item1 : docitemslist){ 
							if(item1.getLevelNo()==2 && item.getTemplateItemId() ==item1.getParentLevelId())
							{ %>
								<tr>
									<td style="padding-left: 30px;"><%=count %>.<%=count1 %>)&nbsp;<%=item1.getItemName() %></td>
								</tr>
								
								<%	int count2=1;
									for(PfmsDocTemplate item2 : docitemslist){ 
									if(item2.getLevelNo()==3 && item1.getTemplateItemId() ==item2.getParentLevelId())
									{ %>
										<tr>
											<td style="padding-left: 60px;"><%=count %>.<%=count1 %>.<%=count2 %>)&nbsp;<%=item2.getItemName() %></td>
										</tr>
									<% count2++;
									} %>
								<%} %>
								
								
								
							<% count1++;
							} %>
						<%} %>
										
				<%	count++;}
			}%>
	</table>
</div>
 --%>
</body>
</html>