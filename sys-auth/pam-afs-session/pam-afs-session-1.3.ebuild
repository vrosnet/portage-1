# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam-afs-session/pam-afs-session-1.3.ebuild,v 1.2 2007/07/15 02:34:06 mr_bones_ Exp $

inherit pam

DESCRIPTION="OpenAFS PAM Module"
HOMEPAGE="http://www.eyrie.org/~eagle/software/pam-afs-session/"
SRC_URI="http://archives.eyrie.org/software/afs/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/krb5 virtual/pam"
RDEPEND="${DEPEND}"

src_compile() {
	econf --with-kerberos || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dopammod pam_afs_session.so
	doman pam_afs_session.5
	dodoc CHANGES NEWS README TODO
}
