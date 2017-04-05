var gulp = require('gulp');
var $    = require('gulp-load-plugins')();
var argv = require('yargs').argv;

// Check for --production flag
var isProduction = !!(argv.production);

gulp.task('sass', function() {

    var minifycss = $.if(isProduction, $.minifyCss());

    return gulp.src('scss/**/*.scss')
    .pipe($.sass()) // Using gulp-sass
    .pipe(minifycss)
    .pipe(gulp.dest('../css'))
    // .pipe(browserSync.reload({
    //   stream: true
    // }))
});

gulp.task('watch', function (){
    gulp.watch('scss/**/*.scss', ['sass']);
    gulp.watch('../*.css', ['autoprefixer']);
});

gulp.task('autoprefixer', function (){
    gulp.src('../css/screen.css')
        .pipe($.autoprefixer({
            browsers: ['last 2 versions'],
            cascade: false
        }))
        .pipe(gulp.dest('../css'))
});

gulp.task('minifycss', function(){
    return gulp.src('../css/**/*.css')
    .pipe(gulpIf('../*.css', cssnano()))
    .pipe(gulp.dest('../css'))
});

gulp.task('default', ['sass', 'autoprefixer', 'watch']);

gulp.task('build', function(){
    gulp.watch('../css/**/*.css', ['minifycss']);
});
