
var config, gulp, path, svgSprite;

gulp = require('gulp');

svgSprite = require('gulp-svg-sprite');

config = {
    mode: {
        css: {
            dest: '../assets',
            spacing: {
                padding: 20,
                box: 'content'
            },
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