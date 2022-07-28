var ts = {};

(function ($) {
    var _tsPopup = {
        init: function () {
            this.addClass('ts_popup');
        },
        open: function (src) {
            this.html('<iframe scrolling="no" name="iframeName' + this.attr('id') + '"></iframe>');
            this.find('iframe').attr('src', src).show();
            $('#wrap').hide();
        },
        postOpen: function (opts) {
            this.html('<iframe name="iframeName' + this.attr('id') + '"></iframe>');

            document.getElementById(opts.formNm).action = opts.action;
            document.getElementById(opts.formNm).target = this.find('iframe').attr('name');
            document.getElementById(opts.formNm).submit();
            //document[opts.formNm].action = opts.action;
            //document[opts.formNm].target = this.find('iframe').attr('name');
            //document[opts.formNm].submit();

            this.find('iframe').show();
            $('#wrap').hide();
        },
        close: function () {
            $('#wrap').show();
            this.find('iframe').remove();
        }
    };

    $.fn.tsPopup = function (opts) {
        if (_tsPopup[opts]) {
            return _tsPopup[opts].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof opts === 'object' || !opts) {
            return _tsPopup.init.apply(this, arguments);
        } else {
            $.error('Method ' + opts + ' does not exist on jQuery.tsPopup');
        }
    };
})(jQuery);
