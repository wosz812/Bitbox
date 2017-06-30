<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>test</title>
<script type="text/javascript">
	function div_OnOff(v){
		if(v=="1"){
	 		document.getElementById("con").style.display = "none"; // 보여줌
		} else {
			document.getElementById("con").style.display = ""; // 숨김
		}
	}
</script>
</head>
<body>
<script type="text/javascript">
	function div_OnOff(v){
		if(v=="1"){
	 		document.getElementById("con").style.display = "none"; // 보여줌
		} else {
			document.getElementById("con").style.display = ""; // 숨김
		}
	}
</script>
	<div class="form-group">
		<input type="radio" name="searchInfo" value="0" onclick="div_OnOff(this.value);" class="flat-red" checked>Search Id
		<input type="radio" name="searchInfo" value="1" onclick="div_OnOff(this.value);" class="flat-red">Search pw
	</div>
	
	
    
    <div id="con" style="display:" class="form-group has-feedback">
        			<input type="text" class="form-control" placeholder="Id" name="id">
        			<span class="glyphicon glyphicon-check form-control-feedback"></span>
     			</div>
     			
     			<div id="con" style="display:">
        <input type="text" placeholder="Id" name="id" value="1">
    </div>
</body>
</html>