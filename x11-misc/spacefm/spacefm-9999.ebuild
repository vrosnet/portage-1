# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/spacefm/spacefm-9999.ebuild,v 1.7 2012/07/25 17:40:53 hasufell Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/IgnorantGuru/${PN}.git"
EGIT_BRANCH="next"

inherit fdo-mime git-2 gnome2-utils linux-info

DESCRIPTION="A multi-panel tabbed file manager"
HOMEPAGE="http://ignorantguru.github.com/spacefm/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-util/desktop-file-utils
	sys-apps/dbus
	>=sys-fs/udev-143
	virtual/freedesktop-icon-theme
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango
	x11-libs/startup-notification
	x11-misc/shared-mime-info"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--htmldir=/usr/share/doc/${PF}/html \
		--disable-hal \
		--enable-inotify \
		--disable-pixmaps
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update

	einfo
	elog "To mount as non-root user you need one of the following:"
	elog "  sys-apps/udevil (recommended, see below)"
	elog "  sys-apps/pmount"
	elog "  sys-fs/udisks:0"
	elog "  sys-fs/udisks:2"
	elog "To support ftp/nfs/smb/ssh URLs in the path bar you need:"
	elog "  sys-apps/udevil"
	elog "To perform as root functionality you need one of the following:"
	elog "  x11-misc/ktsuss"
	elog "  x11-libs/gksu"
	elog "  kde-base/kdesu"
	elog "Other optional dependencies:"
	elog "  sys-process/lsof (device processes)"
	elog "  virtual/eject (eject media)"
	einfo
	if ! has_version 'sys-fs/udisks' ; then
		elog "When using SpaceFM without udisks, and without the udisks-daemon running,"
		elog "you may need to enable kernel polling for device media changes to be detected."
		elog "See /usr/share/doc/${PF}/html/spacefm-manual-en.html#devices-kernpoll"
		has_version '<sys-fs/udev-173' && ewarn "You need at least udev-173"
		kernel_is lt 2 6 38 && ewarn "You need at least kernel 2.6.38"
		einfo
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
