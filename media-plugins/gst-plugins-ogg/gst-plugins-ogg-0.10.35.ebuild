# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.35.ebuild,v 1.5 2011/10/09 15:58:29 armin76 Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libogg-1.0"
DEPEND="${RDEPEND}"
