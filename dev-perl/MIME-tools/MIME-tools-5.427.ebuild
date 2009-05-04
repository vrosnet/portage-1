# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-5.427.ebuild,v 1.6 2009/05/03 17:59:37 maekke Exp $

MODULE_AUTHOR=DONEILL
inherit perl-module

DESCRIPTION="A Perl module for parsing and creating MIME entities"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~s390 ~sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/IO-stringy-2.108
	>=virtual/perl-MIME-Base64-3.05
	virtual/perl-libnet
	dev-perl/URI
	virtual/perl-Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/MailTools
	virtual/perl-File-Temp
	dev-lang/perl"
