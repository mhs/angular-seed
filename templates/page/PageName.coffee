angular.module '<%= appName %>.<%= pageName %>', [
  'ui.router'
]

angular.module('<%= appName %>.<%= pageName %>').config ($stateProvider) ->
  $stateProvider
    .state '<%= pageName %>',
      url: '/<%= page_dash_name %>'
      templateUrl: '/<%= page_name %>/<%= page_name %>.html'
      controller: '<%= PageName %>Ctrl as <%= pageName %>'
