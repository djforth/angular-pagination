import _ from 'lodash';

function __range__(left, right, inclusive) {
  let range = [];
  let ascending = left < right;
  let end = !inclusive ? right : ascending ? right + 1 : right - 1;
  for (let i = left; ascending ? i < end : i > end; ascending ? i++ : i--) {
    range.push(i);
  }
  return range;
}

const pagination = angular
  .module('$pagination', [])
  .run([
    '$templateCache',
    e =>
      e.put(
        'directives/pagination.html',
        '<div class="pagination" ng-show="showPagination"><ul><li class="prev previous_page" ng-class="prevPageDisabled()"><a ng-click="prevPage()" rel="previous" title="Previous" href="javascript:"><</a></li><li ng-class="setActive(n)" ng-repeat="n in range()"><a rel="start" ng-click="setPage(n)" href="javascript:">{{n+1}}</a></li><li ng-class="nextPageDisabled()"><a ng-click="nextPage()" rel="next" title="next" href="javascript:">></a></li></ul></div>'
      ),
  ])
  .service('PaginationService', function() {
    let itemsPerPage = 10;
    let currentPage = 0;
    let pageCount = 0;
    return {
      getCurrentPage() {
        return currentPage;
      },

      getItemsPerPage() {
        return itemsPerPage;
      },

      getPageCount() {
        return pageCount;
      },

      nextPage() {
        if (currentPage < pageCount) {
          currentPage++;
        }
        return currentPage;
      },

      prevPage() {
        if (currentPage > 0) {
          currentPage--;
        }
        return currentPage;
      },

      setItemsPerPage(i) {
        return (itemsPerPage = i);
      },

      setPage(i) {
        return (currentPage = i);
      },

      setPageCount(itemCount) {
        return (pageCount = Math.ceil(itemCount / itemsPerPage) - 1);
      },

      setRange() {
        const nums = __range__(0, pageCount, true);
        return nums;
      },
    };
  })
  .filter(
    'itemsForCurrentPage',
    PaginationService =>
      function(data) {
        if (_.isEmpty(data)) {
          return data;
        }

        const offset = PaginationService.getItemsPerPage();
        const current = PaginationService.getCurrentPage();

        const start = current * offset;
        const end = start + offset;
        return data.slice(start, end);
      }
  )
  .controller('PaginationCtrl', [
    '$scope',
    'PaginationService',
    function($scope, PaginationService) {
      $scope.showPagination = false;

      if (!_.isUndefined($scope.itemsperpage) && !($scope.itemsperpage <= 0)) {
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
    },
  ]);

export default pagination;
