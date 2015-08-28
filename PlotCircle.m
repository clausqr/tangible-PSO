
function h = PlotCircle(center, radius, width, color)

z = radius*exp((0:2*pi/24:2*pi)*1i);
h = plot(center(1)+real(z), center(2)+imag(z), 'LineWidth', width, 'Color', color);
