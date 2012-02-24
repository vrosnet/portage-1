# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-clean/namespace-clean-0.210.0.ebuild,v 1.3 2012/02/24 10:54:09 ago Exp $

EAPI=4

MODULE_AUTHOR=RIBASUSHI
MODULE_VERSION=0.21
inherit perl-module

DESCRIPTION="Keep imports and functions out of your namespace"

SLOT="0"
KEYWORDS="amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND=">=dev-perl/Package-Stash-0.220"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( >=virtual/perl-Test-Simple-0.88 )"

SRC_TEST=do
