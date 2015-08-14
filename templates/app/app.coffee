# Declare the main module and dependencies
angular.module('<%= appName %>', [
  # External modules
  'ui.router'
  'angular-loading-bar'

  # MODULE LIST AUTOGEN BELOW THIS LINE
])


angular.module('<%= appName %>').config ($locationProvider) ->
  $locationProvider.html5Mode(enabled: true, requireBase: false)

angular.module('<%= appName %>').config ($urlRouterProvider) ->
  $urlRouterProvider.otherwise('/')

angular.module('<%= appName %>').config ($httpProvider) ->
  $httpProvider.defaults.withCredentials = true
  $httpProvider.defaults.headers.delete = {'Content-Type': 'application/json'}

angular.module('<%= appName %>').config (cfpLoadingBarProvider) ->
  cfpLoadingBarProvider.includeSpinner = false
  cfpLoadingBarProvider.latencyThreshold = 250

# We have to have $state here, to avoid this bug:
# https://github.com/angular-ui/ui-router/issues/679#issuecomment-31116942
angular.module('<%= appName %>').run ($state, $rootScope) ->

  # UI Router silently swallows errors on resolve. This exposes them.
  $rootScope.$on '$stateChangeError',
  (event, toState, toParams, fromState, fromParams, error) ->
    throw error
