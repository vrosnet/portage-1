# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/simpletest/simpletest-1.1.0.ebuild,v 1.1 2012/01/28 14:08:49 mabi Exp $

EAPI=4

KEYWORDS="~amd64 ~x86"

DESCRIPTION="A PHP testing framework."
HOMEPAGE="http://www.lastcraft.com/simple_test.php"
SRC_URI="mirror://sourceforge/simpletest/${PN}_${PV/_/}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/php"

S="${WORKDIR}/${PN}"

src_install() {
	dodoc [[:upper:]]* && rm -f [[:upper:]]*
	dodoc -r docs/ && rm -rf docs/

	insinto "/usr/share/php/${PN}"
	doins -r .
}
