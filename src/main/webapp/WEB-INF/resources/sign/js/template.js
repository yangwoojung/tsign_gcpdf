/*** Form ***/
$(function () {
    /*if($("input[type='checkbox']").length > 0){
        $("input[type='checkbox']").ezMark();
    }
    if($("input[type='radio']").length > 0){
        $("input[type='radio']").ezMark();
    }*/
    //pageTab();
});

$(window).on("load", function () {

    //pageTab();

});


/*** Layout **/
$(function () {
    $('.step_loc').closest('#container').addClass('dep');
    $('.btn_close').closest('body').addClass('pop');
});


/** page tab **/
function pageTab() {
    if ($('.page_tab').length) {
        $('.page_tab').each(function () {
            var _scrollTarget = $(this).find('> ul');
            var _x = 0;
            var _i = 0;
            _scrollTarget.find('> li ').each(function () {
                if ($(this).hasClass('actived')) {
                    _x = $(this).position().left;
                    _i = $(this).index();
                }
            });
            _scrollTarget.scrollLeft(_x);
        });
    }
}

/** open Content Pop  **/
function contentPopOpen(_class) {
    var _target = $('.' + _class);
    _target.addClass('open');
    htmlAddFix();
}

/** close Content Pop **/
function contentPopClose(_target) {
    $(_target).parents('.pop_wrap').removeClass('open');
    htmlDelFix();
}

/**  html Fix Add **/
function htmlAddFix() {
    $('html').addClass('fix');
}

/** html Fix Remove  **/
function htmlDelFix() {
    $('html').removeClass('fix');
}


function moreView(_target) {
    var target = $(_target);
    if (target.hasClass('open')) {
        target.removeClass('open').html('내용보기');
        target.parents('.parents').find('.scroll_data').hide();
    } else {
        target.addClass('open').html('내용접기');
        target.parents('.parents').find('.scroll_data').show();
    }
}


