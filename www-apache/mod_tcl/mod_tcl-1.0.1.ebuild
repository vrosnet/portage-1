# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_tcl/mod_tcl-1.0.1.ebuild,v 1.6 2007/11/25 13:33:16 hollow Exp $

inherit apache-module

KEYWORDS="~amd64 ppc x86"

DESCRIPTION="An Apache2 module providing an embedded Tcl interpreter."
HOMEPAGE="http://tcl.apache.org/mod_tcl/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"

APXS2_ARGS="-c -Wl,-ltcl -DHAVE_TCL_H ${PN}.c tcl_cmds.c tcl_misc.c"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="TCL"

DOCFILES="AUTHORS INSTALL NEWS README test_script.tm"

need_apache2

src_compile() {
	mv -f "tcl_core.c" "${PN}.c"
	apache-module_src_compile
}
