$(function(){
    //判断是不是手机端
    var is_mobile = !!navigator.userAgent.match(/mobile/i);
    if(is_mobile){
        $('.main-content').css({
            background:'#fff',
            'padding-bottom':'65px'
        })
        $('.tables').css({
            "margin":'0 12px'
        })

        //设置按钮在底部
        $('.mobile-footer').css({
            position:'fixed',
            bottom:0,
            left:0,
            right:0,
            background:'#fff',
            margin:0,
            padding:'15px 0 0px 0'
        })
    }
})