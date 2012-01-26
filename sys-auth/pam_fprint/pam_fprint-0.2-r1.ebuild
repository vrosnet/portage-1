# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_fprint/pam_fprint-0.2-r1.ebuild,v 1.2 2012/01/26 14:48:14 tomka Exp $

EAPI=3

inherit eutils pam

DESCRIPTION="a simple PAM module which uses libfprint's functionality for authentication"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Pam_fprint"
SRC_URI="mirror://sourceforge/fprint/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-auth/libfprint
	sys-libs/pam"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-headers.patch
}

src_install() {
	dopammod src/${PN}.so || die
	newbin src/pamtest pamtest.fprint || die
	dobin src/pam_fprint_enroll || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
