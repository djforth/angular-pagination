'use strict'

_ = require('lodash')

module.exports = ['$scope', 'PaginationService', ($scope, PaginationService)->
  $scope.showPagination = false

  PaginationService.setItemsPerPage($scope.itemsperpage) unless _.isUndefined($scope.itemsperpage) or $scope.itemsperpage <= 0

  $scope.$watch 'totalitems', (totalItems)->
    unless _.isUndefined(totalItems)
      PaginationService.setPageCount(totalItems)
      $scope.showPagination = PaginationService.getPageCount() > 0

      $scope.changed(PaginationService.getCurrentPage(), PaginationService.getPageCount()) if _.isFunction($scope.changed)



  ]
