# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/prime/prime-1.0.0.1.ebuild,v 1.14 2010/01/23 10:18:30 matsuu Exp $

inherit ruby

DESCRIPTION="Japanese PRedictive Input Method Editor"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=app-dicts/prime-dict-1.0.0
	>=dev-libs/suikyo-2.1.0"
RDEPEND="${DEPEND}
	dev-ruby/ruby-progressbar
	dev-ruby/sary-ruby"

S="${WORKDIR}/${P/_/-}"

RUBY_ECONF="--with-prime-docdir=/usr/share/doc/${PF}/html
	--with-rubydir=/usr/lib/ruby/site_ruby"

src_compile() {
	ruby_src_compile -j1
}

src_install() {
	emake DESTDIR="${D}" install install-etc || die

	dodoc AUTHORS ChangeLog NEWS README TODO || die
	dohtml -r doc/* || die
}
