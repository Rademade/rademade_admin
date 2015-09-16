if (CKEDITOR && CKEDITOR.config) {
    CKEDITOR.config.language = 'en';
    CKEDITOR.config.forcePasteAsPlainText = true;
    CKEDITOR.editorConfig = function (config) {
        config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

        // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
        config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

        // The location of a script that handles file uploads in the Flash dialog.
        config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

        // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
        config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

        // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
        config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

        // The location of a script that handles file uploads in the Image dialog.
        config.filebrowserImageUploadUrl = "/ckeditor/pictures";

        // The location of a script that handles file uploads.
        config.filebrowserUploadUrl = "/ckeditor/attachment_files";

        config.allowedContent = true;

        // Rails CSRF token
        config.filebrowserParams = function () {
            var csrf_token, csrf_param, meta,
                metas = document.getElementsByTagName('meta'),
                params = new Object();

            for (var i = 0; i < metas.length; i++) {
                meta = metas[i];

                switch (meta.name) {
                    case "csrf-token":
                        csrf_token = meta.content;
                        break;
                    case "csrf-param":
                        csrf_param = meta.content;
                        break;
                    default:
                        continue;
                }
            }

            if (csrf_param !== undefined && csrf_token !== undefined) {
                params[csrf_param] = csrf_token;
            }

            return params;
        };

        config.addQueryString = function (url, params) {
            var queryString = [];

            if (!params) {
                return url;
            } else {
                for (var i in params)
                    queryString.push(i + "=" + encodeURIComponent(params[ i ]));
            }

            return url + ( ( url.indexOf("?") != -1 ) ? "&" : "?" ) + queryString.join("&");
        };

        // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
        CKEDITOR.on('dialogDefinition', function (ev) {
            // Take the dialog name and its definition from the event data.
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
            var content, upload;

            if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
                content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
                upload = (content == null ? null : content.get('upload'));

                if (upload && upload.filebrowser && upload.filebrowser['params'] === undefined) {
                    upload.filebrowser['params'] = config.filebrowserParams();
                    upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
                }
            }
        });

        config.toolbar = [
            { name: 'document', groups: [ 'mode' ], items: [ 'Source' ] },
            { name: 'editing', groups: [ 'find' ], items: [ 'Find', 'Replace' ] },
            { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat' ] },
            { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl' ] },
            { name: 'links', items: [ 'Link', 'Unlink' ] },
            { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'SpecialChar' ] },
            { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
            { name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
            { name: 'maximize', items: ['Maximize'] }
        ];
    };
}
