// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  var _;

  _ = require('lodash');

  module.exports = function() {
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
  };

}).call(this);