//倒计时
var timer;
function countDown(self, total, text) {
	var btn_text = $(self).text();
	$(self).attr('disabled', 'true').text(total + '秒' + (text ? text : ''))
	var t = total;
	timer = setInterval(function () {
		t--
		$(self).text(t + '秒' + (text ? text : ''))
		if (t <= 0) {
			clearInterval(timer);
			$(self).removeAttr('disabled').text(btn_text);
		}
	}, 1000)
}
$(function () {

	/**
	 * 对$.ajax封装一层 加入loading
	 */
	(function ($) {
		//1.得到$.ajax
		var _ajax = $.ajax;
		$.ajax = function (options) {
			//2。每次调用是的默认处理方法
			var fn = {
				error: function (XMLHttpRequest, textStatus, errorThrown) {
					alert("网络出错，请重试！" + XMLHttpRequest.responseText)
				},
				beforeSend: function (XHR) {
					//发送前
					var loading = $('<div class="loading-pop" style="position:fixed;top:0;bottom:0;left:0;right:0;z-index:10000;  opacity:1; filter:alpha(opacity=60);background:rgba(0, 0, 0, 0.78)" ><div style="position:fixed;top:0;bottom:0;left:0;right:0;z-index:11000;" class="loading-icon"></div></div>');
					window.parent.$('body').length>0&&window.parent.$('body').append(loading);

					//禁用提交按钮
					$('[type="submit"]').attr('disabled', true)
					$('[type="button"]').attr('disabled', true)
				},
				complete: function (XHR, TS) {
					//发送完成
					window.parent.$('.loading-pop').remove();

					//启用提交按钮
					$('[type="submit"]').attr('disabled', false)
					$('[type="button"]').attr('disabled', false)
				}

			}
			//3.如果有写该方法时，调用外面写的方法
			if (options.error) {
				fn.error = options.error;
			}
			if (options.beforeSend) {
				fn.beforeSend = options.beforeSend
			}
			if (options.complete) {
				fn.complete = options.complete
			}

			var _options = $.extend(options, {
				error: function (XMLHttpRequest, textStatus, errorThrown) {
					fn.error(XMLHttpRequest, textStatus, errorThrown);
				},
				beforeSend: function (XHR) {
					fn.beforeSend(XHR);
				},
				complete: function (XHR) {
					fn.complete(XHR);
				}
			})
			_ajax(_options)
		}
	})(jQuery);

		window.parent.$('body').length>0&&window.parent.$('.loading-pop').remove();
		$('.loading-pop').remove();
	

	$('form').on('submit',function(){
		//发送前
		var loading = $('<div class="loading-pop" style="position:fixed;top:0;bottom:0;left:0;right:0;z-index:10000; opacity:1; filter:alpha(opacity=60);background:rgba(0, 0, 0, 0.78) " ><div style="position:fixed;top:0;bottom:0;left:0;right:0;z-index:11000;" class="loading-icon"></div></div>');
		window.parent.$('body').length>0&&window.parent.$('body').append(loading);
	})

	//检查是否同意条约
	$(".agree-submit").click(function () {
		if ($("#agree").is(":checked")) {

			location.href = "./Firstep.html";
		} else {
			alert("请选中“我已仔细阅读并同意遵守”");
		}
	})
	//返回上页
	$(".prev-step").click(function () {
		history.go(-1);
		//history.back()
	})
	//下一页
	function nextPage(position) {
		window.location = "./" + position + ".html";
	}
	$(".next-step").click(function () {
		var posi = $(this).attr("position");
		nextPage(posi);
	})
	//选择专业
	$(".department li").find("a").click(function () {
		var html = "";
		var msgs = '{result:[{courseName:"计算机",teacher:"王五",schoolTime:"9:30",number:"21",tuition:"3000",operation:"选择"},{courseName:"英语",teacher:"张三",schoolTime:"10:30",number:"20",tuition:"3700",operation:"选择"}]}'
		msgsStr = eval("(" + msgs + ")")
		for (var i in msgsStr) {
			//console.log(msgsStr[i])
			for (var j = 0; j < msgsStr[i].length; j++) {
				html += "<tr><td>" + msgsStr[i][j].courseName + "</td><td>" + msgsStr[i][j].teacher + "</td><td>" + msgsStr[i][j].schoolTime + "</td><td>" + msgsStr[i][j].number + "</td><td class='tuition-a'>" + msgsStr[i][j].tuition + "</td><td class='operation'><a href='javascript:;' class='btn btn-primary operation-select'>" + msgsStr[i][j].operation + "</a></td></tr>";
			}
			//console.log(html)
		}
		$(".select-tbody").html(html)
		//选择课程
		$(".operation-select").click(function () {
			//alert($(this).parents("tr").html())
			var html = "<tr>";
			html += $(this).parents("tr").html();
			html += "</tr>";
			html = html.replace("operation-select", "operation-cancel");
			html = html.replace("选择", "取消");
			alert(html)
			$(".select-tbody-yet").append(html);
			$(".operation-cancel").bind("click", cancelFn)
			count("tuition-a", "all-count")
		})
		//取消课程
		function cancelFn() {
			$(this).parents("tr").remove()
			count("tuition-a", "all-count")
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
	function count(cl, all) {
		var count = 0;
		$(".select-tbody-yet ." + cl + "").each(function () {
			count += parseInt($(this).text());
		})
		$("." + all + "").text(count);
		count = 0
	}
	//
	count("tuition-b", "all-count-b")

})
