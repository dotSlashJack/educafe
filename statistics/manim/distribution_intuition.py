#!/usr/bin/env python
# tutorial file for the basics of manim
from manimlib.imports import *

class Shapes(Scene):
    #A few simple shapes
    def construct(self):
        circle = Circle()
        square = Square()
        line=Line(np.array([3,0,0]),np.array([5,0,0]))
        triangle=Polygon(np.array([0,0,0]),np.array([1,1,0]),np.array([1,-1,0]))

        self.add(line)
        self.play(ShowCreation(circle))
        self.play(FadeOut(circle))
        self.play(GrowFromCenter(square))
        self.play(Transform(square,triangle))

class drawNormalPDF(GraphScene):
    CONFIG = {
        "function" : lambda x : (1 / np.sqrt(2*np.pi)) * (np.exp( (-1*(x**2))/2) ), # the equation you are plotting, with lambda : variable(s)
        "function_color" : BLUE, # if doing reimann rectangles, then need to change line 157 of graph_scene.py to this color (defaults to red)
        #"center_point" : 0,
        "x_min" : -4,
        "x_max" : 4,
        "y_min" : 0,
        "y_max" : 1,
        "graph_origin" : ORIGIN , # where center of graph will be
        "x_labeled_nums" :range(-4,4,1),
        "x_axis_label" : "$value$",
        "y_axis_label" : "$density$",
        #"x_labeled_nums" : [], # no labels
        
        # rectangle config
        #"default_riemann_start_color": GREEN_E,
        #"default_riemann_end_color": GREEN_A,
        "area_opacity": 0.8,
        "num_rects": 30


    }
    def construct(self):
        self.buildgraph()
        self.show_riemann_sum()
        # text (title + description)
        #title_text=TexMobject(r"\text{The }\text{Satandard Normal}\text{ Distribution}")
        #eq1_text=["4","x","+","3","y","=","0"]
        #eq1_mob=TexMobject(*eq1_text)
    
    def buildgraph(self):
        title_text=TexMobject(r"\text{The }", r"\text{Standard Normal}",r"\text{ Distribution}")
        stdev_text=TextMobject("$\sigma$ = 1")
        stdev_text.set_color(BLUE)
        function_text=TexMobject(r"\frac{1}{\sigma \sqrt{2 \pi}}",r"e^{-\frac{1}{2}\left(\frac{x-\mu}{\sigma}\right)^{2}}")
        function_text.set_color(BLUE)
        
        
        self.add(title_text)
        self.play(ApplyMethod(title_text.shift,2*DOWN))
        title_text.set_color_by_tex("Standard Normal", BLUE)
        self.wait(1)
        self.add(stdev_text)
        self.play(ApplyMethod(stdev_text.shift,3*DOWN))
        self.add(function_text)
        self.wait(2)
        self.play(function_text.shift, 3*RIGHT, 2.5*UP)
        # now build the plot and show it
        self.setup_axes(animate=True) # show axes first
        func_graph = self.get_graph(
            self.function,
            self.function_color,
        )
        
        
        # riemann rectangles
        #graph = self.get_graph(self.function)
        
        #rects = self.get_riemann_rectangles(graph, x_min=-4, x_max=4, dx=0.1)
        
        #self.add(rects)
        #self.play(rects)
        #self.graph = graph
        
        #self.play(ShowCreation(graph))
        
        self.play(
            ShowCreation(func_graph),

        )
    
    # animation to fill with riemann rectangles
    def show_riemann_sum(self):
        #graph = self.get_graph(lambda r : 2*np.pi*r)
        graph = self.get_graph(self.function)
        self.graph = graph
        rects = self.get_riemann_rectangles(graph, x_min=-4, x_max=4, dx=0.1)
        foreground_mobjects = [self.axes, self.graph]
        self.play(
            DrawBorderThenFill(
                rects,
                run_time = 2,
                rate_func = smooth,
                lag_ratio = 0.5,
                stroke_color = BLUE,
            ),
            *list(map(Animation, foreground_mobjects))
        )
    
    """
    # plot lines of stdevs and label them with percent coverage
    def show_stdev():
        lines = self.get_vertical_lines_to_graph(self.graph, x_min = -3, x_max = 3, num_lines=6)
        self.play(
        
        )
        #self, graph,
        #x_min=None,
        #x_max=None,
        #num_lines=20,
        #**kwargs
        
    
    # TODO: later, smooth this out for full fill (perhaps transform_between_riemann_rects)
    
    # TODO: add lines for where the standard devs are, and what percentage coverage it is (perhaps get_vertical_line_to_graph)
    
    #
    """

#TODO: build aninmation of the 95% confidence intervals, or at least 
    
