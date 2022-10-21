Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BB7C38A2D
	for <linux-modules@archiver.kernel.org>; Fri, 21 Oct 2022 21:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJUVf1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJUVfZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 21 Oct 2022 17:35:25 -0400
X-Greylist: delayed 469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 14:35:19 PDT
Received: from attila.bofh.it (attila.bofh.it [85.94.204.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089A127BDB
        for <linux-modules@vger.kernel.org>; Fri, 21 Oct 2022 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1666387645; h=date : from : to :
 subject : message-id : mime-version : content-type : from;
 bh=JlojR6UCN1XqWGnG6zWQNzbtrCmUI3vi47C9+ErwUJM=;
 b=iIHNVI/lUpVFrKUMThDGpaYr8FOzKB/imDgUwUvavRdUsAWvHahM6C+UEOg60zxM0kADK
 PbndW2LIAF04kapfv0htDWKdyeGo6wt299lpXUzHM1PjvyefBbKDPTentq+sRgtg8nlK32h
 DaQN8SrN3LZUbGioBMkEL1o26hIA5BM=
Received: by attila.bofh.it (Postfix, from userid 10)
        id 8145917C08C8; Fri, 21 Oct 2022 23:27:25 +0200 (CEST)
Received: by bongo.bofh.it (Postfix, from userid 1000)
        id 96F14529918; Fri, 21 Oct 2022 23:27:07 +0200 (CEST)
Date:   Fri, 21 Oct 2022 23:27:07 +0200
From:   Marco d'Itri <md@linux.it>
To:     linux-modules@vger.kernel.org
Subject: semantics of --ignore-install
Message-ID: <Y1MOq6VZQRFT3Uib@bongo.bofh.it>
Mail-Followup-To: linux-modules@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xDC5ayWp294bP9Gj"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--xDC5ayWp294bP9Gj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bug or feature?

diff -U 0 \
  <(modprobe -q --show-depends nfs) \
  <(modprobe -q --show-depends nfs --ignore-install)

----- Forwarded message from Andras Korn <korn-debbugs@elan.rulez.org> -----

=46rom: Andras Korn <korn-debbugs@elan.rulez.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#1022172: /lib/modprobe.d/50-nfs.conf causes initramfs-tools to
	stop including sunrpc module for nfs

Package: kmod
Version: 30+20220905-1
Severity: important

Hi,

I noticed that the sunrpc module was strangely absent from my initramfs, wh=
ich resulted in a failure to netboot (which is my justification for the sev=
erity).

Upon examination, it turns out that the way module dependencies are worked =
out for initramfs generation depend on the output of this command:

# /sbin/modprobe --all --set-version=3D"6.0.0-1-amd64" --ignore-install --q=
uiet --show-depends nfs
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/netfs/netfs.ko=20
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/fscache/fscache.ko=20
insmod /lib/modules/6.0.0-1-amd64/kernel/net/sunrpc/sunrpc.ko=20
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs_common/grace.ko=20
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/lockd/lockd.ko=20
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs/nfs.ko=20

This, above, is what the output looked like with versions of nfs-kernel-ser=
ver before 1:2.6.2-1+b1, which didn't ship /lib/modprobe.d/50-nfs.conf.

With the new version of nfs-kernel-server, the output becomes:

# /sbin/modprobe --all --set-version=3D"6.0.0-1-amd64" --ignore-install --q=
uiet --show-depends nfs
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/netfs/netfs.ko=20
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/fscache/fscache.ko=20
install /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && { /sbin/sys=
ctl -q --pattern sunrpc --system; exit 0; }=20
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs_common/grace.ko=20
install /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && { /sbin/sysc=
tl -q --pattern fs.nfs.n[sl]m --system; exit 0; }=20
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs/nfs.ko=20

This confuses manual_add_modules() from /usr/share/initramfs-tools/hook-fun=
ctions, which expects to only see insmod lines, not install lines here.

I thought --ignore-install was completely broken, but no, because without i=
t, the output contains *more* "install" lines:

# /sbin/modprobe --all --set-version=3D"6.0.0-1-amd64" --quiet --show-depen=
ds nfs
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/netfs/netfs.ko
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/fscache/fscache.ko
install /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && { /sbin/sys=
ctl -q --pattern sunrpc --system; exit 0; }
insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs_common/grace.ko
install /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && { /sbin/sysc=
tl -q --pattern fs.nfs.n[sl]m --system; exit 0; }
install /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && { /sbin/sysctl=
 -q --pattern fs.nfs --system; exit 0; }

If the /lib/modprobe.d/50-nfs.conf shipped by nfs-kernel-server is valid, t=
hen modprobe --ignore-install doesn't handle it correctly; if it's invalid,=
 then I suppose modprobe should print an error. There seems to be a problem=
 with modprobe either way, unless initramfs-tools misunderstands the purpos=
e of --ignore-install.

Best regards,

Andr=C3=A1s

-- System Information:
Debian Release: bookworm/sid
  APT prefers stable-security
  APT policy: (500, 'stable-security'), (350, 'unstable'), (1, 'experimenta=
l')
merged-usr: no
Architecture: amd64 (x86_64)
Foreign Architectures: i386

Kernel: Linux 5.17.15-caeeng (SMP w/8 CPU threads; PREEMPT)
Kernel taint flags: TAINT_PROPRIETARY_MODULE, TAINT_OOT_MODULE, TAINT_UNSIG=
NED_MODULE
Locale: LANG=3Den_US.UTF-8, LC_CTYPE=3Dhu_HU.UTF-8 (charmap=3DUTF-8), LANGU=
AGE=3Den_US.UTF-8
Shell: /bin/sh linked to /bin/dash
Init: runit (via /run/runit.stopit)
LSM: AppArmor: enabled

--=20
 Perl: The only language that looks the same before and after RSA encryptio=
n.

----- End forwarded message -----
----- Forwarded message from Marco d'Itri <md@Linux.IT> -----

=46rom: Marco d'Itri <md@Linux.IT>
To: Andras Korn <korn-debbugs@elan.rulez.org>, 1022172@bugs.debian.org,
	initramfs-tools@packages.debian.org, nfs-utils@packages.debian.org
Subject: Bug#1022172: /lib/modprobe.d/50-nfs.conf causes initramfs-tools to
	stop including sunrpc module for nfs

On Oct 21, Andras Korn <korn-debbugs@elan.rulez.org> wrote:

> I thought --ignore-install was completely broken, but no, because without=
 it, the output contains *more* "install" lines:
What you are actually seeing is that --ignore-install is applied only to=20
the nfs module (the one which you have requested to load) but not to its=20
own dependencies:

diff -U 0 <(modprobe --all --set-version=3D"6.0.0-1-amd64" --ignore-install=
 --quiet --show-depends nfs) <(modprobe --all --set-version=3D"6.0.0-1-amd6=
4" --quiet --show-depends nfs)

I am not sure if this is a bug or a feature, so this should be discussed=20
with the upstream maintainer.

So the possible solutions are:
- the semantics of --ignore-install are changed upstream (this may take=20
  some time)
- initramfs-tools learns to parse the install directives
- nfs-kernel-server uses a different design

No matter what happens to --ignore-install I suggest that=20
nfs-kernel-server will replace the modprobe configuration with some udev=20
rules like this one (untested):

ACTION=3D=3D"add", SUBSYSTEM=3D=3D"module", KERNEL=3D=3D"sunrpc", \
  RUN+=3D"/sbin/sysctl -q --pattern sunrpc --system"

--=20
ciao,
Marco



----- End forwarded message -----

--=20
ciao,
Marco

--xDC5ayWp294bP9Gj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQnKUXNg20437dCfobLPsM64d7XgQUCY1MOqwAKCRDLPsM64d7X
gZ4XAP9HTDNt9Sloy+KjH2ToLyCQ2Fbtz8fTKMybdsN9QyiEQwEAj+korFv/YIbb
t8JSm5OD/Dkt+Ck7MrfKMWCTA+WKQwA=
=cLcX
-----END PGP SIGNATURE-----

--xDC5ayWp294bP9Gj--
