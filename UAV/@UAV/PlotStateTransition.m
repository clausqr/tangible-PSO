function PlotStateTransition(varargin)

u = varargin{1};
v = varargin{2};

if nargin >2
    e = varargin{3};
    color = varargin{4};
    width = varargin{5};
    
    line([u(1) v(1)], [u(2) v(2)], 'Color', color, 'LineWidth', width)
else
line([u(1) v(1)], [u(2) v(2)])
end



