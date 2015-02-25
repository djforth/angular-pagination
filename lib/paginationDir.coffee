_  = require('lodash')

module.exports = ['PaginationService',(PaginationService)->
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
]