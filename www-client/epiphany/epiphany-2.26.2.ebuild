# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-2.26.2.ebuild,v 1.1 2009/05/18 21:40:47 eva Exp $

EAPI="2"

inherit gnome2 eutils multilib autotools

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="avahi doc networkmanager python spell"

RDEPEND=">=dev-libs/glib-2.18.0
	>=x11-libs/gtk+-2.16.0
	>=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/libglade-2.3.1
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/gnome-desktop-2.9.91
	>=x11-libs/startup-notification-0.5
	>=x11-libs/libnotify-0.4
	>=media-libs/libcanberra-0.3[gtk]
	>=dev-libs/dbus-glib-0.71
	>=gnome-base/gconf-2
	>=app-text/iso-codes-0.35
	avahi? ( >=net-dns/avahi-0.6.22 )
	networkmanager? ( net-misc/networkmanager )
	=net-libs/xulrunner-1.9*
	python? (
		>=dev-lang/python-2.3
		>=dev-python/pygtk-2.7.1
		>=dev-python/gnome-python-2.6 )
	spell? ( app-text/enchant )
	x11-themes/gnome-icon-theme"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40
	>=app-text/gnome-doc-utils-0.3.2
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--with-gecko=libxul-embedding
		--enable-certificate-manager
		--with-distributor-name=Gentoo
		--enable-canberra
		$(use_enable avahi zeroconf)
		$(use_enable networkmanager network-manager)
		$(use_enable spell spell-checker)
		$(use_enable python)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix compilation with xulrunner 1.9.1, bug #263990
	epatch "${FILESDIR}/${PN}-2.26.0-xulrunner191.patch"

	# Fix libcanberra automagic support, bug #266232
	epatch "${FILESDIR}/${PN}-2.26.1-automagic-libcanberra.patch"

	# Make it libtool-1 compatible
	rm -v m4/lt* m4/libtool.m4 || die "removing libtool macros failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	addpredict /usr/$(get_libdir)/xulrunner-1.9/components/xpti.dat
	addpredict /usr/$(get_libdir)/xulrunner-1.9/components/xpti.dat.tmp
	addpredict /usr/$(get_libdir)/xulrunner-1.9/components/compreg.dat.tmp

	# Why are these write-opened per bug #228589 and bug #253043
	addpredict /usr/$(get_libdir)/mozilla/components/xpti.dat
	addpredict /usr/$(get_libdir)/mozilla/components/xpti.dat.tmp
	addpredict /usr/$(get_libdir)/mozilla/components/compreg.dat.tmp

	gnome2_src_configure
}