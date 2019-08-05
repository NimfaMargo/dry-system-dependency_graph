require 'erubis'

module Dry
  module System
    module DependencyGraph
      class Middleware
        class TemplateBuilder
          def call(xdot, dependencies_calls)
            template = <<~TEMPLATE
              <html>
                <head>
                  <title>Dependency Graph</title>
                  <script src="//d3js.org/d3.v4.min.js"></script>
                  <script src="http://viz-js.com/bower_components/viz.js/viz-lite.js"></script>
                  <script src="https://github.com/magjac/d3-graphviz/releases/download/v0.1.2/d3-graphviz.min.js"></script>
                </head>
                <body>
                  <input type="hidden" id="test" value='<%== xdot =%>' style="display:none"/>
                  <div id="graph" style="text-align: center;"></div>

                  <div id="calls" style="text-align: center;">
                    <%== dependencies_calls =%>
                  </div>

                  <script>
                    window.onload = function() {
                      d3.select("#graph").graphviz().renderDot(document.getElementById('test').value)
                    }
                  </script>
                </body>
              </html>
            TEMPLATE

            Erubis::EscapedEruby.new(template).result(binding())
          end
        end
      end
    end
  end
end
