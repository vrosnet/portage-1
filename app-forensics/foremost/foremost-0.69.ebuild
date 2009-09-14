# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/foremost/foremost-0.69.ebuild,v 1.4 2009/09/13 22:33:55 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="A console program to recover files based on their headers and footers"
HOMEPAGE="http://foremost.sourceforge.net/"
SRC_URI="http://foremost.sourceforge.net/pkg/${P}.tar.gz"

KEYWORDS="x86 ppc"
IUSE=""
LICENSE="public-domain"
SLOT="0"

src_compile() {
	emake CC_OPTS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin foremost || die "dobin failed"
	doman foremost.1
	dodoc foremost.conf README CHANGES TODO
}
