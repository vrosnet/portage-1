# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jebl/jebl-0.5.3.ebuild,v 1.2 2009/10/25 18:39:23 weaver Exp $

EAPI="2"

#ESVN_REPO_URI="https://jebl.svn.sourceforge.net/svnroot/jebl/trunk/jebl"
#ESVN_REPO_URI="https://jebl.svn.sourceforge.net/svnroot/jebl/tags/${P//./_}"

JAVA_PKG_IUSE="doc"
EANT_BUILD_TARGET="dist"
EANT_DOC_TARGET="document"

#inherit subversion java-pkg-2 java-ant-2
inherit java-pkg-2 java-ant-2

DESCRIPTION="Java Evolutionary Biology Library"
HOMEPAGE="http://jebl.sourceforge.net/"
#SRC_URI=""
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}/${P//./_}"

java_prepare() {
	rm -rf "${S}/src/org/virion/jam/maconly" || die
}

src_install() {
	java-pkg_dojar dist/jebl.jar || die
	java-pkg_dojar dist/jam.jar || die
	use doc && java-pkg_dojavadoc doc/api
}
