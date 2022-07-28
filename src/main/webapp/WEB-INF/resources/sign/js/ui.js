/*** jquery.ezmark.min.js ***/

/**
 * ezMark (Minified) - A Simple Checkbox and Radio button Styling plugin. This plugin allows you to use a custom Image for
 * Checkbox or Radio button. Its very simple, small and easy to use.
 *
 * Copyright (c) Abdullah Rubiyath <http://www.itsalif.info/>.
 * Released under MIT License
 *
 * @author Abdullah Rubiyath
 * @version 1.0
 * @date June 27, 2010
 */
(function ($) {
    $.fn.ezMark = function (options) {
        options = options || {};
        var defaultOpt = {
            checkboxCls: options.checkboxCls || 'ez-checkbox',
            radioCls: options.radioCls || 'ez-radio',
            checkedCls: options.checkedCls || 'ez-checked',
            selectedCls: options.selectedCls || 'ez-selected',
            hideCls: 'ez-hide'
        };
        return this.each(function () {
            var $this = $(this);
            var wrapTag = $this.attr('type') == 'checkbox' ? '<div class="' + defaultOpt.checkboxCls + '">' : '<div class="' + defaultOpt.radioCls + '">';
            if ($this.attr('type') == 'checkbox') {
                $this.addClass(defaultOpt.hideCls).wrap(wrapTag).change(function () {
                    if ($(this).is(':checked')) {
                        $(this).parent().addClass(defaultOpt.checkedCls);
                        $(this).parent().parent().addClass('chk_on');
                    } else {
                        $(this).parent().removeClass(defaultOpt.checkedCls);
                        $(this).parent().parent().removeClass('chk_on');
                    }
                    if ($(this).is(':disabled')) {
                        // $(this).parent().addClass(defaultOpt.checkedCls);
                        $(this).parent().parent().addClass('ez-disabled');
                    } else {
                        // $(this).parent().removeClass(defaultOpt.checkedCls);
                        $(this).parent().parent().removeClass('ez-disabled');
                    }

                });

                if ($(this).is(':disabled')) {
                    $(this).parent().parent().addClass('ez-disabled');
                }
                if ($this.hasClass('chk_b_ty')) {
                    $this.parent().addClass('ez-chk-big');
                }

                if ($this.is(':checked')) {
                    $this.parent().addClass(defaultOpt.checkedCls);
                    $(this).parent().parent().addClass('chk_on');
                }
            } else if ($this.attr('type') == 'radio') {
                $this.addClass(defaultOpt.hideCls).wrap(wrapTag).change(function () {
                    $('input[name="' + $(this).attr('name') + '"]').each(function () {
                        if ($(this).is(':checked')) {
                            $(this).parent().addClass(defaultOpt.selectedCls);
                            $(this).parent().parent().addClass('chk_on');
                        } else {
                            $(this).parent().removeClass(defaultOpt.selectedCls);
                            $(this).parent().parent().removeClass('chk_on');
                        }

                        if ($(this).is(':disabled')) {
                            //  $(this).parent().addClass(defaultOpt.checkedCls);
                            $(this).parent().parent().addClass('ez-disabled');
                        } else {
                            // $(this).parent().removeClass(defaultOpt.checkedCls);
                            $(this).parent().parent().removeClass('ez-disabled');
                        }
                    });
                });
                if ($(this).is(':disabled')) {
                    $(this).parent().parent().addClass('ez-disabled');
                }
                if ($this.is(':checked')) {
                    $this.parent().addClass(defaultOpt.selectedCls);
                    $(this).parent().parent().addClass('chk_on');
                }
            }
        });
    }
})(jQuery);



