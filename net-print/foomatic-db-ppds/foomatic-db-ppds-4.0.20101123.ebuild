# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-ppds/foomatic-db-ppds-4.0.20101123.ebuild,v 1.2 2011/05/06 16:17:46 jlec Exp $

EAPI=4

inherit eutils versionator

MY_P=${PN/-ppds}-$(replace_version_separator 2 '-')

DESCRIPTION="linuxprinting.org PPD files for postscript printers"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${MY_P}.tar.gz
	http://linuxprinting.org/download/foomatic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${PN/-ppds}-$(get_version_component_range 3 ${PV})"

src_prepare() {
	epatch "${FILESDIR}/Makefile.in-20070508.patch"
	# scripts do not belong to this package, no translated ppds, no html and text files
	rm -r "${S}"/db/source/PPD/Kyocera/{de,es,fr,it,pt,*.htm,*.txt}
}
