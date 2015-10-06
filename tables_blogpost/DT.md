





```r
datatable(dep_delays_by_month,
          filter = 'top', options = list(
            pageLength = 12, autoWidth = TRUE
          ))
```

<!--html_preserve--><div id="htmlwidget-5585" style="width:100%;height:auto;" class="datatables"></div>
<script type="application/json" data-for="htmlwidget-5585">{"x":{"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"],["PDX","PDX","PDX","PDX","PDX","PDX","PDX","PDX","PDX","PDX","PDX","PDX","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],[1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12],[346,380,1553,782,695,590,648,486,417,428,402,798,866,739,385,713,1449,377,815,886,452,713,397,733]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> </th>\n      <th>origin</th>\n      <th>month</th>\n      <th>max_delay</th>\n    </tr>\n  </thead>\n</table>","options":{"pageLength":12,"autoWidth":true,"columnDefs":[{"className":"dt-right","targets":[2,3]},{"orderable":false,"targets":0}],"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[10,12,25,50,100]},"callback":null,"filter":"top","filterHTML":"<tr>\n  <td></td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n  </td>\n  <td data-type=\"integer\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"1\" data-max=\"12\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"346\" data-max=\"1553\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n</tr>"},"evals":[]}</script><!--/html_preserve-->
