# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkolabxml/libkolabxml-0.8.0.ebuild,v 1.1 2012/08/10 16:35:18 creffett Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Kolab XML format schema definitions library"
HOMEPAGE="http://www.kolab.org"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="csharp java python php test"

RDEPEND="
	dev-cpp/xsd
	|| ( >=dev-libs/boost-1.42.0 ( <dev-libs/boost-1.42.0 dev-libs/ossp-uuid ) )
	dev-libs/xerces-c
"
DEPEND="
	${RDEPEND}
	csharp? ( >=dev-lang/swig-2.0.7 dev-lang/mono )
	java? ( >=dev-lang/swig-2.0.7 virtual/jre )
	php? ( >=dev-lang/swig-2.0.7 dev-lang/php )
	python? ( >=dev-lang/swig-2.0.7 dev-lang/python )
	test? ( x11-libs/qt-test:4 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use csharp CSHARP_BINDINGS)
		$(cmake-utils_use java JAVA_BINDINGS)
		$(cmake-utils_use python PYTHON_BINDINGS)
		$(cmake-utils_use php PHP_BINDINGS)
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
