# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-1.1.6-r1.ebuild,v 1.3 2009/08/25 02:43:17 vapier Exp $

EAPI="1"

inherit eutils flag-o-matic multilib

DESCRIPTION="NFS client and server daemons"
HOMEPAGE="http://linux-nfs.org/"
SRC_URI="mirror://sourceforge/nfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="ipv6 kerberos +nfsv3 +nfsv4 tcpd"

# kth-krb doesn't provide the right include
# files, and nfs-utils doesn't build against heimdal either,
# so don't depend on virtual/krb.
# (04 Feb 2005 agriffis)
RDEPEND="tcpd? ( sys-apps/tcp-wrappers )
	sys-libs/e2fsprogs-libs
	!net-nds/portmap
	net-nds/rpcbind
	net-libs/libtirpc
	nfsv4? (
		>=dev-libs/libevent-1.0b
		>=net-libs/libnfsidmap-0.21-r1
		kerberos? (
			net-libs/librpcsecgss
			net-libs/libgssglue
			app-crypt/mit-krb5
		)
	)"
# util-linux dep is to prevent man-page collision
DEPEND="${RDEPEND}
	>=sys-apps/util-linux-2.12r-r7"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.1.4-rpcgen-ioctl.patch
	epatch "${FILESDIR}"/${PN}-1.1.4-ascii-man.patch
	epatch "${FILESDIR}"/${PN}-1.1.4-mtab-sym.patch
	epatch "${FILESDIR}"/${PN}-1.1.4-no-exec.patch
}

src_compile() {
	econf \
		--with-statedir=/var/lib/nfs \
		--enable-tirpc \
		$(use_with tcpd tcp-wrappers) \
		$(use_enable nfsv3) \
		$(use_enable nfsv4) \
		$(use_enable ipv6) \
		$(use nfsv4 && use_enable kerberos gss || echo "--disable-gss")
	emake || die "Failed to compile"
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Don't overwrite existing xtab/etab, install the original
	# versions somewhere safe...  more info in pkg_postinst
	dodir /usr/lib/nfs
	keepdir /var/lib/nfs/{sm,sm.bak}
	mv "${D}"/var/lib/nfs/* "${D}"/usr/lib/nfs
	keepdir /var/lib/nfs

	# Install some client-side binaries in /sbin
	dodir /sbin
	mv "${D}"/usr/sbin/rpc.statd "${D}"/sbin/ || die

	dodoc ChangeLog README
	docinto linux-nfs ; dodoc linux-nfs/*

	insinto /etc
	doins "${FILESDIR}"/exports

	local f list="" opt_need=""
	if use nfsv4 ; then
		opt_need="rpc.idmapd"
		list="${list} rpc.idmapd rpc.pipefs"
		use kerberos && list="${list} rpc.gssd rpc.svcgssd"
	fi
	for f in nfs nfsmount rpc.statd ${list} ; do
		newinitd "${FILESDIR}"/${f}.initd ${f} || die "doinitd ${f}"
	done
	newconfd "${FILESDIR}"/nfs.confd nfs
	dosed "/^NFS_NEEDED_SERVICES=/s:=.*:=\"${opt_need}\":" /etc/conf.d/nfs #234132

	# uClibc doesn't provide rpcgen like glibc, so lets steal it from nfs-utils
	if ! use elibc_glibc ; then
		dobin tools/rpcgen/rpcgen || die "rpcgen"
		newdoc tools/rpcgen/README README.rpcgen
	fi
}

pkg_postinst() {
	# Install default xtab and friends if there's none existing.
	# In src_install we put them in /usr/lib/nfs for safe-keeping, but
	# the daemons actually use the files in /var/lib/nfs.  This fixes
	# bug 30486
	local f
	for f in "${ROOT}"/usr/$(get_libdir)/nfs/*; do
		[[ -e ${ROOT}/var/lib/nfs/${f##*/} ]] && continue
		einfo "Copying default ${f##*/} from /usr/$(get_libdir)/nfs to /var/lib/nfs"
		cp -pPR "${f}" "${ROOT}"/var/lib/nfs/
	done
}
