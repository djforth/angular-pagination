var _, pagination;

require('angular');

_ = require('lodash');

pagination = angular.module('$pagination', []).run([
  "$templateCache", function(e) {
    return e.put("directives/pagination.html", '<div class="pagination" ng-show="showPagination"><ul><li class="prev previous_page" ng-class="prevPageDisabled()"><a ng-click="prevPage()" rel="previous" title="Previous" href="javascript:"><</a></li><li ng-class="setActive(n)" ng-repeat="n in range()"><a rel="start" ng-click="setPage(n)" href="javascript:">{{n+1}}</a></li><li ng-class="nextPageDisabled()"><a ng-click="nextPage()" rel="next" title="next" href="javascript:">></a></li></ul></div>');
  }
]).controller('PaginationCtrl', [
  '$scope', 'PaginationService', function($scope, PaginationService) {
    $scope.showPagination = false;
    if (!(_.isUndefined($scope.itemsperpage) || $scope.itemsperpage <= 0)) {
      PaginationService.setItemsPerPage($scope.itemsperpage);
    }
    return $scope.$watch('totalitems', function(totalItems) {
      if (!_.isUndefined(totalItems)) {
        PaginationService.setPageCount(totalItems);
        $scope.showPagination = PaginationService.getPageCount() > 0;
        if (_.isFunction($scope.changed)) {
          return $scope.changed(PaginationService.getCurrentPage(), PaginationService.getPageCount());
        }
      }
    });
  }
]).directive('pagination', [
  'PaginationService', function(PaginationService) {
    return {
      restrict: 'A',
      transclude: true,
      controller: 'PaginationCtrl',
      scope: {
        changed: '=changed',
        itemsperpage: '=itemsperpage',
        totalitems: '=totalitems'
      },
      templateUrl: 'directives/pagination.html',
      link: function($scope, $elem, $attr) {
        var callBack;
        callBack = function() {
          if (_.isFunction($scope.changed)) {
            return $scope.changed(PaginationService.getCurrentPage(), PaginationService.getPageCount());
          }
        };
        $scope.range = function() {
          return PaginationService.setRange();
        };
        $scope.nextPageDisabled = function() {
          if (PaginationService.getCurrentPage() === PaginationService.getPageCount()) {
            return "disabled";
          } else {
            return "";
          }
        };
        $scope.prevPageDisabled = function() {
          if (PaginationService.getCurrentPage() === 0) {
            return "disabled";
          } else {
            return "";
          }
        };
        $scope.nextPage = function() {
          PaginationService.nextPage();
          return callBack();
        };
        $scope.prevPage = function() {
          PaginationService.prevPage();
          return callBack();
        };
        $scope.setActive = function(i) {
          if (i === PaginationService.getCurrentPage()) {
            return "active";
          } else {
            return "";
          }
        };
        return $scope.setPage = function(i) {
          PaginationService.setPage(i);
          return callBack();
        };
      }
    };
  }
]).filter("itemsForCurrentPage", function(PaginationService) {
  return function(data) {
    var current, end, offset, start;
    if (_.isEmpty(data)) {
      return data;
    }
    offset = PaginationService.getItemsPerPage();
    current = PaginationService.getCurrentPage();
    start = current * offset;
    end = start + offset;
    return data.slice(start, end);
  };
}).service('PaginationService', function() {
  var currentPage, itemCount, itemsPerPage, pageCount;
  itemsPerPage = 10;
  currentPage = 0;
  pageCount = 0;
  itemCount = 0;
  return {
    getCurrentPage: function() {
      return currentPage;
    },
    getItemsPerPage: function() {
      return itemsPerPage;
    },
    getPageCount: function() {
      return pageCount;
    },
    nextPage: function() {
      if (currentPage < pageCount) {
        currentPage++;
      }
      return currentPage;
    },
    prevPage: function() {
      if (currentPage > 0) {
        currentPage--;
      }
      return currentPage;
    },
    setItemsPerPage: function(i) {
      return itemsPerPage = i;
    },
    setPage: function(i) {
      return currentPage = i;
    },
    setPageCount: function(itemCount) {
      return pageCount = Math.ceil(itemCount / itemsPerPage) - 1;
    },
    setRange: function() {
      var j, nums, results;
      nums = (function() {
        results = [];
        for (var j = 0; 0 <= pageCount ? j <= pageCount : j >= pageCount; 0 <= pageCount ? j++ : j--){ results.push(j); }
        return results;
      }).apply(this);
      return nums;
    }
  };
});

module.exports = pagination;
