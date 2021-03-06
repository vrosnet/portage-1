# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-apcupsd/selinux-apcupsd-2.20120215.ebuild,v 1.3 2012/06/04 19:48:34 swift Exp $
EAPI="4"

IUSE=""
MODS="apcupsd"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for apcupsd"

KEYWORDS="amd64 x86"
DEPEND=">=sec-policy/selinux-apache-2.20120215"
RDEPEND="${DEPEND}"
