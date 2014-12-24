class @GalleryImageView extends Backbone.View

  events :
    'click .remove-ico' : 'remove'

  setClassName : (className) ->
    @className = className

  remove : (e) ->
    if confirm I18n.t('rademade_admin.image_remove_confirm')
      @_removeImage $(e.currentTarget).data('url')

  _removeImage : (removeUrl) ->
    $.ajax
      type : 'delete'
      url : removeUrl
      data :
        class_name : @className
      dataType : 'json'
      success : () =>
        @$el.fadeOut 300 # todo destroy and remove from collection-view
      error : (data) =>
        window.notifier.notify data.error