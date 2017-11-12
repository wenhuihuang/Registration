$(function () {
    $('.pop-cover').click(function () {
        hidePop()
    })
})

//显示弹框
function showPop() {
    $('.pop-wrap').show();
}
//关闭弹框
function hidePop() {
    $('.pop-wrap').hide();
}