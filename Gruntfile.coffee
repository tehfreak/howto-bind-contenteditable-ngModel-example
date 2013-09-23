module.exports= (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        clean:
            app: [
                '<%= pkg.build.app.cwd %>/'
            ]

        watch:
            less:
                files: ['**/*.less']
                tasks: ['less']
            jade:
                files: ['**/*.jade']
                tasks: ['jade']

        copy:
            appBrowser:
                files: [{
                    expand: true
                    cwd: '<%= pkg.build.src.browser.cwd %>'
                    src: ['**/*', '!**/bower_components/**','!**/bower.json', '!**/*.less', '!**/*.jade', '!**/*.coffee', '!**/*.md']
                    dest: '<%= pkg.build.app.browser.cwd %>'
                }]
            appBrowserJsAngular:
                files: [{
                    expand: true
                    cwd: '<%= pkg.build.src.browser.cwd %>/bower_components/angular'
                    src: ['**/*', '!**/*.json', '!**/*.md']
                    dest: '<%= pkg.build.app.browser.cwd %>/js/libs/angular'
                }, {
                    expand: true
                    cwd: '<%= pkg.build.src.browser.cwd %>/bower_components/angular-resource'
                    src: ['**/*', '!**/*.json', '!**/*.md']
                    dest: '<%= pkg.build.app.browser.cwd %>/js/libs/angular'
                }, {
                    expand: true
                    cwd: '<%= pkg.build.src.browser.cwd %>/bower_components/angular-route'
                    src: ['**/*', '!**/*.json', '!**/*.md']
                    dest: '<%= pkg.build.app.browser.cwd %>/js/libs/angular'
                }]

        less:
            appBrowserCss:
                files: [{
                    expand: true
                    cwd: '<%= pkg.build.src.browser.cwd %>/css'
                    src: ['**/*.less']
                    dest: '<%= pkg.build.app.browser.cwd %>/css'
                    ext: '.css'
                }]

        jade:
            appBrowser:
                options:
                    data:
                        debug: false
                files: [{
                    expand: true
                    cwd: '<%= pkg.build.src.browser.cwd %>'
                    src: ['**/*.jade', '!**/layout.jade']
                    dest: '<%= pkg.build.app.browser.cwd %>'
                    ext: '.html'
                }]

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-less'

    grunt.registerTask 'default', ['clean:app', 'copy:appBrowser', 'copy:appBrowserJsAngular', 'less:appBrowserCss', 'jade:appBrowser']
