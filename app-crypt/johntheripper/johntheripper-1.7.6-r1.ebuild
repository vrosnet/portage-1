# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.7.6-r1.ebuild,v 1.10 2011/02/08 15:12:09 jer Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs pax-utils

MY_PN="john"
MY_P="${MY_PN}-${PV}"

JUMBO="jumbo-4"
#MPI="mpi10"

DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"

SRC_URI="http://www.openwall.com/john/g/${MY_P}.tar.gz
	!minimal? ( http://www.openwall.com/john/contrib/${MY_P}-${JUMBO}.diff.gz )"
#	mpi? ( ftp://ftp.openwall.com/john/contrib/mpi/2009-bindshell/${MY_P}-${MPI}.patch.gz )

LICENSE="GPL-2"
SLOT="0"
# This package can't be marked stable for ppc or ppc64 before bug 327211 is closed.
KEYWORDS="alpha amd64 hppa ~mips ~ppc ~ppc64 sparc x86"
IUSE="altivec custom-cflags -minimal mmx openmp sse2"
#IUSE="altivec custom-cflags -minimal mmx -mpi sse2"

# Seems a bit fussy with other MPI implementations.
RDEPEND="!minimal? ( >=dev-libs/openssl-0.9.7 )"
#	mpi? ( sys-cluster/openmpi )
DEPEND="${RDEPEND}
	openmp? ( >=sys-devel/gcc-4.2[openmp] )"

S="${WORKDIR}/${MY_P}"

get_target() {
	if use x86; then
		if use sse2; then
			echo "linux-x86-sse2"
		elif use mmx; then
			echo "linux-x86-mmx"
		else
			echo "linux-x86-any"
		fi
	elif use alpha; then
		echo "linux-alpha"
	elif use sparc; then
		echo "linux-sparc"
	elif use amd64; then
		echo "linux-x86-64"
	elif use ppc64; then
		if use altivec; then
			echo "linux-ppc32-altivec"
		else
			echo "linux-ppc64"
		fi
		# linux-ppc64-altivec is slightly slower than linux-ppc32-altivec for most hash types.
		# as per the Makefile comments
	elif use ppc; then
		if use altivec; then
			echo "linux-ppc32-altivec"
		else
			echo "linux-ppc32"
		fi
	else
		echo "generic"
	fi
}

src_prepare() {
#	if use mpi; then
#		epatch "${WORKDIR}/${MY_P}-${MPI}.patch"
#	fi
	if ! use minimal; then
		epatch "${WORKDIR}/${MY_P}-${JUMBO}.diff"
	fi
	local PATCHLIST="${PATCHLIST} 1.7.6-cflags 1.7.3.1-mkdir-sandbox"

	cd src
	for p in ${PATCHLIST}; do
		epatch "${FILESDIR}/${PN}-${p}.patch"
	done

	if ! use minimal; then
		sed -e "s/LDFLAGS  *=  */override LDFLAGS += /" -e "/LDFLAGS/s/-s//" \
			-e "/LDFLAGS/s/-L[^ ]*//g" -e "/CFLAGS/s/-[IL][^ ]*//g" \
			-i Makefile || die "sed Makefile failed"
	fi
}

src_compile() {
	local OMP=''

	use custom-cflags || strip-flags
	echo '#define JOHN_SYSTEMWIDE 1' >> config.gentoo
	echo '#define JOHN_SYSTEMWIDE_HOME "/etc/john"' >> config.gentoo
	echo '#define JOHN_SYSTEMWIDE_EXEC "/usr/libexec/john"' >> config.gentoo
	append-flags -fPIC -fPIE -include "${S}"/config.gentoo
	gcc-specs-pie && append-ldflags -nopie
	use openmp && OMP="-fopenmp"

	CPP=$(tc-getCXX) CC=$(tc-getCC) AS=$(tc-getCC) LD=$(tc-getCC)
#	use mpi && CPP=mpicxx CC=mpicc AS=mpicc LD=mpicc
	emake -C src/ \
		CPP=${CPP} CC=${CC} AS=${AS} LD=${LD} \
		CFLAGS="-c -Wall ${CFLAGS} ${OMP}" \
		LDFLAGS="${LDFLAGS}" \
		OPT_NORMAL="" \
		OMPFLAGS="${OMP}" \
		$(get_target) || die "emake failed"
}

src_test() {
	cd run
	if [[ -f "/etc/john/john.conf" || -f "/etc/john/john.ini" ]]; then
		# This requires that MPI is actually 100% online on your system, which might not
		# be the case, depending on which MPI implementation you are using.
		#if use mpi; then
		#	mpirun -np 2 ./john --test || die 'self test failed'
		#else

		./john --test || die 'self test failed'
	else
		ewarn "selftest requires /etc/john/john.conf or /etc/john/john.ini"
	fi
}

src_install() {
	# executables
	dosbin run/john || die
	newsbin run/mailer john-mailer || die

	pax-mark -m "${D}"/usr/sbin/john || die

	dosym john /usr/sbin/unafs || die
	dosym john /usr/sbin/unique || die
	dosym john /usr/sbin/unshadow || die

	# jumbo-patch additions
	if ! use minimal; then
		dosym john /usr/sbin/undrop || die
		dosbin run/calc_stat || die
		dosbin run/genmkvpwd || die
		dosbin run/mkvcalcproba || die
		insinto /etc/john
		doins run/genincstats.rb run/stats || die
		doins run/netscreen.py run/sap_prepare.pl || die
	fi

	# config files
	insinto /etc/john
	doins run/john.conf || die
	doins run/*.chr run/password.lst || die

	# documentation
	dodoc doc/* || die
}
