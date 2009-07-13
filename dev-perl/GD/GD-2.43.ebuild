# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.43.ebuild,v 1.1 2009/06/12 07:37:51 tove Exp $

EAPI=2

MODULE_AUTHOR=LDS
inherit perl-module

DESCRIPTION="interface to Thomas Boutell's gd library"

LICENSE="|| ( Artistic-2 GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="animgif gif jpeg png truetype xpm"

DEPEND=">=media-libs/gd-2.0.33
	png? (
		media-libs/gd[png]
		media-libs/libpng
		sys-libs/zlib
	)
	jpeg? (
		media-libs/gd[jpeg]
		media-libs/jpeg
	)
	truetype? (
		media-libs/gd[truetype]
		media-libs/freetype:2
	)
	xpm? (
		media-libs/gd[xpm]
		x11-libs/libXpm
	)
	gif? ( media-libs/giflib )"

	SRC_TEST=do

src_prepare(){
	perl-module_src_prepare
	sed -i "s/use Getopt::Long;/use Getopt::Long qw(:config pass_through);/" \
		"${S}"/Makefile.PL || die
}
src_configure() {
	myconf=""
	use gif && use animgif && myconf="${myconf},ANIMGIF"
	use jpeg && myconf="${myconf},JPEG"
	use truetype && myconf="${myconf},FREETYPE"
	use png && myconf="${myconf},PNG"
	use xpm && myconf="${myconf},XPM"
	use gif && myconf="${myconf},GIF"
	myconf="-options \"${myconf:1}\""
	perl-module_src_configure
}

mydoc="GD.html"