# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-1.2.0-r2.ebuild,v 1.10 2012/05/04 18:47:54 jdhore Exp $

EAPI="2"
# jruby: mkmf issue
USE_RUBY="ruby18 ree18"
inherit ruby-ng

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.sourceforge.net/"
SRC_URI="http://sary.sourceforge.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
SLOT="0"
IUSE=""

RDEPEND=">=app-text/sary-1.2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RUBY_PATCHES=(
	"${P}-gentoo.patch"
	"${P}-ruby19.patch"
)

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	# We have injected --no-undefined in Ruby as a safety precaution
	# against broken ebuilds, but the Ruby-Gnome bindings
	# unfortunately rely on the lazy load of other extensions; see bug
	# #320545.
	find . -name Makefile -print0 | xargs -0 \
		sed -i -e 's:-Wl,--no-undefined ::' || die "--no-undefined removal failed"

	emake || die "emake failed"
}

each_ruby_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

all_ruby_install() {
	dodoc ChangeLog *.rd || die
}
