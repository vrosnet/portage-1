# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libcmis/libcmis-0.2.3.ebuild,v 1.3 2012/08/09 08:27:31 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://gitorious.org/libcmis/libcmis.git"
[[ ${PV} == 9999 ]] && SCM_ECLASS="git-2"
inherit eutils autotools ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="C++ client library for the CMIS interface"
HOMEPAGE="https://sourceforge.net/projects/libcmis/"
[[ ${PV} == 9999 ]] || SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 MPL-1.1 )"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs man test"

RDEPEND="
	dev-libs/boost
	dev-libs/libxml2
	net-misc/curl
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	man? ( app-text/docbook2X )
	test? ( dev-util/cppunit )
"

# It fetches the apache chemistry webapp and then try to run some magic on it
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/libcmis-0.2.3-do-not-override-phases.patch"
	eautoreconf
}

src_configure() {
	econf \
		--disable-werror \
		$(use_with man) \
		$(use_enable static-libs static) \
		$(use_enable test tests) \
		--enable-client
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
