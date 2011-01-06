# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg2/ekg2-0.3.0_rc4.ebuild,v 1.2 2011/01/06 20:15:41 mgorny Exp $

EAPI=3
inherit autotools-utils versionator

MY_P=${PN}-$(replace_version_separator _ -)
DESCRIPTION="Text-based, multi-protocol instant messenger"
HOMEPAGE="http://www.ekg2.org"
SRC_URI="http://pl.ekg2.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="expat gadu gif gnutls gpg gpm gsm gtk idn inotify jpeg ncurses nls
	oracle perl python readline spell sqlite sqlite3 ssl threads unicode
	xosd zlib"

RDEPEND="
	gpg? ( app-crypt/gpgme )
	gsm? ( media-sound/gsm )
	gtk? ( x11-libs/gtk+:2 )
	idn? ( net-dns/libidn )
	nls? ( virtual/libintl )
	oracle?	( dev-db/oracle-instantclient-basic )
	perl? ( dev-lang/perl )
	python?	( dev-lang/python )
	readline? ( sys-libs/readline )
	ssl? ( dev-libs/openssl )
	xosd? ( x11-libs/xosd )
	zlib? ( sys-libs/zlib )

	gadu? ( net-libs/libgadu
		gif? ( media-libs/giflib )
		jpeg? ( media-libs/jpeg ) )
	expat? ( dev-libs/expat
		gnutls? ( net-libs/gnutls ) )
	ncurses? ( sys-libs/ncurses[unicode?]
		gpm? ( sys-libs/gpm )
		spell? ( app-text/aspell ) )
	sqlite3? ( dev-db/sqlite:3 )
	!sqlite3? ( sqlite? ( dev-db/sqlite:0 ) )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

DOCS=(
	AUTHORS docs/README docs/TODO
	docs/events.txt docs/mouse.txt docs/sim.txt docs/voip.txt
	docs/themes.txt docs/themes-en.txt
	docs/ui-ncurses.txt docs/ui-ncurses-en.txt
)

S=${WORKDIR}/${MY_P}
AUTOTOOLS_IN_SOURCE_BUILD=1

pkg_setup() {
	if ! use gtk && ! use ncurses && ! use readline; then
		ewarn 'ekg2 is being compiled without any frontend, you should consider'
		ewarn 'enabling at least one of following USEflags:'
		ewarn '  gtk, ncurses, readline.'
	fi

	if use gnutls && ! use ssl; then
		ewarn 'You have enabled USE=gnutls without USE=ssl. The SSL support'
		ewarn 'in ekg2 will be limited to the plugins supporting GnuTLS.'
	fi
}

src_configure() {
	myeconfargs=(
		$(use_with expat)
		$(use_with gadu libgadu)
		$(use_with gif)
		$(use_with gnutls libgnutls)
		$(use_with gpg)
		$(use_with gpm gpm-mouse)
		$(use_with gsm libgsm)
		$(use_with gtk)
		$(use_with idn libidn)
		$(use_with inotify)
		$(use_with jpeg libjpeg)
		$(use_with ncurses)
		$(use_with oracle logsoracle)
		$(use_with perl)
		$(use_with python)
		$(use_with readline)
		$(use_with spell aspell)
		$(use_with sqlite)
		$(use_with sqlite3)
		$(use_with ssl openssl)
		$(use_with threads pthread)
		$(use_with xosd libxosd)
		$(use_with zlib)
		$(use_enable nls)
		$(use_enable unicode)
		--without-ioctld
		--disable-remote
		--enable-skip-relative-plugins-dir
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	remove_libtool_files all
}
