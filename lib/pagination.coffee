require('angular')
_ = require('lodash')

# paginationCtrl   = require('./paginationCtrl.coffee')
# paginationDir    = require('./paginationDir.coffee')
# paginationFilter = require('./paginationFilter.coffee')
# paginationSrv    = require('./paginationSrv.coffee')

pagination = angular.module('$pagination', [])
.run(["$templateCache",(e)->
  e.put("directives/pagination.html",'<div class="pagination" ng-show="showPagination"><ul><li class="prev previous_page" ng-class="prevPageDisabled()"><a ng-click="prevPage()" rel="previous" title="Previous" href="javascript:"><</a></li><li ng-class="setActive(n)" ng-repeat="n in range()"><a rel="start" ng-click="setPage(n)" href="javascript:">{{n+1}}</a></li><li ng-class="nextPageDisabled()"><a ng-click="nextPage()" rel="next" title="next" href="javascript:">></a></li></ul></div>')
])

.controller('PaginationCtrl', ['$scope', 'PaginationService', ($scope, PaginationService)->
  $scope.showPagination = false

  PaginationService.setItemsPerPage($scope.itemsperpage) unless _.isUndefined($scope.itemsperpage) or $scope.itemsperpage <= 0

  $scope.$watch 'totalitems', (totalItems)->
    unless _.isUndefined(totalItems)
      PaginationService.setPageCount(totalItems)
      $scope.showPagination = PaginationService.getPageCount() > 0

      $scope.changed(PaginationService.getCurrentPage(), PaginationService.getPageCount()) if _.isFunction($scope.changed)
  ])

.directive('pagination', ['PaginationService',(PaginationService)->
  return {
    restrict: 'A',
    transclude: true,
    controller:'PaginationCtrl',
    scope:{
      changed:'=changed'
      itemsperpage:'=itemsperpage'
      totalitems:'=totalitems'
    },
    templateUrl: 'directives/pagination.html',
    link:($scope, $elem, $attr)->

      callBack = ()->
        $scope.changed(PaginationService.getCurrentPage(), PaginationService.getPageCount()) if _.isFunction($scope.changed)

      $scope.range = ()->
        PaginationService.setRange()

      $scope.nextPageDisabled = ()->
        return if PaginationService.getCurrentPage() == PaginationService.getPageCount() then "disabled" else ""

      $scope.prevPageDisabled = ()->
        return if PaginationService.getCurrentPage() == 0 then "disabled" else ""

      $scope.nextPage = ()->
        PaginationService.nextPage()
        callBack()

      $scope.prevPage = ()->
        PaginationService.prevPage()
        callBack()

      $scope.setActive = (i)->
        return if i == PaginationService.getCurrentPage() then "active" else ""

      $scope.setPage = (i)->
        PaginationService.setPage(i)
        callBack()


  }
])
.filter("itemsForCurrentPage", (PaginationService)->
  (data)->
    return data if _.isEmpty(data)
    offset  = PaginationService.getItemsPerPage()
    current = PaginationService.getCurrentPage()

    start = current * offset
    end   = start + offset
    data.slice(start, end)
    )
.service('PaginationService', ()->

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
  }
)

module.exports = pagination
