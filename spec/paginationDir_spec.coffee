require 'angular'
require 'angular-mocks'

_ = require 'lodash'

require('../lib/pagination.coffee')



describe 'Pagination module directive', ->
  ctrl = scope = element = el = service = isoScope =null
  beforeEach ->
    angular.mock.module('$pagination')
    angular.mock.inject ($rootScope, $compile, PaginationService)->
      scope = $rootScope.$new()
      scope.change = jasmine.createSpy("changed")

      service = PaginationService
      element  = angular.element("<div pagination itemsperpage=20 totalitems=\"itemCount\" changed=\"change\" ></div>")


      body = angular.element(document.body)
      body.append(element)

      el = $compile(element)(scope)
      scope.$digest()

      isoScope = element.isolateScope();

  afterEach ->
    angular.element(element).remove();

  it 'should render pagination', ->
    expect(element).toBeDefined()

  describe 'pagination show/hide', ->
    paginator = null
    beforeEach ->
      paginator = angular.element(element.find('div'))


    it 'should not show pagination if count is 0', ->

      paginator = angular.element(element.find('div'))
      expect(paginator.hasClass('ng-hide')).toBeTruthy()

    it 'should not show pagination if count is less than itemsPerPage', ->
      scope.itemCount = 18
      scope.$apply()

      expect(paginator.hasClass('ng-hide')).toBeTruthy()

    it 'should show pagination if over itemsPerPage ', ->
      scope.itemCount = 100
      scope.$apply()

      expect(paginator.hasClass('ng-hide')).toBeFalsy()


  describe 'adds page numbers', ->

    beforeEach ->
      spyOn(service, "setRange").and.returnValue([0..4])
      scope.showPagination = true
      scope.$apply()


    it 'will set range', ->
      expect(service.setRange).toHaveBeenCalled()

    it 'should add range', ->
      li = element.find("li")
      expect(li.length).toEqual(7)

    it 'should have correct numbers', ->
      li = element.find("li")
      for list, i in li
        num = angular.element(list)
        if i == 0
          expect(num.text()).toEqual("<")
        else if (i == (li.length - 1))
          expect(num.text()).toEqual('>')
        else
          expect(num.text()).toEqual(String(i))


  describe 'disabling next and previous', ->


    it 'nextPageDisabled if currentPage does not equals pageCount', ->
      spyOn(service, "getCurrentPage").and.returnValue(2)
      spyOn(service, "getPageCount").and.returnValue(4)
      expect(isoScope.nextPageDisabled()).toEqual("")

    it 'prevPageDisabled if currentPage does not equal 0', ->
      spyOn(service, "getCurrentPage").and.returnValue(2)
      # spyOn(service, "getPageCount").and.returnValue(4)
      expect(isoScope.prevPageDisabled()).toEqual("")


    describe 'next disabling currentPage equals page count', ->

      beforeEach ->
        spyOn(service, "getCurrentPage").and.returnValue(4)
        spyOn(service, "getPageCount").and.returnValue(4)


      it 'currentPage equals pageCount', ->
        expect(isoScope.nextPageDisabled()).toEqual("disabled")

      it 'should add disable class to next', ->
        li = angular.element(_.last(element.find("li")))
        expect(li.hasClass('disabled')).toBeTruthy()

    describe 'prev disabling currentPage equals 0', ->

      beforeEach ->
        spyOn(service, "getCurrentPage").and.returnValue(0)

      it 'currentPage equals pageCount', ->
        expect(isoScope.prevPageDisabled()).toEqual("disabled")

      it 'should add disable class to next', ->
        li = angular.element(_.first(element.find("li")))
        expect(li.hasClass('disabled')).toBeTruthy()


  describe 'nextPage, prevPage and setPage', ->

    describe 'functions', ->
      beforeEach ->
        # scope.
        spyOn(service, "nextPage")
        spyOn(service, "prevPage")
        spyOn(service, "setPage")
        spyOn(service, "getCurrentPage").and.returnValue(2)
        spyOn(service, "getPageCount").and.returnValue(3)

      it 'nextPage', ->
        isoScope.nextPage()
        expect(service.nextPage).toHaveBeenCalled()
        expect(scope.change).toHaveBeenCalledWith(2, 3)

      it 'prevPage', ->
        isoScope.prevPage()
        expect(service.prevPage).toHaveBeenCalled()
        expect(scope.change).toHaveBeenCalledWith(2, 3)

      it 'setPage', ->
        isoScope.setPage()
        expect(service.setPage).toHaveBeenCalled()
        expect(scope.change).toHaveBeenCalledWith(2, 3)


    describe 'element function', ->
      next = prev = pagnum = null

      beforeEach ->
        spyOn(service, "setRange").and.returnValue([0..4])
        scope.showPagination = true
        spyOn(isoScope, "nextPage")
        spyOn(isoScope, "prevPage")
        spyOn(isoScope, "setPage")

        scope.$apply()

        li = element.find('li')

        prev = angular.element(_.first(li))
        next = angular.element(_.last(li))
        pagnum = angular.element(li[1])

      it 'next button should trigger', ->
        link = angular.element(next.find('a'))
        link.triggerHandler('click')
        expect(isoScope.nextPage).toHaveBeenCalled()

      it 'prev button should trigger', ->
        link = angular.element(prev.find('a'))
        link.triggerHandler('click')
        expect(isoScope.prevPage).toHaveBeenCalled()

      it 'page num button should trigger', ->
        link = angular.element(pagnum.find('a'))
        link.triggerHandler('click')
        expect(isoScope.setPage).toHaveBeenCalled()
        expect(isoScope.setPage).toHaveBeenCalledWith(0)


























