app = angular.module 'stepper', []


app.directive 'stepper', ->
    return {
      restrict: 'E'
      scope   :
        ngModel: '='
        min    : '@'
        max    : '@'

      template:'''
                <style>
                  .stepper {
                            margin:0;
                            padding: 0;
                            list-style: none;
                            overflow: hidden;
                            display: inline-block;
                        }

                        .stepper li {
                            float: left;
                        }

                        .stepper li button {
                            width:25px;
                            height:25px;
                            line-height:25px;
                            border-radius: 100%;
                            border:none;
                            background: #ddd;
                            margin:0;
                            padding: 0;
                        }

                        .stepper li button:hover {
                            background: #ccc;
                        }

                        .stepper li button:active {
                            background: #ddd;
                        }

                        .stepper li input {
                            width:50px;
                            height:25px;
                            text-align: center;
                            border:none;
                            border-bottom: 1px solid #eee;
                        }
                </style>

                <ul class="stepper">
                    <li><button ng-click="update('reduce')" class="reduce">－</button></li>
                    <li><input ng-model="ngModel" class="result" type="number"/></li>
                    <li><button ng-click="update('plus')" class="plus">＋</button></li>
                </ul>
                '''
      link    : (scope, element, attrs) ->
        min = if scope.min then +scope.min else 0
        max = if scope.max then +scope.max else 100
        unless scope.ngModel then scope.ngModel = 0


        scope.update = (action) ->
          if action is 'plus'
            scope.ngModel++
          else
            scope.ngModel--


        # view to model
        scope.$watch 'ngModel', (newVal) ->
          if newVal > max
            scope.ngModel = max
          else if newVal < min
            scope.ngModel = min
    }