require 'angular'
require 'angular-mocks'
require('../lib/pagination.coffee')
_ = require 'lodash'

describe 'Pagination Ctrl', ->
  ctrl = scope = service =  null

  beforeEach ->
    angular.mock.module('$pagination')

    angular.mock.inject ( $rootScope, $controller, PaginationService)->
      service = PaginationService
      spyOn(service, "setItemsPerPage")
      scope = $rootScope.$new()
      scope.itemsperpage = 20
      ctrl = $controller("PaginationCtrl", { $scope: scope })


  describe 'setup', ->
    it 'should exsist', ->
      expect(ctrl).toBeDefined()

    it 'should set Items PerPage', ->
      expect(service.setItemsPerPage).toHaveBeenCalled()
      expect(service.setItemsPerPage).toHaveBeenCalledWith(20)

    it 'should call setPageCount when total items are set', ->
      spyOn(service, "setPageCount")
      scope.totalitems = 200
      scope.$apply()
      expect(service.setPageCount).toHaveBeenCalled()
      expect(service.setPageCount).toHaveBeenCalledWith(200)






