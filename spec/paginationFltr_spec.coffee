require 'angular'
require 'angular-mocks'

_ = require 'lodash'

require('../src/pagination.coffee')

dummyData = []
_.forEach [0...18], (i)->
  dummyData.push "Test Data #{i}"


describe 'Pagination module directive', ->
  filter = service = null
  beforeEach ->
    angular.mock.module('$pagination')
    angular.mock.inject ($filter, PaginationService)->
      filter  = $filter
      service = PaginationService

  it 'should be defined', ->
    expect(filter).toBeDefined()

  describe "filter results", ->

    beforeEach ->
      spyOn(service, "getItemsPerPage").and.returnValue(5)

    it 'should return the correct data for the first page', ->
      spyOn(service, "getCurrentPage").and.returnValue(0)
      filtered = filter("itemsForCurrentPage")(dummyData)
      expect(filtered.length).toEqual(5)
      _.forEach [0...4], (i)->
        expect(filtered).toContain(dummyData[i])


    it 'should return the correct data for page 3', ->
      spyOn(service, "getCurrentPage").and.returnValue(2)
      filtered = filter("itemsForCurrentPage")(dummyData)
      expect(filtered.length).toEqual(5)
      _.forEach [10...14], (i)->
        expect(filtered).toContain(dummyData[i])

    it 'should return the correct data for Final Page', ->
      spyOn(service, "getCurrentPage").and.returnValue(3)
      filtered = filter("itemsForCurrentPage")(dummyData)
      expect(filtered.length).toEqual(3)
      _.forEach [15...18], (i)->
        expect(filtered).toContain(dummyData[i])









