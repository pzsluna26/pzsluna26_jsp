<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		function formSubmit(form, methodType){
			if(methodType == 1){
				form.method = "get";
			}
			else if  (methodType == 2){
				form.method = "post";
			}
			form.submit();
		}
	</script>
	<h2>web.xml 에서 매핑하기</h2>
	<form>
		<input type="button" value= "Get방식 전송" onclick= "formSubmit(this.form,1);"/> 
		<input type="button" value= "Post방식 전송" onclick= "formSubmit(this.form,2);"/> 
	</form>
</body>
</html>