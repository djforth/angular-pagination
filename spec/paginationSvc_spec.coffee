require 'angular'
require 'angular-mocks'
require('../src/pagination.coffee')
_ = require 'lodash'

describe 'Pagination Service', ->
  ctrl = rootScope = service =  null

  beforeEach ->
    angular.mock.module('$pagination')

    angular.mock.inject (PaginationService)->
      service = PaginationService

  describe 'defaults', ->

    it 'currentPage is 0', ->
      expect(service.getCurrentPage()).toEqual(0)

    it 'pageCount is 0', ->
      expect(service.getPageCount()).toEqual(0)

    it 'itemsPerPage default 10', ->
      expect(service.getItemsPerPage()).toEqual(10)

  describe 'setting functions', ->

    it 'setItemsPerPage', ->
      service.setItemsPerPage(20)
      expect(service.getItemsPerPage()).toEqual(20)

    it 'setPage', ->
      service.setPage(2)
      expect(service.getCurrentPage()).toEqual(2)

    it 'setPageCount', ->
      service.setPageCount(40)
      expect(service.getPageCount()).toEqual(3)

    it 'setRange', ->
      service.setPageCount(40)
      expect(service.setRange()).toEqual([0..3])

  describe 'Previous and next functions', ->
    beforeEach ->
      service.setPageCount(40)

    it 'should increment with next function', ->
      service.nextPage()
      expect(service.getCurrentPage()).toEqual(1)

    it 'should not increment more than page count', ->
      service.setPage(3)
      service.nextPage()
      expect(service.getCurrentPage()).toEqual(3)

    it 'should decrease with Previous function', ->
      service.setPage(3)
      service.prevPage()
      expect(service.getCurrentPage()).toEqual(2)

    it 'should not decrease less than 0 with Previous function', ->
      service.prevPage()
      expect(service.getCurrentPage()).toEqual(0)

  # describe 'show function', ->

  #   it 'should return false if page count is 0', ->
  #     expect(service.showPagination()).toBeFalsy()

  #   it 'should return true if page count is greater than 0', ->
  #     service.setPageCount(40)
  #     expect(service.showPagination()).toBeTruthy()














