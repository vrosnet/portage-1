# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-2.5.1.ebuild,v 1.1 2012/02/28 02:27:15 radhermit Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="https://github.com/downloads/lefcha/imapfilter/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-libs/libpcre
	>=dev-lang/lua-5.1"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "/^PREFIX/s:/local::" \
		-e "/^MANDIR/s:man:share/man:" \
		-e "/^CFLAGS/s:CFLAGS =:CFLAGS +=:" \
		-e "/^CFLAGS/s/-O//" \
		src/Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README samples/*
	doman doc/imapfilter.1 doc/imapfilter_config.5
}
