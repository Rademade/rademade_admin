
var config, gulp, path, svgSprite;

gulp = require('gulp');

svgSprite = require('gulp-svg-sprite');

config = {
    shape: {
        spacing: {
            padding: 0,
            box: 'content'
        },
        dimension           : {                         // Dimension related options
            maxWidth        : 2000,                     // Max. shape width
            maxHeight       : 2000,                     // Max. shape height
            precision       : 2,                        // Floating point precision
            attributes      : false
        }
    },
    mode: {
        css: {
            dest: '../assets',
            sprite: 'images/rademade_admin/sprite.svg',
            bust: false,
            render: {
                scss: {
                    dest: 'stylesheets/rademade_admin/mixins/_sprites.scss'
                }
            }
        }
    }
};

gulp.task('sprite', function () {
    gulp.src('app/assets/images/rademade_admin/ico/*.svg')
        .pipe(svgSprite(config))
        .pipe(gulp.dest('app/assets/'));
});