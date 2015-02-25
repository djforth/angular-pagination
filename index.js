'use strict';
var pagination, paginationCtrl, paginationDir, paginationFilter, paginationSrv;

require('angular');

paginationCtrl = require('./paginationCtrl.coffee');

paginationDir = require('./paginationDir.coffee');

paginationFilter = require('./paginationFilter.coffee');

paginationSrv = require('./paginationSrv.coffee');

pagination = angular.module('$pagination', []).run([
  "$templateCache", function(e) {
    return e.put("directives/pagination.html", '<div class="pagination" ng-show="showPagination"><ul><li class="prev previous_page" ng-class="prevPageDisabled()"><a ng-click="prevPage()" rel="previous" title="Previous" href="javascript:"><</a></li><li ng-class="setActive(n)" ng-repeat="n in range()"><a rel="start" ng-click="setPage(n)" href="javascript:">{{n+1}}</a></li><li ng-class="nextPageDisabled()"><a ng-click="nextPage()" rel="next" title="next" href="javascript:">></a></li></ul></div>');
  }
]).service('PaginationService', paginationSrv).controller('PaginationCtrl', paginationCtrl).directive('pagination', paginationDir).filter("itemsForCurrentPage", paginationFilter);

module.exports = pagination;
