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
        [CCode (cname = "gnuplot_version")]
        public const char GnuplotVersion;

        [CCode (cname = "gnuplot_patchlevel")]
        public const char GnuplotPatchLevel;

        [CCode (cname = "gnuplot_date")]
        public const char GnuplotDate;

        [CCode (cname = "gnuplot_copyright")]
        public const char GnuplotCopyright;
}
