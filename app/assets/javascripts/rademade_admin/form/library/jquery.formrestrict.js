/*
 * Every time the form field is changed, sanitize its contents with the given
 * function to only allow input of a certain form.
 */
(function ($) {
    var inputEvents = "input";
    if (!("oninput" in document || "oninput" in $("<input>")[0])) {
        inputEvents += " keypress keyup";
    }

    jQuery.fn.restrict = function(sanitizationFunc) {
        $(this).bind(inputEvents, function(e) {
            $(this).val(sanitizationFunc($(this).val()));
        });
    };

    /*
     * Every time the form field is changed, modify its contents by eliminating
     * matches for the given regular expression within the field.
     */
    jQuery.fn.regexRestrict = function(regex){
        var sanitize = function(text) {
            return text.replace(regex, '');
        };
        $(this).restrict(sanitize);
    }
})(jQuery);
