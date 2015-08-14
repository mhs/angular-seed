gulp = require('gulp')
template = require('gulp-template')
conflict = require('gulp-conflict')
notify = require('gulp-notify')
inquirer = require('inquirer')
changeCase = require('change-case')
rename = require('gulp-rename')
fs = require('fs')


addModuleToApp = (name) ->
  appModule = fs.readFileSync('app/app.coffee', 'utf-8')
  appModule = appModule.replace(
    "# MODULE LIST AUTOGEN BELOW THIS LINE",
    "# MODULE LIST AUTOGEN BELOW THIS LINE\n  '#{name}'")
  fs.writeFileSync('app/app.coffee', appModule, 'utf-8')

gulp.task 'template/page', (done) ->
  inquirer.prompt([
    {
      type: 'input',
      name: 'appName',
      message: 'What is the root module?'
    },
    {
      type: 'input',
      name: 'pageName',
      message: 'What is the name of this new component?'
    }
  ], (opts) ->
    opts.appName = changeCase.camelCase(opts.appName)
    opts.pageName = changeCase.camelCase(opts.pageName)
    opts.PageName = changeCase.upperCaseFirst(opts.pageName)
    opts.page_name = changeCase.snakeCase(opts.pageName)
    opts.page_dash_name = changeCase.paramCase(opts.pageName)
    opts.Page_Name = opts.App_Name = changeCase.titleCase(opts.pageName)

    addModuleToApp "#{opts.appName}.#{opts.pageName}"

    gulp.src('templates/page/**', { base: 'templates/page/' })
    .pipe(template(opts))
    .pipe(rename((filename) ->
      filename.basename = filename.basename.replace("PageName", opts.PageName)
      filename.basename = filename.basename.replace("pageName", opts.PageName)
      filename.basename = filename.basename.replace("page_name", opts.page_name)
    ))
    .pipe(gulp.dest("app/#{opts.page_name}"))
    .on('finish', ->
      done())

    console.log "\n\n\nYour page is available at /#{opts.page_dash_name}\n\n\n"
  )


gulp.task 'template/app', (done) ->
  inquirer.prompt([
    {
      type: 'input',
      name: 'appName',
      message: 'What is the app name?'
    },
  ], (opts) ->
    opts.appName = changeCase.camelCase(opts.appName)
    opts.App_Name = changeCase.titleCase(opts.appName)

    gulp.src('templates/tasks/**', { base: 'templates/' })
      .pipe(template(opts))
      .pipe(gulp.dest("./"))

    gulp.src('templates/config/**', { base: 'templates/' })
      .pipe(template(opts))
      .pipe(gulp.dest("./"))

    gulp.src('templates/app/**', { base: 'templates/' })
     .pipe(template(opts))
     .pipe(gulp.dest("./"))
     .on('finish', ->
     done())
  )
