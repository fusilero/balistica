/* gnuplot.vapi
 *
 * Copyright (C) 2014 Steven Oliver
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 *	Steven Oliver <oliver.steven@gmail.com>
 */

namespace Gnuplot {
        [CCode (cheader_filename = "version.h", cname = "gnuplot_version")]
        public const char GnuplotVersion;

        [CCode (cheader_filename = "version.h", cname = "gnuplot_patchlevel")]
        public const char GnuplotPatchLevel;

        [CCode (cheader_filename = "version.h", cname = "gnuplot_date")]
        public const char GnuplotDate;

        [CCode (cheader_filename = "version.h", cname = "gnuplot_copyright")]
        public const char GnuplotCopyright;

        [CCode (cheader_filename = "gp_types.h", cname = "DATA_TYPES", cprefix = "DATA_TYPE_", has_type_id = false)]
        public enum DataTypes {
                INTGR,
                CMPLX,
                STRING
        }

        [CCode (cheader_filename = "gp_types.h", cname = "MODE_PLOT_TYPE", cprefix = "MODE_PLOT_TYPE_", has_type_id = false)]
        public enum ModePlotTypes {
                QUERY,
                PLOT,
                SPLOT
        }


        [CCode (cheader_filename = "gp_types.h", cname = "PLOT_TYPE", cprefix = "PLOT_TYPE_", has_type_id = false)]
        public enum PlotTypes {
                FUNC,
                DATA,
                FUNC3D,
                DATA3D,
                NODATA
        }


        [CCode (cheader_filename = "gp_types.h", cname = "e_PLOT_STYLE_FLAGS", cprefix = "PLOT_STYLE_", has_type_id = false)]
        [Flags]
        public enum PlotStyleFlags {
                HAS_LINE,
                HAS_POINT,
                HAS_ERRORBAR,
                HAS_FILL,
                BITS
        }

        [CCode (cheader_filename = "gp_types.h", cname = "PLOT_STYLE", cprefix = "PLOT_STYLE_", has_type_id = false)]
        public enum PlotStyle {
                LINES,
                POINTSTYLE,
                IMPULSES,
                LINESPOINTS,
                DOTS,
                XERRORBARS,
                YERRORBARS,
                XYERRORBARS,
                BOXXYERROR,
                BOXES,
                BOXERROR,
                STEPS,
                FILLSTEPS,
                FSTEPS,
                HISTEPS,
                VECTOR,
                CANDLESTICKS,
                FINANCEBARS,
                XERRORLINES,
                YERRORLINES,
                XYERRORLINES,
                FILLEDCURVES,
                PM3DSURFACE,
                LABELPOINTS,
                HISTOGRAMS,
                IMAGE,
                RGBIMAGE,
                RGBA_IMAGE,
                CIRCLES,
                BOXPLOT,
                ELLIPSES
        }

        [CCode (cheader_filename = "gp_types.h", cname = "PLOT_SMOOTH", cprefix = "PLOT_SMOOTH_", has_type_id = false)]
        public enum PlotSmooth {
                NONE,
                ACSPLINES,
                BEZIER,
                CSPLINES,
                SBEZIER,
                UNIQUE,
                UNWRAP,
                FREQUENCY,
                CUMULATIVE,
                KDENSITY,
                CUMULATIVE_NORMALISED,
                MONOTONE_CSPLINE
        }

        [CCode (cheader_filename = "gp_types.h", cname = "CMPLX")]
        public struct cmplx {
                public double real;
                public double imag;
        }


        [CCode (cheader_filename = "gp_types.h", cname = "COORD_TYPE", cprefix = "COORD_TYPE_", has_type_id = false)]
        public enum CoordinateType {
                INRANGE,
                OUTRANGE,
                UNDEFINED
        }

        [CCode (cheader_filename = "gp_types.h", cname = "COORDINATE")]
        public struct Coordinate {
                [CCode (cname = "COORD_TYPE")]
                public enum CoordinateType type;

                public unowned CoordValue x;
                public unowned CoordValue y;
                public unowned CoordValue z;
                public unowned CoordValue ylow;
                public unowned CoordValue yhigh;
                public unowned CoordValue xlow;
                public unowned CoordValue xhigh;
        }

}
