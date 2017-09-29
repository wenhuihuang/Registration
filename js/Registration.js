//倒计时
var timer ;
function countDown(self,total,text){
	var btn_text = $(self).text();
	$(self).attr('disabled','true').text(total+'秒'+(text?text:''))
	var t = total;
	timer = setInterval(function(){
		t--
		$(self).text(t+'秒'+(text?text:''))
		if(t <= 0){
			clearInterval(timer);
			$(self).removeAttr('disabled').text(btn_text);
		}
	},1000)
}
$(function(){
	//检查是否同意条约
	$(".agree-submit").click(function(){
		if($("#agree").is(":checked")){
			
			location.href="./Firstep.html";
		}else{
			alert("请选中“我已仔细阅读并同意遵守”");
		}
	})
	//返回上页
	$(".prev-step").click(function(){
		history.go(-1);
 		//history.back()
	})
	//下一页
	function nextPage(position){
		window.location="./"+position+".html";
	}
	$(".next-step").click(function(){
		var posi=$(this).attr("position");
		nextPage(posi);
	})
	//选择专业
	$(".department li").find("a").click(function(){
		var html="";
		var msgs='{result:[{courseName:"计算机",teacher:"王五",schoolTime:"9:30",number:"21",tuition:"3000",operation:"选择"},{courseName:"英语",teacher:"张三",schoolTime:"10:30",number:"20",tuition:"3700",operation:"选择"}]}'
		msgsStr=eval("("+msgs+")")
		for(var i in msgsStr){
			//console.log(msgsStr[i])
			for(var j=0;j<msgsStr[i].length;j++){
				html+="<tr><td>"+msgsStr[i][j].courseName+"</td><td>"+msgsStr[i][j].teacher+"</td><td>"+msgsStr[i][j].schoolTime+"</td><td>"+msgsStr[i][j].number+"</td><td class='tuition-a'>"+msgsStr[i][j].tuition+"</td><td class='operation'><a href='javascript:;' class='btn btn-primary operation-select'>"+msgsStr[i][j].operation+"</a></td></tr>";
			}
			//console.log(html)
		}
		$(".select-tbody").html(html)
		//选择课程
		$(".operation-select").click(function(){
			//alert($(this).parents("tr").html())
			var html="<tr>";
			html+=$(this).parents("tr").html();
			html+="</tr>";
			html=html.replace("operation-select","operation-cancel");
			html=html.replace("选择","取消");
			alert(html)
			$(".select-tbody-yet").append(html);
			$(".operation-cancel").bind("click",cancelFn)
			count("tuition-a","all-count")
		})
		//取消课程
			function cancelFn(){
				$(this).parents("tr").remove()
				count("tuition-a","all-count")
			}
		
		/*
		var utl="";
		var data="";
		$.ajax({
			type:"get",
			url:"",
			async:true,
			data:data,
			success:function(msg){
				var msgs="{courseName:'计算机',teacher:'王五',schoolTime:'9:30',number:'21',tuition:'3000',operation:'选择'}"
				alert(msg);
			}
		});
		*/
	})
	//计算合计
	function count(cl,all){
		var count=0;
		$(".select-tbody-yet ."+cl+"").each(function(){
			count+=parseInt($(this).text());
		})
		$("."+all+"").text(count);
		count=0
	}
	//
	count("tuition-b","all-count-b")
	
})
