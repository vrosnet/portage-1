# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-sql/tcl-sql-20000114-r1.ebuild,v 1.2 2010/12/07 18:59:04 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="A generic Tcl interface to SQL databases."
HOMEPAGE="http://www.parand.com/tcl-sql/"
SRC_URI="mirror://sourceforge/tcl-sql/${PN}-${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND="
	dev-lang/tcl
	virtual/mysql"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	find . -type f -exec chmod 644 '{}' \; || die
	epatch \
		"${FILESDIR}"/fix-const.patch \
		"${FILESDIR}"/ldflags.patch
	tc-export CXX
}

src_install() {
	dolib.so sql.so || die
	dodoc CHANGES.txt CODE_DESCRIPTION.txt docs/sample.full.txt docs/sample.simple.txt || die
	dohtml README.html docs/api.html || die
}
