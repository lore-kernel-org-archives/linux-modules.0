Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4A42AB1
	for <linux-modules@vger.kernel.org>; Sun, 29 Sep 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727604991; cv=none; b=rEANEbfoVGroykspH12uL+7SSG5DCytMRAx/BKvsNK473kc+z8ulHFJQfMQngWr44k9hbU5zJ1HMeDfeIwh3cosq7CqKmHM5AMGUd2VtIyWrlVrw8/dePcU2AtCnXkFyc6dPPfKy/OkT9FHRQVFaVv85Zu3qhEfZa1txErybCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727604991; c=relaxed/simple;
	bh=960s5fbq1GFJL8yfTM/8HsqYsM6nGEjEr+1kmSWqrXI=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=tm9dqgOgsMKGUO70E+X6DLfxCgFTyT8a37KJ4o9emQIbLY7poh3iggohp6UKoCXFsXCPRKwQoZ1dAYyaQ9Sn+c3k68g439JU/TxmuP4w/IoyYu0scPjx+4GoBvcv/Ui2Fy6VSY65FzHtT5jgykV3StmZEGwo6eGBmJmG2AgWD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b=i1YRMwgH; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helgefjell.de header.i=@helgefjell.de header.b="i1YRMwgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helgefjell.de;
	s=selector.helgefjell; t=1727604680;
	bh=dfeiXyZYCqh5yWxGfZZDZYyLJQpqReGwBNSnSdrHVT8=;
	h=Date:From:To:Subject;
	b=i1YRMwgH6OEFHeiw6iN4WaUmDDvIc/EWcu0DF4t/O44plpGedmJ81d1lvVYzNA4aw
	 pd1+7nsm13AuuywN7N3ROCVS72mRTFOrKpIwYp5r9V5M01XuKEhllYgO0MjwGzL81b
	 FncGKzwblbaKNPOUimAlhV0sAHtpx3Q/aLepVqaadurnhNfXAYq9EZhl4RdXarATwN
	 rwdPQztuV1B/QW6OSVIwqGS5IvhgfSGUOtaqJuL2fopGoWSovRShFAlYbXQkIrfG3n
	 kEJovNDdpb+pSlteuF+BQx/37oWnFrHnl49sp83mLOnXWpT7T8PK/b3evxkVYUwsVk
	 Kv62Bw2TPzHmw==
Original-Subject: Issues in man pages of kmod
Author: Helge Kreutzmann <debian@helgefjell.de>
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 0000000000020109.0000000066F927C8.002CD290; Sun, 29 Sep 2024 10:11:20 +0000
Date: Sun, 29 Sep 2024 10:11:20 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: linux-modules@vger.kernel.org
Subject: Issues in man pages of kmod
Message-ID: <ZvknyLKvQeBo16n9@meinfjell.helgefjelltest.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-2937488-1727604680-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-2937488-1727604680-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear kmod maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including kmod) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
the latest upstream version once in a while, so the error might be
already fixed. We apologize and ask you to close the issue immediately
if this should be the case, but given the huge volume of projects and
the very limited number of volunteers we are not able to double check
each and every issue.

Secondly we translators see the manpages in the neutral po format,
i.e. converted and harmonized, but not the original source (be it man,
groff, xml or other). So we cannot provide a true patch (where
possible), but only an approximation which you need to convert into
your source format.

Finally the issues I'm reporting have accumulated over time and are
not always discovered by me, so sometimes my description of the
problem my be a bit limited - do not hesitate to ask so we can clarify
them.

I'm now reporting the errors for your project. If future reports
should use another channel, please let me know.
Man page: insmod.8
Issue:    insmod -h says: insmod [options] filename [args]

"B<insmod> [I<filename>] [I<module options>.\\&.\\&.\\&]"
--
Man page: insmod.8
Issue:    useB< modprobe>(8) =E2=86=92 use B<modprobe>(8)

"B<insmod> is a trivial program to insert a module into the kernel.\\& Most=
 "
"users will want to useB< modprobe>(8) instead, which is more clever and ca=
n "
"handle module dependencies.\\&"
--
Man page: insmod.8
Issue:    the B<dmesg> =E2=86=92 B<dmesg>(1)

"Only the most general of error messages are reported: as the work of tryin=
g "
"to link the module is now done inside the kernel, the B<dmesg> usually giv=
es "
"more information about errors.\\&"
--
Man page: insmod.8
Issue:    B<modinfo>(8)  B<depmod>(8) =E2=86=92 B<modinfo>(8), B<depmod>(8)

"B<modprobe>(8), B<rmmod>(8), B<lsmod>(8), B<modinfo>(8) B<depmod>(8)"
--
Man page: lsmod.8
Issue:    /proc/modules =E2=86=92 I</proc/modules>

"B<lsmod> is a trivial program which nicely formats the contents of the /pr=
oc/"
"modules, showing what kernel modules are currently loaded.\\&"
--
Man page: rmmod.8
Issue:    Missing commas?

"B<-v> B<--verbose>"

"B<-f> B<--force>"

"B<-s> B<--syslog>"

"B<-V> B<--version>"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-2937488-1727604680-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmb5J8gACgkQQbqlJmgq
5nAr2g//bAdCOC8TSLyiGeTidOYOlHrSdWUx1G38Zo2usMvTwxN0MKk4g+QCPCUE
OkQ1ZqOB5nW9AAeQTqRzUX8Z4ecETorhrf76rDVmq5ZuGS43aZ+w6C0z+D4qbztK
O9q5Ydo20kxlMo5rdD2yVQ+ZG8RA3FBQpAs17jmgV42kKQ11Y9N9jbidBj1+qlFr
u27P86gK1nK3jIAFzyltVpjJRMDVUnPjSii0gzQVmbCeQm4dzhSWElpuMUQXRo7J
kNw4X4S/5oVRPZCytHJJlefOJAWItrCOac2C0QOQ25sN/YHykZQrd+ysfnFrs9Om
o5HpSu21gmWfyNKxOb4H3DausTl9wpPGCTS5l2Br05WiXRU6cHDv8spfs857YhMN
5z1Q1bnfg4QgC725Opjsby82hBMXZ4ckL5SxBw4Uw1VlMFAjMM3J4WN8EnadYbeA
gR4PJyGEMThyHnUCH/JZ8z99q8sWOW5a7URA+9JzVEWYybi/F9aIMEha8lHLn4J7
6ahhcV3GFaLAYO/J6yjS5Ms5oVvwpyaBeTDbXx7cPOnO8lgQP1EtyoByrpLwdYZU
KgNOdSfiCVWbvjLUzGzVEmOqat6oVD3I/bRO2IpGpVY9uTiTF5s0Io763aVzUodz
PEUZNiJmDEIaVmPuOIDdHk42RhZTe6TNgPSrjfPBmhQMIth6NF8=
=sBoU
-----END PGP SIGNATURE-----

--=_meinfjell-2937488-1727604680-0001-2--
