# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn-security/prawn-security-0.8.4-r1.ebuild,v 1.5 2012/07/11 14:48:02 nativemad Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby ruby19"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Popular Password Protection & Permissions for Prawn PDFs"
HOMEPAGE="http://prawn.majesticseacreature.com/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="examples"

ruby_add_bdepend "test? ( dev-ruby/test-spec dev-ruby/mocha )"

ruby_add_rdepend ">=dev-ruby/prawn-core-${PV}"

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
