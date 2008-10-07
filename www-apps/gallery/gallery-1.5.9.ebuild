# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gallery/gallery-1.5.9.ebuild,v 1.5 2008/10/06 20:18:00 maekke Exp $

inherit webapp depend.php confutils

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="imagemagick netpbm unzip zip"

RDEPEND="media-libs/jpeg
	imagemagick? ( >=media-gfx/imagemagick-5.4.9.1-r1 )
	netpbm? ( >=media-libs/netpbm-9.12 >=media-gfx/jhead-2.2 )
	unzip? ( app-arch/unzip )
	zip? ( app-arch/zip )"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	confutils_require_any imagemagick netpbm
	require_php_with_use pcre session
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	gunzip ChangeLog.archive.gz
}

src_install() {
	webapp_src_preinst

	dodoc AUTHORS ChangeLog ChangeLog.archive README
	dohtml docs/*

	cp -r . "${D}/${MY_HTDOCSDIR}"
	rm -rf "${D}/${MY_HTDOCSDIR}"/{AUTHORS,ChangeLog,ChangeLog.archive,README,LICENSE.txt,docs/}

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
