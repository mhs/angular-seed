describe "<%= PageName %>Ctrl:", ->
  beforeEach(module("<%= appName %>.<%= pageName %>"))

  beforeEach inject ($controller) ->
    @controllerService = $controller

  describe "<%= pageName %>.value", ->
    beforeEach inject ->
      @controller = @controllerService "<%= PageName %>Ctrl"

    it "has the value 'world'", ->
      expect(@controller.value).toBe('<%= Page_Name %>')
