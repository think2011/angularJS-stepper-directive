define(function(require, exports, module) {
    var app = angular.module('app', []);

    app.directive('stepper', function () {
        return {
            restrict: 'EA',
            scope: {
                ngModel: '='
            },
            template: '<div class="input-group input-group-sm">' +
                        '<span  ng-click="decrement()" class="input-group-addon">-</span>' +
                        '<input ng-model="ngModel" class="form-control text-center" type="text"/>' +
                        '<span ng-mousedown="increment()" class="input-group-addon">+</span>' +
                      '</div>',
            link: function (scope, element, attrs) {
                // 缓存最小数和最大数
                var min = parseInt(attrs.min),
                    max = parseInt(attrs.max);

                scope.decrement = function () {
                    update(-1);
                };

                scope.increment = function () {
                    update(+1);
                };

                // 增减数值
                function update(offset) {
                    scope.ngModel = parseFloat(scope.ngModel) + offset;
                }

                // 限制最小数和最大数
                // todo 已知BUG，如果生成多个步进器，以下判断会造成步进器的最大数为（所有最大数中的最小的那个值）。
                scope.$watch('ngModel', function (n) {
                    if(n > max) {
                        scope.ngModel = max;
                    } else if(n < min) {
                        scope.ngModel = min;
                    }
                });

            }
        }
    });

    app.controller('appCtrl', function ($scope) {
        $scope.amount = 1;
    });

    angular.bootstrap(document, ['app']);
});