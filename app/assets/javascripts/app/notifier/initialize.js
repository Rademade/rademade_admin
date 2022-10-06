$(document).on('ready page:load', function () {
  window.notifier = new Backbone.Notifier({   // defaults
    el: 'body',     // container for notification (default: 'body')
    baseCls: 'notifier',// css classes prefix, should match css file. Change to solve conflicts.
    theme: 'clean',// default theme for notifications (available: 'plastic'/'clean').
    types: ['warning', 'error', 'info', 'success'],// available notification styles
    type: null,     // default notification type (null/'warning'/'error'/'info'/'success')
    dialog: false,  // whether display the notification with a title bar and a dialog style.
    // - sets 'hideOnClick' to false, unless defined otherwise
    // - sets 'position' to 'center', unless defined otherwise
    // - sets 'ms' to null, unless defined otherwise
    modal: false,   // whether to dark and block the UI behind the notification (default: false)
    message: '',    // default message content
    title: undefined,// default notification title, if defined, causes the notification to be
    // 'dialog' (unless dialog is 'false')
    closeBtn: false, // whether to display an enabled close button on notification
    ms: 5000,   // milliseconds before hiding (null || false => no timeout) (default: 10000)
    'class': null, // additional css class
    hideOnClick: true,// whether to hide the notifications on mouse click (default: true)
    loader: false,  // whether to display loader animation in notifications (default: false)
    destroy: false,// notification or selector of notifications to hide on show (default: false)
    opacity: 1, // notification's opacity (default: 1)
    offsetY: 0, // distance between the notifications and the top/bottom edge (default: 0)
    fadeInMs: 500,  // duration (milliseconds) of notification's fade-in effect (default: 500)
    fadeOutMs: 500, // duration (milliseconds) of notification's fade-out effect (default: 500)
    position: 'top',// default notifications position ('top' / 'center' / 'bottom')
    zIndex: 10000,  // minimal z-index for notifications
    screenOpacity: 0.5,// opacity of dark screen background that goes behind for modals (0 to 1)
    width: undefined // notification's width ('auto' if not set)
  });

  const originalGetSettings = window.notifier.getSettings.bind(window.notifier);
  window.notifier.getSettings = function (options) {
    let settings = originalGetSettings(options);
    settings.message = RademadeAdmin.helpers.stripScripts(settings.message);
    return settings;
  }
});
