'use strict'

_ = require('lodash')

module.exports = (PaginationService)->
  (data)->
    return data if _.isEmpty(data)
    offset  = PaginationService.getItemsPerPage()
    current = PaginationService.getCurrentPage()

    start = current * offset
    end   = start + offset
    data.slice(start, end)