# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uzbl/uzbl-9999.ebuild,v 1.13 2010/03/30 17:56:55 wired Exp $

EAPI="2"

inherit base

IUSE=""
if [[ ${PV} == *9999* ]]; then
	inherit git
	EGIT_REPO_URI=${EGIT_REPO_URI:-"git://github.com/Dieterbe/uzbl.git"}
	SRC_URI=""
	IUSE="experimental"
	use experimental &&
		EGIT_BRANCH="experimental" &&
		EGIT_COMMIT="experimental"
else
	SRC_URI="http://github.com/Dieterbe/${PN}/tarball/${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="Web interface tools which adhere to the unix philosophy."
HOMEPAGE="http://www.uzbl.org"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS=""
IUSE+=" +browser helpers +tabbed vim-syntax"

COMMON_DEPEND="
	>=dev-libs/icu-4.0.1
	>=net-libs/libsoup-2.24
	>=net-libs/webkit-gtk-1.1.15
	>=x11-libs/gtk+-2.14
"

DEPEND="
	>=dev-util/pkgconfig-0.19
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	x11-misc/xdg-utils
	browser? (
		x11-misc/xclip
	)
	helpers? (
		dev-python/pygtk
		dev-python/pygobject
		dev-python/simplejson
		gnome-extra/zenity
		net-misc/socat
		x11-libs/pango
		x11-misc/dmenu
		x11-misc/xclip
	)
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
"
# TODO document what requires the above helpers
# simplejson - save uzbl_tabbed.py sessions & presets in json.

pkg_setup() {
	if ! use helpers; then
		elog "uzbl's extra scripts use various optional applications:"
		elog
		elog "   dev-python/pygtk"
		elog "   dev-python/pygobject"
		elog "   dev-python/simplejson"
		elog "   gnome-extra/zenity"
		elog "   net-misc/socat"
		elog "   x11-libs/pango"
		elog "   x11-misc/dmenu"
		elog "   x11-misc/xclip"
		elog
		elog "Make sure you emerge the ones you need manually."
		elog "You may also activate the *helpers* USE flag to"
		elog "install all of them automatically."
	else
		einfo "You have enabled the *helpers* USE flag that installs"
		einfo "various optional applications used by uzbl's extra scripts."
	fi

	if use tabbed && ! use browser; then
		ewarn
		ewarn "You enabled the *tabbed* USE flag but not *browser*."
		ewarn "*tabbed* depends on *browser*, so it will be disabled."
		ewarn
		ebeep 3
	fi
}

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		git_src_prepare
	else
		cd "${WORKDIR}"/Dieterbe-uzbl-*
		S=$(pwd)
	fi

	# remove -ggdb
	sed -i "s/-ggdb //g" Makefile ||
		die "-ggdb removal sed failed"

	# adjust path in default config file to /usr/share
	sed -i "s:/usr/local/share/uzbl:/usr/share/uzbl:g" \
		examples/config/config ||
		die "config path sed failed"
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	local targets="install-uzbl-core"
	use browser && targets="${targets} install-uzbl-browser"
	use browser && use tabbed && targets="${targets} install-uzbl-tabbed"

	emake DESTDIR="${D}" PREFIX="/usr" DOCDIR="${D}/usr/share/doc/${PF}" ${targets} ||
		die "Installation failed"

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${S}"/extras/vim/ftdetect/uzbl.vim || die "vim-syntax doins failed"

		insinto /usr/share/vim/vimfiles/syntax
		doins "${S}"/extras/vim/syntax/uzbl.vim || die "vim-syntax doins failed"
	fi

}
