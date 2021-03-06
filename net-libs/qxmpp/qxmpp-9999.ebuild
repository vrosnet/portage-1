# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/qxmpp/qxmpp-9999.ebuild,v 1.2 2012/07/15 16:52:03 kensington Exp $

EAPI=3

ESVN_REPO_URI="http://qxmpp.googlecode.com/svn/trunk/"
EGIT_REPO_URI="git://github.com/0xd34df00d/qxmpp-dev.git"

inherit qt4-r2 multilib subversion git-2

DESCRIPTION="A cross-platform C++ XMPP client library based on the Qt framework."
HOMEPAGE="http://code.google.com/p/qxmpp/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug +extras"

DEPEND="x11-libs/qt-core:4
		x11-libs/qt-gui:4
		media-libs/speex"
RDEPEND="${DEPEND}"

src_unpack(){
	if ! use extras; then
		subversion_src_unpack
	else
		git-2_src_unpack
	fi
}

src_prepare(){
	if ! use extras; then
		subversion_src_prepare
	fi
}

src_configure(){
	eqmake4 "${S}"/qxmpp.pro "PREFIX=/usr" "LIBDIR=$(get_libdir)"
}
