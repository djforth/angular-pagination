'use strict'

_ = require('lodash')

module.exports = ()->

  itemsPerPage = 10
  currentPage  = 0
  pageCount    = 0
  itemCount    = 0

  return {
    getCurrentPage:()->
      currentPage

    getItemsPerPage:()->
      itemsPerPage

    getPageCount:()->
      pageCount

    nextPage:()->
      currentPage++ if (currentPage < pageCount)
      currentPage

    prevPage:()->
      currentPage-- if (currentPage > 0)
      currentPage

    setItemsPerPage:(i)->
      itemsPerPage = i

    setPage:(i)->
      currentPage = i

    setPageCount:(itemCount)->
      pageCount = Math.ceil(itemCount/itemsPerPage)-1

    setRange:()->
      nums = [0..pageCount]
      nums

    # showPagination:()->
    #   pageCount > 0

  }